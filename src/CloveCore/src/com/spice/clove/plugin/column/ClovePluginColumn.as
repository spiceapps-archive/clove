package com.spice.clove.plugin.column
{
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.events.ClovePluginEvent;
	import com.spice.clove.plugin.control.ClovePluginController;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallCloveColumnType;
	import com.spice.clove.plugin.core.calls.CallCloveContentControllerType;
	import com.spice.clove.plugin.core.calls.CallClovePluginControllerType;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.notifications.FillColumnNotification;
	import com.spice.clove.plugin.core.root.impl.settings.RootPluginSettingType;
	import com.spice.clove.plugin.core.views.menu.IMenuOptionButtonViewController;
	import com.spice.clove.util.ColumnUtil;
	import com.spice.core.queue.IQueue;
	import com.spice.utils.EmbedUtil;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.flash.observer.SettingObserver;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.lists.ProxyCallList;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.ByteArraySetting;
	import com.spice.vanilla.impl.settings.basic.NumberSetting;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	
	use namespace column_internal;
	
	
	/*
	Columns owned by a particular plugin. If the plugin does not exist the column will be removed 
	@author craigcondon
	
	*/	
	
	public class ClovePluginColumn extends CloveColumn implements IProxyResponder, 
		IProxyBinding
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		/*
		*/
		
		private var _breadcrumb:ClovePluginColumn;
		
		
		/*
		the sleep interval for loading data 
		*/		
		
		private var _sleepInterval:int;
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		//		[Bindable] 
		//		[Setting]
		//		public var columnIcon:StringSetting;
		//		
		//		[Bindable] 
		//		[Setting(min=.25)]
		//		public var refreshRate:Number = 10;
		//		
		//		
		//		
		//		[Bindable] 
		//		[Setting]
		//		public var contentControllerName:String;
		//		
		//		
		//		[Bindable] 
		//		[Setting]
		//		public var pluginUID:String;
		
		
		
		
		public static const MINIMUM_REFRESH:Number = .25;
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _controller:ICloveContentController;
		private var _pluginController:ClovePluginController;
		
		//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		//a temporary, hackish way of detecting whether we're loading older, or newer content.
		//eventually, put this in a cue
		//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		
		private var _loadingOlder:Boolean;
		private var _plugin:IPlugin;
		
		
		//		private var _settingManager:SettingManager;
		//		private var _columnSettingManager:SettingManager;
		
		
		
		/**
		 * visible on roll over 
		 */		
		private var _dataOptionControllers:Vector.<IMenuOptionButtonViewController>;
		
		private var _settings:ISettingTable;
		private var _getFactoryNameProxyCall:ProxyCall;
		private var _getPluginProxyCall:ProxyCall;
		private var _contentControllerProxyCallList:ProxyCallList;
		private var _pluginUninstallBind:ProxyBind;
		
		
		
		//settings
		private var _settColumnIcon:ByteArraySetting;
		private var _settRefreshRate:NumberSetting;
		private var _settContentControllerName:StringSetting;
		private var _settPluginUID:StringSetting;
		private var _settContentController:ByteArraySetting;
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		public function ClovePluginColumn(controller:ICloveContentController = null,type:int = RootPluginSettingType.PLUGIN_COLUMN)
		{
			super(type,null,null);
			
			
			//			this.setMetaData(ColumnMetaData.MAX_ROWS,50);
			
			_sleepInterval   = -1;
			
			this.onRefreshRateChange();
			
			
			ColumnUtil.generateRandomColumnColor(this);
			
			
			
			_contentControllerProxyCallList = new ProxyCallList(this);
			
			//			_pluginProxyCall 			= ProxyCallUtils.makeCallChain([CallClovePluginType.GET_PLUGIN_CONTROLLER,CallClovePluginControllerType.GET_PLUGIN_UID],this,true,this);
			
			
			this.controller = controller;
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		public function get dataOptionControllers():Vector.<IMenuOptionButtonViewController>
		{
			return this._dataOptionControllers;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		[Disposable]
		[Bindable(event="controllerChange")]
		public function get controller():ICloveContentController
		{
			return _controller;
		}
		
		
		/*
		*/
		
		public function set controller(value:ICloveContentController):void
		{
			this.disposeController();
			
			//			if(this.disposed)
			//				return;
			
			
			
			this._controller = value;
			
			if(this._controller)
			{
				this.initController();
			}
			
			this.getProxyTarget().notifyChange(CallCloveColumnType.GET_CONTENT_CONTROLLER,value);
			this.dispatchBubbleEvent(new CloveColumnEvent(CloveColumnEvent.CONTROLLER_CHANGE,this,true,value));
		}
		
		/**
		 */
		
		public function set plugin(value:IPlugin):void
		{
			_plugin = value;
			
			if(!value)
				return;
			
			ProxyCallUtils.quickCall(CallClovePluginType.GET_PLUGIN_CONTROLLER,value.getProxy(),null,this);
			
		}
		
		/**
		 */
		
		public function get plugin():IPlugin
		{
			return this._plugin;
		}
		
		/**
		 */
		
		public function get pluginController():ClovePluginController
		{
			return this._pluginController;
		}
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getIcon():ByteArraySetting
		{
			return this._settColumnIcon;
		}
		
		/**
		 */
		
		public function getContentControllerName():StringSetting
		{
			return this._settContentControllerName;
		}
		
		/**
		 */
		
		public function focus():void
		{
			this.dispatchBubbleEvent(new CloveColumnEvent(CloveColumnEvent.FOCUS,this));
		}
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallCloveColumnType.GET_CONTENT_CONTROLLER: return this.getProxyTarget().respond(call,this.controller);
			}
			
			super.answerProxyCall(call);
		}
		
		/**
		 */
		
		override public function handleProxyResponse(a:INotification):void
		{
			switch(a.getType())
			{
				case CallCloveContentControllerType.GET_NAME: 
					this.title = a.getData(); 
					return;
					
				case CallClovePluginControllerType.GET_PLUGIN:
				case CallCloveContentControllerType.GET_PLUGIN:
					this.plugin = a.getData(); 
					
					if(_pluginUninstallBind)
					{
						
						_pluginUninstallBind.dispose();
					}
					
					_pluginUninstallBind = ProxyCallUtils.bind(this.plugin.getProxy(),this,[CallClovePluginType.PLUGIN_IS_UNINSTALLING],true);
					return;
				case CallClovePluginType.PLUGIN_IS_UNINSTALLING: return this.dispose();
				case CallCloveContentControllerType.GET_ICON_16: return this.setIconFromContentController(a.getData()); 
				case CallCloveContentControllerType.REMOVE_CONTENT: return this.removeAllHistory(a.getData());
				case CallCloveContentControllerType.GET_BREADCRUMB:return this.setBreadcrumb(a.getData());
				case CallCloveContentControllerType.LOADING_CONTENT:return this.loadNewerContent(); 
				case CallCloveContentControllerType.DISPOSED: return this.dispose();
				case CallCloveContentControllerType.RESET_UID:return this.resetUID(); 
				case CallCloveContentControllerType.DISPLAY_ERROR_MESSAGE: 
					this.dispatchEvent(new CloveColumnEvent(CloveColumnEvent.DISPLAY_ERROR_MESSAGE,this,true,a.getData())); 
					return;
				case CallCloveContentControllerType.GET_FACTORY_NAME: 
					this._settContentControllerName.setData(a.getData());
					return;  
				case CallCloveContentControllerType.GET_DATA_OPTION_CONTROLLERS:
					
					_dataOptionControllers = a.getData();
					return;
				case CallCloveContentControllerType.GET_LOADING_STATE:
					if(a.getData() == this.loadState)
						return;
					
					this.loadState = a.getData();
					this.dispatchBubbleEvent(new CloveColumnEvent(CloveColumnEvent.LOAD_STATE_CHANGE,this));
					return;
				case CallCloveContentControllerType.GET_ITEM_RENDERER: 
					this.itemRenderer = a.getData(); 
					return;
				case CallCloveContentControllerType.GET_SETTINGS:
					_settings = a.getData();
					//FIXME: all of this is temprary
					if(this._settContentController.getData() && this._settContentController.getData().bytesAvailable > 0)
					{
						this._settContentController.getData().position = 0;
						
						try
						{
							_settings.readExternal(_settContentController.getData());
						}catch(e:Error)
						{
							Logger.logError(e);
						}
						
						_settContentController.setData(null);
					}
					
					if(!_settingObserver)
					{
						_settingObserver = new SettingObserver();
						_settingObserver.addEventListener(Event.CHANGE,onSettingsChange);
					}
					
					_settingObserver.target = _settings;
					this.onSettingsChange();
					return;
					
				case CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_UID:
				case CallClovePluginType.GET_PLUGIN_CONTROLLER:
					this._pluginController = a.getData();
					
					if(this._plugin != this._pluginController.plugin)
					{
						ProxyCallUtils.quickCall(CallClovePluginControllerType.GET_PLUGIN,this._pluginController.getProxy(),null,this);
					}
					
					ProxyCallUtils.quickCall(CallClovePluginControllerType.GET_PLUGIN_UID,this._pluginController.getProxy(),null,this);
					return;
				case CallClovePluginType.GET_NEW_CONTENT_CONTROLLER:
					this.controller = a.getData();
					return;
					
					
				case CallClovePluginControllerType.GET_PLUGIN_UID:
					this._settPluginUID.setData(a.getData());
					return;
					
				case FillColumnNotification.FILL_COLUMN:
					this.fillColumn(a.getData(),FillColumnNotification(a).saveType(),this._loadingOlder);
					return;
					
					
					
			}
		}
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			this.handleProxyResponse(n);
		}
		
		/*
		*/
		
		public function hasPlugin():Boolean
		{
			return this._plugin != null;
		}
		
		/**
		 */
		
		public function removeAllHistory(removeDeleted:Boolean = false):void
		{
			this.history.removeAllItems(removeDeleted);
		}
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function setIconFromContentController(value:Class):void
		{
			if(value)
				this._settColumnIcon.setData(EmbedUtil.toImageByteArray(value));
		}
		/**
		 */
		
		override protected function setupAvailableProxyCalls():void
		{
			super.setupAvailableProxyCalls();
			
			this.getProxyTarget().addAvailableCalls([CallCloveColumnType.GET_CONTENT_CONTROLLER]);
		}
		/**
		 */
		
		override protected function setColumnInfo(value:SettingTable):void
		{
			
			//			if(_columnSettingManager)
			//			{
			//				_settingManager.dispose();
			//				_columnSettingManager.dispose();
			//			}
			
			
			
			super.setColumnInfo(value);
			
			  
			this._settColumnIcon 			= ByteArraySetting(value.getNewSetting(BasicSettingType.BYTE_ARRAY,"columnIcon"));
			this._settContentControllerName = StringSetting(value.getNewSetting(BasicSettingType.STRING,"contentControllerName"));
			this._settPluginUID 			= StringSetting(value.getNewSetting(BasicSettingType.STRING,"pluginUID"));
			this._settRefreshRate		    = NumberSetting(value.getNewSetting(BasicSettingType.NUMBER,"refreshRate"));
			this._settContentController     = ByteArraySetting(value.getNewSetting(BasicSettingType.BYTE_ARRAY,"contentControllerSettings"));
			
			
			this.title = "Untitled";
			
			
			  
			
			this._settRefreshRate.setData(10);
			//controller metadata
			//			_settingManager = new SettingManager(new ChildSettings(this.metadata,"controllerSettings"));
			//			_columnSettingManager = new SettingManager(this.metadata,null,"ColumnSetting");
			//			_columnSettingManager.ignoreInitSettings = true;
			
			//			this.janitor.addDisposable(this._settingManager);
			//			this.janitor.addDisposable(this._columnSettingManager);
		}
		
		/*
		*/
		
		protected function pasteTextToPost(text:String):void
		{
			new CloveEvent(CloveEvent.COPY_TO_POSTER,text).dispatch();
		}
		
		
		
		
		/*
		*/
		
		protected function onPluginUninstall(event:ClovePluginEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onPluginUninstall);
			
			
			this.disposeIfBlank();
		}
		
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			super.readExternal(input);
			
			if(!this._pluginController || this._pluginController.uid != this._settPluginUID.getData())
			{
				ProxyCallUtils.quickCall(CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_UID,ClovePluginMediator.getInstance(),this._settPluginUID.getData(),this);
				
				if(!this._plugin && this._settPluginUID.getData() != "")
				{
					Logger.log("The plugin with the UID "+this._settPluginUID.getData()+" does not exist",this);
					return;
				}
			}
			
			
			
			
			if(!this._controller && this._settContentControllerName.getData())
			{
				ProxyCallUtils.quickCall(CallClovePluginType.GET_NEW_CONTENT_CONTROLLER,this._plugin.getProxy(),this._settContentControllerName.getData(),this);
			}
		}
		
		
		/*
		*/
		
		private function onRefreshRateChange(event:Event = null):void
		{
			return;
			
			if(_sleepInterval > -1)
				flash.utils.clearInterval(_sleepInterval);
			
			this.janitor.removeIntervalID(_sleepInterval);
			
			if(this._settRefreshRate.getData() < MINIMUM_REFRESH)
			{
				this._settRefreshRate.setData(MINIMUM_REFRESH);
			}
			
			_sleepInterval = flash.utils.setInterval(this.loadNewerContent,this._settRefreshRate.getData()*60*1000);//seconds milliseconds
			
			this.janitor.addIntervalID(_sleepInterval);
			
			
		}
		
		
		
		
		private var _settingObserver:SettingObserver;
		
		/*
		*/
		
		private function initController():void  
		{
			
			if(!this._controller)
				return;
			
			
			this._contentControllerProxyCallList.setProxy(this._controller.getProxy());
			this._contentControllerProxyCallList.call(FillColumnNotification.FILL_COLUMN,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.GET_NAME,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.SET_COLUMN,this,null);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.GET_PLUGIN,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.GET_ICON_16,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.GET_SETTINGS,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.GET_BREADCRUMB,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.REMOVE_CONTENT,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.GET_FACTORY_NAME,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.GET_ITEM_RENDERER,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.DISPLAY_ERROR_MESSAGE,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.DISPOSED,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.GET_LOADING_STATE,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.GET_DATA_OPTION_CONTROLLERS,null,this);
			this._contentControllerProxyCallList.call(CallCloveContentControllerType.RESET_UID,null,this);
			
			//			this.addDisposableEventListener(_controller,FillColumnEvent.FILL_COLUMN,onFillColumn);
			//			this.addDisposableEventListener(_controller,ColumnControllerEvent.SET_ITEM_RENDERER,onSetItemRenderer);
			//			this.addDisposableEventListener(_controller,ColumnControllerEvent.SET_SETTINGS,onControllerSettingsChange);
			//			this.addDisposableEventListener(_controller,ColumnControllerEvent.ADD_MENU_OPTIONS,onAddColumnDataOption);
			//			this.addDisposableEventListener(_controller,ColumnControllerEvent.ADD_CACHED_MESSAGE_HANDLER,onAddCachedMessageHandler);
			//			this.addDisposableEventListener(_controller,ColumnControllerEvent.SET_BREADCRUMB,onSetBreadcrumb);
			//			this.addDisposableEventListener(_controller,ColumnControllerEvent.FOCUS,onControllerFocus);
			//			this.addDisposableEventListener(_controller,ColumnControllerEvent.SET_LOAD_CUE,onSetLoadCue);
			//			this.addDisposableEventListener(_controller,ColumnControllerEvent.ADD_MESSAGE_HANDLER,onAddMessageHandler);
			//			this.addDisposableEventListener(_controller,ClovePluginEvent.LOAD_COLUMNS,onLoadCall);
			//			
			//listen for when the target plugin is removed so we can remove this column as well
			//this.addDisposableEventListener(_controller.pluginController,ClovePluginEvent.UNINSTALL,onPluginUninstall);
		}
		
		
		override public function dispose():void
		{
			this.disposeController();
			
			if(_contentControllerProxyCallList)
			{
				_contentControllerProxyCallList.dispose();
			}
			super.dispose();
		}	
		
		
		private function setBreadcrumb(value:ICloveContentController):void
		{
			if(this._breadcrumb)
			{
				var i:int = this.children.getItemIndex(this._breadcrumb);
				
				if(i > -1)
				{
					this.children.removeItemAt(i);
				}
			}
			
			var p:ClovePluginColumn = this._breadcrumb = new ClovePluginColumn(value);
			p.allowTreeBuilding = false;
			this.children.addItem(p);
			p.loadNewerContent();
			
			
			//focus on the added plugin so we see it in the breadcrumb view
			p.focus();
		}
		
		/**
		 */
		
		private function onSettingsChange(event:Event = null):void
		{	
			var ba:ByteArray = new ByteArray();
			this._settings.writeExternal(ba);
			
			this._settContentController.setData(ba);
		}
		
		/*
		*/
		
		private function disposeController():void
		{
			if(!this._controller)
				return;
			_settContentController.setData(null);
			
			if(_pluginUninstallBind)
			{
				_pluginUninstallBind.dispose();
				_pluginUninstallBind = undefined;
			}
			
			this._contentControllerProxyCallList.setProxy(null);
			
			if(this._controller is IDisposable)
			{
				IDisposable(this._controller).dispose();
			}
			
			if(this._settingObserver)
				this._settingObserver.target = undefined;
			
			
		}
		
		
		/*
		*/
		
		//		private function onControllerSettingsChange(event:*):void
		//		{
		//			this._settingManager.target		  = event.value;
		//			this._columnSettingManager.target = event.value;
		//		}
		
		/*
		*/
		
		private function onSetItemRenderer(event:*):void
		{
			//this.itemRenderer.controllerItemRenderer = event.value;
		}
		
		/*
		*/
		
		/*private function onAddColumnDataOption(event:*):void
		{
		var opts:Array = event.value;
		
		var useable:Array = [];
		
		
		//remove the duplicates
		for each(var opt:Object in opts)
		{
		if(this._menuOption.hasMenuItem(opt.label))
		{
		this._menuOption.removeMenuItem(opt.label);
		}
		}
		
		this._menuOption.addMenuItems(event.value);
		
		}*/
		
		/*
		*/
		
		private function onAddMessageHandler(event:*):void
		{
			//this.itemRenderer.messageHandler.addTextHandler(event.value);
		}
		
		/*
		*/
		
		private function onAddCachedMessageHandler(event:*):void
		{
			//sto
			//this.itemRenderer.cachedMessageHandler.addTextHandler(event.value);
		}
		
		
		/**
		 */
		
		public function loadNewerContent(andChildren:Boolean = true,data:ICloveData = null):void
		{
			
			if(!this.parent)
			{
				var queue:IQueue = ProxyCallUtils.getFirstResponse(CallAppCommandType.GET_GLOBAL_CONTENT_LOADER_QUEUE,this._pluginController.mediator);
				queue.clear();
			}
			
			_loadingOlder = false;
			
			if(this._controller)
			{
				this._contentControllerProxyCallList.call(CallCloveContentControllerType.LOAD_NEWER,data);
			}
			
			if(andChildren)
			{
				for each(var child:ClovePluginColumn in this.children.toArray())
				{
					child.loadNewerContent(andChildren,data);
				}
			}
		}
		
		/**
		 */
		
		public function loadOlderContent(andChildren:Boolean = true,data:ICloveData = null):void
		{
			_loadingOlder = true;
			
			if(this._controller)
			{
				this._contentControllerProxyCallList.call(CallCloveContentControllerType.LOAD_OLDER,data);
			}
			
			if(andChildren)
			{
				for each(var child:ClovePluginColumn in this.children.toArray())
				{
					child.loadOlderContent(andChildren,data);
				}
			}
		}
		
		
		/*
		*/
		
		private function dispatchLoadStateChange():void
		{
			
		}
		
		
		
	}
}
