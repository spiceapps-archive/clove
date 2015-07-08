package com.spice.clove.plugin.core.root.impl
{
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.ColumnHistoryController;
	import com.spice.clove.plugin.column.GroupColumn;
	import com.spice.clove.plugin.column.HolderColumn;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.calls.data.SceneSyncData;
	import com.spice.clove.plugin.core.content.control.ICloveContentControllerFactory;
	import com.spice.clove.plugin.core.root.impl.content.control.IViewableContentController;
	import com.spice.clove.plugin.core.root.impl.content.control.RootContentControllerType;
	import com.spice.clove.plugin.core.root.impl.history.ConcreteColumnHistory;
	import com.spice.clove.plugin.core.root.impl.models.CloveRootModelLocator;
	import com.spice.clove.plugin.core.root.impl.responders.CloveRootPluginProxyResponder;
	import com.spice.clove.plugin.core.root.impl.settings.CloveRootPluginSettings;
	import com.spice.clove.plugin.core.root.impl.sync.ColumnSynchronizer;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.root.core.calls.CallRootPluginType;
	import com.spice.clove.root.core.calls.data.AddRootPluginColumnData;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncPluginType;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncablePluginType;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	
	public class CloveRootPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _saveTimeout:int;
		private var _rootColumn:ClovePluginColumn;
		private var _historyController:ColumnHistoryController;
		private var _historyControllers:Object = {};
		private var _responder:CloveRootPluginProxyResponder;
		
		private var _remergeQueue:Vector.<int>;
		
		private var _rootView:*;
		
		protected var _model:CloveRootModelLocator = CloveRootModelLocator.getInstance();
		
		protected var _settings:CloveRootPluginSettings;
		private var _sync:ColumnSynchronizer;
		
		
		public static const SAVE_INTERVAL:int = 2000;
		public static const LOAD_GROUP_INTERVAL:int = 60000; //15 seconds
		
		public static const MAX_BACKUP_STEPS:int = 30;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveRootPlugin(factory:ClovePluginFactory,
										contentControllerFactory:ICloveContentControllerFactory,
										history:ColumnHistoryController,
										settings:CloveRootPluginSettings = null,
										proxyResponder:CloveRootPluginProxyResponder = null)
		{
			
			_sync = new ColumnSynchronizer(this);
			
			_model.rootPlugin = this;
			
			_settings = settings || new CloveRootPluginSettings();
			_responder = proxyResponder || new CloveRootPluginProxyResponder();
			
			super("Root","com.spice.clove.plugin.core.root",_settings,factory);
			
			
			this.setContentControllerFactory(contentControllerFactory);
			
			_historyController = history;
			
			
		}
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallRootPluginType.ROOT_PLUGIN_ADD_GROUP_COLUMN:return this.addGroupColumn(call.getData());
				case CallRootPluginType.ROOT_PLUGIN_ADD_COLUMN: return this.addColumn(call.getData());
				case CallRootPluginType.OPEN_INTERNAL_HTML_WINDOW: return this.notifyBoundObservers(call); //pass thru
				case CallRootPluginType.ROOT_PLUGIN_ADD_HEADER_VIEW: this._model.headerViews.addItem(call.getData()); return;
				case CallRootPluginType.ROOT_PLUGIN_ADD_FOOTER_BUTTON: this._model.footerViews.addItem(call.getData()); return;
				case CallRootPluginType.REFRESH_ALL_FEEDS: return this.refreshAllFeeds(); 
				case CallSceneSyncablePluginType.SCENE_SYNC_GET_FILTER_VIEW_CONTROLLER: return this.respond(call,this.getFilterViewController());
				case CallSceneSyncablePluginType.SCENE_SYNC_GET_INSTALLER_VIEW_CONTROLLER: return this.respond(call,this.getSceneSyncInstallerViewController());
			}  
			
			super.answerProxyCall(call);
		}
		
		/**
		 */
		
		public function refreshAllFeeds():void
		{
			this._rootColumn.loadNewerContent();
		}
		
		
		/**
		 * cached history controllers so we can get the proper item renderers for data. NOTE: 
		 * this probably shouldn't be here....
		 * @param id
		 * @return 
		 * 
		 */		
		
		public function getHistoryController(id:String):ConcreteColumnHistory
		{
			return this._historyControllers[id];
		}
		
		/**
		 */
		
		public function setHistoryController(id:String,value:ConcreteColumnHistory):void
		{
			this._historyControllers[id] = value;
		}
		
		/**
		 */
		
		public function removeHistoryController(id:String):ConcreteColumnHistory
		{
			var value:ConcreteColumnHistory = this._historyControllers[id];
			this._historyControllers[id] = undefined;
			
			//the item STILL exists, so we need to delete it
			delete(this._historyControllers[id]);
			return value;
		}
		
		/**
		 */
		
		public function getRootColumn():ClovePluginColumn
		{
			return this._rootColumn;
		}
		
		/**
		 */
		
		public function getRootPluginSettings():CloveRootPluginSettings
		{
			return _settings;
		}
		
		
		/**
		 */
		public function hasDeletedColumn(uid:String):Boolean
		{
			return _settings.getTrashedColumnUIDs().hasString(uid);
		}
		
		/**
		 */
		
		public function removeDeletedColumnHistory(uid:String):void
		{
			this._settings.getTrashedColumnUIDs().removeString(uid);
		}
		
		/**
		 */
		
		public function removeAllHistory():void
		{
			if(this._rootColumn)
			{
				this._rootColumn.removeAllHistory();
			}
		}
		
		/**
		 */
		
		public function initRootColumn():void
		{
			
			
			
			_rootColumn.setHistoryController(this._historyController);
			
			
			_model.rootContentController = IViewableContentController(_rootColumn.controller);
			
			
			_rootColumn.addEventListener(CloveColumnEvent.CHANGE,onColumnChange);
			_rootColumn.addEventListener(CloveColumnEvent.ADD_DELETE_COL_UID,this.onAddDeletedColUID);
			_rootColumn.addEventListener(CloveColumnEvent.REMOVE_DELETE_COL_UID,this.onRemoveDeletedColUID);
			
			//is RootColumnViewController
			
			if(!_rootView)
			{
				_rootView = ObjectPoolManager.getInstance().getObject(this._model.rootContentController.viewController.viewClass);
				this.setApplicationView(_rootView);
			}
			_rootView.data = this._model.rootContentController.viewController;
			
			
			//finally, load the clove content, but wait a bit so the app doesn't chug under the load
			
			if(this.isSelfLoading())
			flash.utils.setTimeout(this.refreshAllFeeds,3000);
			
		}
		
		private var _loadSelectectGroupInt:int;
		
		/**
		 */
		
		override public function startStopSelfLoading(value:Boolean):void
		{
			super.startStopSelfLoading(value);
			
			flash.utils.clearInterval(this._loadSelectectGroupInt);
			
			//if we're starting up the self loader, then that means ALL other plugins are managing their own feeds.
			//don't bother loading the selected group
			if(value)
				return;
			
			//create an interval for loading the selected group, every second
			this._loadSelectectGroupInt = flash.utils.setInterval(this.refreshAllFeeds,LOAD_GROUP_INTERVAL);
			    
		}
		
		
		/**
		 */
		
		public function createRootColumn(blank:Boolean = false,
										 column:ClovePluginColumn = null,
										 initialize:Boolean = false):void
		{
			if(_rootColumn)
			{
				_rootColumn.removeEventListener(CloveColumnEvent.ADD_DELETE_COL_UID,onAddDeletedColUID);
				_rootColumn.removeEventListener(CloveColumnEvent.REMOVE_DELETE_COL_UID,onRemoveDeletedColUID);
				_rootColumn.removeEventListener(CloveColumnEvent.CHANGE,onColumnChange);
			}
			
			if(column)
			{
				this._rootColumn = column;
			}
			else
				if(!blank && this._settings.hasRootColumn())
				{
					try
					{
						_rootColumn = _settings.readColumn();
						
						
						//if the root column doesn't have ANY children, there is a storng possibility
						//an exception was thrown when saving the columns. In that case, we load a backup
						if(_rootColumn.children.length == 0)
						{
//							this.loadBackup();	
						}
						
					}catch(e:Error)
					{
						
						Alert.show(e+"");
						Logger.logError(e);
						
						
						//if an error has occurred, then load a backup copy
//						this.loadBackup();
					}
				}
				else
				{
					initRoot();
				}  
			
			if(initialize)
			{
				initRootColumn();
			}
		}
		
		/**
		 */
		
		public function removeRootColumn():void
		{
			if(_rootView)
				_rootView.data = null;
		}
		
		
		
		
		/**
		 */
		
		public function getIncrementalUID():int
		{
			return this._settings.getIncrementalUID();
		}
		
		
		/**
		 */
		
		public function addColumn(data:AddRootPluginColumnData):void
		{
			
		}
		
		/**
		 */
		
		public function addGroupColumn(data:AddRootPluginColumnData):void
		{
			var group:GroupColumn = new GroupColumn(data.getController());
			
			for each(var child:AddRootPluginColumnData in data.getChildren())
			{
				var holder:HolderColumn = new HolderColumn();
				
				
				holder.children.addItem(new ClovePluginColumn(child.getController()));
				group.children.addItem(holder);
			}
			
			
			
			this._rootColumn.children.addItem(group);
			
		}
		
		
		/**
		 */
		
		public function remergeScene(id:int):void
		{
			
			
			
			//we can only merge content on application initialized, because the Root column can inly
			//be instantiated when all plugins are present. this should be changed in later versions so the
			//root column has an INIT property
			if(!this.getApplicationInitialized())
			{
				if(!this._remergeQueue)
				{
					this._remergeQueue = new Vector.<int>();
				}
				
				if(this._remergeQueue.indexOf(id) == -1)
				{
					this._remergeQueue.push(id);
				}
				return;
			}
			var data:ByteArray = this._settings.getRecentSceneData(id);
			
			//if the scene data doesn't exist, then refresh the subscriptions
			if(!data)
			{
				//refresh the subscriptions
				ProxyCallUtils.quickCall(CallSceneSyncPluginType.SCENE_SYNC_REFRESH_SUBSCRIPTION,this.getPluginMediator());
				return;
			}
			
			data.position = 0;
			
			
			this._sync.merge(new SceneSyncData(id,data));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		protected function getFilterViewController():ICloveDataViewController
		{
			return null;//abstract
		}
		
		/**
		 */
		
		protected function getSceneSyncInstallerViewController():ICloveDataViewController
		{
			return null//abstract
		}
		
		/**
		 */
		
		override protected function sceneSyncWriteExternal(output:IDataOutput):void
		{
			saveRootColumn();
			this._settings.writeExternal(output);
		}
		
		/**
		 */
		
		override protected function sceneSyncReadExternal(input:SceneSyncData):void
		{
			this._settings.readExternal(input.getData());
			
			this.createRootColumn(false,null,true);
		}
		
		/**
		 */
		
		override protected function sceneSyncReadSubscribedExternal(input:SceneSyncData):void
		{
			
			this._settings.setRecentSceneData(input);
			
			this._sync.merge(input);
			
			
			
			flash.utils.setTimeout(this.refreshAllFeeds,6000);
			
			//DO NOT load everything. this slow the app down significantly, and makes useless calls
		}
		
		/**
		 */
		
		
		
		/**
		 */
		
		override protected function sceneSyncReadUnsubscribedExternal(input:SceneSyncData):void
		{
			this._sync.split(input);
		}
		
		
		/**
		 */
		
		override protected function sceneSyncSwitched():void
		{
			
			////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//we don't want any conflicts when switching scenes, because the ID of the column
			//is used to determine what data needs to be pulled. To fix this issue, we dump
			//ALL history when switching scenes
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			
			this.removeAllHistory();
			this.createRootColumn(true,null,true);
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			//we don't want to expose the content controller for this plugin
			this.removeAvailableCall(CallClovePluginType.GET_AVAILABLE_CONTENT_CONTROLLERS);
			
			this.addAvailableCalls([CallRootPluginType.ROOT_PLUGIN_ADD_COLUMN,
				CallRootPluginType.ROOT_PLUGIN_ADD_GROUP_COLUMN,
				CallRootPluginType.ROOT_PLUGIN_ADD_HEADER_VIEW,
				CallRootPluginType.ROOT_PLUGIN_ADD_FOOTER_BUTTON,
				CallRootPluginType.OPEN_INTERNAL_HTML_WINDOW,
				CallRootPluginType.REFRESH_ALL_FEEDS,
				CallSceneSyncablePluginType.SCENE_SYNC_GET_FILTER_VIEW_CONTROLLER,
				CallSceneSyncablePluginType.SCENE_SYNC_GET_INSTALLER_VIEW_CONTROLLER]);
		}
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			
			
			
			//make a call 
			
			this._responder.initialize(this.getPluginMediator());
			
			this.createRootColumn(false,null,true);
			
			
			super.applicationInitialized();
			
			
			
			if(this._remergeQueue)
			{
				flash.utils.setTimeout(appInitRemerge,1000);
			}
			
		}
		
		
		
		
		/**
		 */
		
		private function appInitRemerge():void
		{
			
			for each(var id:int in this._remergeQueue)
			{
				this.remergeScene(id);
			}
			this._remergeQueue = null;
			
		}
		
		
		
		
		/**
		 */
		
		protected function setApplicationView(view:DisplayObject):void
		{
			ProxyCallUtils.quickCall(CallAppCommandType.SET_APP_VIEW,this.getPluginMediator(),view);
		}
		
		
		
		/** 
		 * loads a backup from disc if anything goes wrong
		 */		
		protected function loadBackup():void
		{
			return;
			
			var i:int = 0;
			
			while(this._rootColumn.children.length == 0 && 
				 i++ < MAX_BACKUP_STEPS &&
				ProxyCallUtils.getFirstResponse(CallSceneSyncPluginType.SCENE_SYNC_READ_BACKUP,this.getPluginMediator()))
			{
				Logger.log("loading backup try number="+i,this);
			}
			
			
			//initialize the root if nothing else
			if(this._rootColumn.children.length == 0)
			{
				this.initRoot();
			}
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function initRoot():void
		{
			
			
			this._model.rootContentController = IViewableContentController(this.getContentControllerFactory().getNewContentController( RootContentControllerType.ROOT_CONTENT_CONTROLLER));
			//this._model.rootColumnController.pluginController = super.controller;
			
			_rootColumn = new ClovePluginColumn(this._model.rootContentController);
		}
		
		/**
		 */
		
		private function onAddDeletedColUID(event:CloveColumnEvent):void
		{
			this._settings.addTrashedColumnUID(event.data);
			this.triggerSyncChange();
		}
		
		/**
		 */
		
		private function onRemoveDeletedColUID(event:CloveColumnEvent):void
		{
			this._settings.getTrashedColumnUIDs().removeString(event.data);
			
			this.triggerSyncChange();
		}
		
		
		
		
		/**
		 */
		
		
		private function onColumnChange(event:CloveColumnEvent):void
		{
			
			clearTimeout(_saveTimeout);
			
			//we save after one second so that any additional meta-data/changes in bulk don't flood the processor.
			//we don't need to save everytime an event is caught
			_saveTimeout = flash.utils.setTimeout(this.saveRootColumn,SAVE_INTERVAL);
			
		}
		
		
		/**
		 */
		
		private function triggerSyncChange():void
		{
			
			ProxyCallUtils.quickCall(CallSceneSyncPluginType.SCENE_SYNC_TRIGGER_READY,this.getPluginMediator());
		}
		
		/*
		*/
		
		private function saveRootColumn():void
		{			
			
			if(!this._rootColumn)
				return;
			
			Logger.log("Save Root Column",this);
			clearTimeout(_saveTimeout);
			
			this._settings.saveColumn(_rootColumn);	
		}
		
	}
}