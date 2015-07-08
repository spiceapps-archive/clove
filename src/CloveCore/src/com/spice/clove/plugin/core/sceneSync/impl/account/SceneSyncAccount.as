package com.spice.clove.plugin.core.sceneSync.impl.account
{
	import com.architectd.service.calls.IServiceCall;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallCloveDataOptionViewControllerType;
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncHelper;
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPlugin;
	import com.spice.clove.plugin.core.sceneSync.impl.account.settings.SceneSyncAccountSettings;
	import com.spice.clove.plugin.core.sceneSync.impl.account.views.menu.CloveFavoritesMenuOptionViewController;
	import com.spice.clove.plugin.core.sceneSync.impl.models.SceneSyncPluginModelLocator;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveService;
	import com.spice.clove.plugin.core.sceneSync.impl.service.events.CloveServiceEvent;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncablePluginType;
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	
	import flash.display.Scene;
	import flash.events.Event;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;

	public class SceneSyncAccount extends AbstractServiceAccount
	{
		public static const TIMEOUT:int = 10000;//*10*1000*60;//10 seconds for no5
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _service:CloveService;
		private var _settings:SceneSyncAccountSettings;
		private var _helper:SceneSyncHelper;
		private var _plugin:SceneSyncPlugin;
		private var _saveTimeout:int;
		private var _model:SceneSyncPluginModelLocator = SceneSyncPluginModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncAccount()
		{
			super((_settings = new SceneSyncAccountSettings()));
			
			this._saveTimeout = -1;
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function initialize(value:AbstractServicePlugin):void
		{
			super.initialize(value);
			
			_plugin = SceneSyncPlugin(value);
			
			
			flash.utils.setTimeout(initialize2,1);
			
			
			
		}
		
		/**
		 */
		
		public function getCurrentScene():SceneData
		{
			return this.getService().settings.getCurrentScene();
		}
		
		/**
		 */
		
		public function initialize2():void
		{
			this.getService();
			
			this._plugin.getSceneSyncMenu().setAccount(this);
			
			
			_helper = new SceneSyncHelper(_plugin,this.getService());
			this._helper.addEventListener(FaultEvent.FAULT,onSceneSyncError);
			_service.createScreenIfNone();
			this.getAllScenes();
			
			this.setName(this._service.settings.getUsername().getData());
			
			
			
			//give some time before checking the server
			flash.utils.setTimeout(_service.getLatestSync,5000,false);
			
		}
		
		
		/**
		 */
		
		public function setCurrentScene(value:SceneData):void
		{
			this.sendToServerIfChange();
			
			this._service.settings.setCurrentScene(value);
			this.dispatchSceneSwitchedProxyCall();
		}
		
		/**
		 */
		
		public function getService():CloveService
		{
			if(!_service)
			{
				_service = new CloveService(this._settings);
				_service.addEventListener(CloveServiceEvent.NEW_SYNC,onNewSync);
				_service.addEventListener(CloveServiceEvent.GET_ALL_SCENES,onGetAllScenes);
				_service.addEventListener(CloveServiceEvent.SCENE_CREATED,onSceneCreated);
				_service.addEventListener(CloveServiceEvent.ERROR,onServiceError);
			}
			return this._service;
		}
		
		/**
		 */
		
		public function getAllScenes():void
		{
			this._service.getAllScenes()
		}
		
		
		/**
		 */
		
		public function sendToServer():IServiceCall
		{
			flash.utils.clearTimeout(this._saveTimeout);
			
			this._saveTimeout = -1;
			
			
			return this._service.addSync(ByteArray(this._helper.packSceneSync()));
			
		}
		
		/**
		 */
		
		public function sendToServerIfChange():void
		{
			if(this._saveTimeout == -1)
				return;
			
			this.sendToServer();
		}
		
		
		/**
		 */
		
		public function readyToSendChange():void
		{
			
			//keeping this here for now. if the user IS making changes, we can assume
			//they're doing a bit more than adding a column, they may be adding a SET of feeds.
			
			clearTimeout(_saveTimeout);

			flash.utils.clearTimeout(_saveTimeout);
			
			_saveTimeout = flash.utils.setTimeout(sendToServer,TIMEOUT);
			
				
		}
		/**
		 */
		
		public function createNewScene(name:String):void
		{
			this.sendToServerIfChange();  
			this._service.createScene(name);
		}
		
		/**
		 */
		
		public function deleteCurrentScene():void
		{
			this._service.deleteCurrentScene();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onSceneSyncError(event:FaultEvent):void
		{
			ProxyCallUtils.quickCall(CallAppCommandType.SHOW_ALERT,this.getPluginMediator(),SceneSyncPlugin.SCENE_SYNC_ERROR_MSG);
		}
		
		/**
		 */
		
		private function onServiceError(event:CloveServiceEvent):void
		{
			ProxyCallUtils.quickCall(CallAppCommandType.SHOW_ALERT,this.getPluginMediator(),event.message);
		}
		/**
		 */
		
		private function resetTimeout():void
		{
			this._saveTimeout = -1;
			
		}
		/**
		 */
		
		protected function onGetAllScenes(event:CloveServiceEvent):void
		{
			
			_model.scenes.source = event.data;
			
			this._plugin.getSceneSyncMenu().update(event.data);
			
			if(event.data.length == 0)
			{
			 	this.createNewScene("Personal");
			}
		}
		
		/**
		 */
		
		private function onSceneCreated(event:CloveServiceEvent):void
		{
			this.dispatchSceneSwitchedProxyCall();
		}
		/**
		 */
		
		protected function dispatchSceneSwitchedProxyCall():void
		{
			
			ProxyCallUtils.quickCall(CallSceneSyncablePluginType.SCENE_SYNC_SWITCHED,this._plugin.getPluginMediator());
		}
		
		protected function onNewSync(e:CloveServiceEvent):void
		{
			this._helper.loadSync(e.data,CallSceneSyncablePluginType.SCENE_SYNC_READ_EXTERNAL);
		}
		
		
		
		
	}
}