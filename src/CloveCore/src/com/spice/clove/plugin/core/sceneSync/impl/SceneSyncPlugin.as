
package com.spice.clove.plugin.core.sceneSync.impl
{
	import com.architectd.service.events.ServiceEvent;
	import com.spice.clove.analytics.core.AnalyticsPluginHelper;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallAppMenuType;
	import com.spice.clove.plugin.core.calls.CallCloveDataOptionViewControllerType;
	import com.spice.clove.plugin.core.calls.data.AddRootMenuItemData;
	import com.spice.clove.plugin.core.calls.data.SceneSyncData;
	import com.spice.clove.plugin.core.sceneSync.impl.account.SceneSyncAccount;
	import com.spice.clove.plugin.core.sceneSync.impl.account.content.control.FavoritesContentControllerFactory;
	import com.spice.clove.plugin.core.sceneSync.impl.account.views.menu.CloveFavoritesMenuOptionViewController;
	import com.spice.clove.plugin.core.sceneSync.impl.models.SceneSyncPluginModelLocator;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveService;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.scene.CloveSceneGetAllCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.events.CloveServiceEvent;
	import com.spice.clove.plugin.core.sceneSync.impl.settings.SceneSyncPluginSettings;
	import com.spice.clove.plugin.core.sceneSync.impl.views.menu.SceneSwitcherMenuController;
	import com.spice.clove.plugin.core.sceneSync.impl.views.menu.SceneSyncMenuViewController;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncPluginType;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncablePluginType;
	import com.spice.clove.sceneSync.core.calls.data.SceneSyncShareOnlineCallData;
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.settings.ISettingAccountFactory;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.observer.EventListeningObserver;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	import flash.utils.setInterval;
	
	import mx.rpc.events.FaultEvent;
	
	public class SceneSyncPlugin extends AbstractServicePlugin implements ISettingAccountFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const TIMEOUT_GET_SUBSCRIPTIONS:int = 10*1000*60;//10 minutes
		public static const VERSION:int = 1;
		public static const SCENE_SYNC_ERROR_MSG:String = "Unable to read scene from the server at this time. Please try again later.";
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:SceneSyncPluginModelLocator = SceneSyncPluginModelLocator.getInstance();
		private var _service:CloveService; 
		private var _sceneSelector:SceneSwitcherMenuController;
		private var _settings:SceneSyncPluginSettings;
		protected var _helper:SceneSyncHelper;
		private var _analytics:AnalyticsPluginHelper;
		private var _backupHelper:SceneSyncBackupHelper;
		private var _contentController:FavoritesContentControllerFactory;
		private var _sceneSyncMenuViewController:SceneSyncMenuViewController;
		private var _favoritesMenuViewController:CloveFavoritesMenuOptionViewController;
		protected var _hasInitialSubscriptions:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncPlugin(factory:SceneSyncPluginFactory)
		{
			
			super("Scene Sync","com.spice.clove.plugin.core.sceneSync",factory,(_settings = new SceneSyncPluginSettings(this)));
			
			//scenes synced to users account
			_model.plugin = this;
			
//			_contentController = new FavoritesContentControllerFactory(this);
//			this.setContentControllerFactory(this._contentController);
			
			_helper = new SceneSyncHelper(this,this.getService());  
			_helper.addEventListener(FaultEvent.FAULT,onSceneSyncFault);
			
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_USERNAME:
					new EventListeningObserver(this._service.call(new CloveSceneGetAllCall(null,NaN,call.getData())),call.getObserver(),[CloveServiceEvent.RESULT],onGetSceneCall,true);
				return;
				
				case CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_USER_ID:
					new EventListeningObserver(this._service.call(new CloveSceneGetAllCall(null,call.getData())),call.getObserver(),[CloveServiceEvent.RESULT],onGetSceneCall,true);
				return;
				case CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_EMAIL:
					new EventListeningObserver(this._service.call(new CloveSceneGetAllCall(call.getData())),call.getObserver(),[CloveServiceEvent.RESULT],onGetSceneCall,true);
				return;
				case CallSceneSyncPluginType.SCENE_SYNC_SUBSCRIBE_TO_SCENE:
					this._service.addSubscriptionToCurrentScene(call.getData(),"");
					return;
				case CallSceneSyncPluginType.SCENE_SYNC_UNSUBSCRIBE_FROM_SCENE:
					this._service.removeSubscriptionFromCurrentScene(call.getData());
					return;
				case CallSceneSyncPluginType.SCENE_SYNC_TRIGGER_READY:
					this.readyToSendNewData();
					break;
				case CallSceneSyncPluginType.SCENE_SYNC_GET_SUBSCRIBED_SCENES:
					this.respond(call,this._service.settings.getCurrentScene().subscriptions.source);
					return;
				case CallSceneSyncPluginType.SCENE_SYNC_GENERATE_SHARE_ONLINE_LINK:
					this.generageShareOnlineLink(call.getData());
					return;
				case CallCloveDataOptionViewControllerType.DATA_OPTION_CHILD_VIEW_CONTROLLERS: 
					//commented out for now
					//this.respond(call,this.getFavoritesMenuViewController());
				return;
				case CallSceneSyncPluginType.SCENE_SYNC_REFRESH_SUBSCRIPTION:
					this.getService().getLatestSubscriptionSyncs(true);//grab ANY sync
				return;
				case CallSceneSyncPluginType.SCENE_SYNC_READ_BACKUP: return this.respond(call,this.readLatestBackup());
			}
			
			super.answerProxyCall(call);
		}
		
		
		/**
		 */
		
		override public function addAcount():AbstractServiceAccount
		{
			if(this.getSceneSyncAccount())
				return this.getSceneSyncAccount();
			
			return super.addAcount();
		}
		
		/**
		 */
		
		public function getFavoritesMenuViewController()
		{
			if(!_favoritesMenuViewController)
			{
				_favoritesMenuViewController = new CloveFavoritesMenuOptionViewController(this);
			}
			
			return _favoritesMenuViewController;
		}
		
		
		/**
		 */
		
		public function getSceneSyncMenu():SceneSyncMenuViewController
		{
			if(!this._sceneSyncMenuViewController)
			{
				_sceneSyncMenuViewController = new SceneSyncMenuViewController(this)
			}
			
			return this._sceneSyncMenuViewController;
		}
		
		/**
		 */
		
		public function getSceneSyncAccount():SceneSyncAccount
		{
			return SceneSyncAccount(this.getAccountAt(0));
		}
		
		/**
		 */
		
		public function getLatestSubscriptionSyncs(useAny:Boolean = false):void
		{
			this.getService().getLatestSubscriptionSyncs(useAny);
		}
		/**
		 */
		
		public function getNewServiceAccount():AbstractServiceAccount
		{
			return new SceneSyncAccount();
		}
		
		/**
		 */
		
		override public function removeAccount(value:AbstractServiceAccount):void
		{
			super.removeAccount(value);
			
			this._sceneSyncMenuViewController.setAccount(this.getSceneSyncAccount());
		}
		
		/**
		 */
		
		
		public function getSceneSelector():SceneSwitcherMenuController
		{
			if(!_sceneSelector)
			{
				this._sceneSelector = new SceneSwitcherMenuController(this.getPluginMediator());
			}
			
			return this._sceneSelector;
		}
		
		
		
		/**
		 */
		
		public function subscribeToSceneByEmail(email:String):void
		{
			var call:CloveSceneGetAllCall = this._service.call(new CloveSceneGetAllCall(email));
			
			call.addEventListener(CloveServiceEvent.RESULT,onGetSceneAutoSubscribe,false,0,true);
		}
		
		
		/**
		 */
		
		public function getService():CloveService
		{
			if(!_service)
			{
				_service = new CloveService(this._settings.getPublicServiceSetting());
				_service.addEventListener(CloveServiceEvent.NEW_SUBSCRIPTION_SYNC,onNewSubscriptionSync);
				_service.addEventListener(CloveServiceEvent.GET_UNSUBSCRIBED_SCENE_DATA,onGetUnsubscribedSceneData);
				_service.addEventListener(CloveServiceEvent.ERROR,onServiceError);
			}
			return this._service;
		}
		
		
		/**
		 */
		
		public function getBackupHelper():SceneSyncBackupHelper
		{
			if(!this._backupHelper)
			{
				this._backupHelper = new SceneSyncBackupHelper(this);
			}
			
			return this._backupHelper;
		}
		
		/**
		 */
		
		public function getSyncHelper():SceneSyncHelper
		{
			return this._helper;
		}
		
		/**
		 */
		
		public function getCurrentScene():SceneData
		{
			return this.getAccounts().length > 0 ? this.getSceneSyncAccount().getCurrentScene() : this.getService().settings.getCurrentScene();
		}

		/**
		 */
		
		public function getBanner():StringSetting
		{
			return this._settings.getBanner();
		}
		
		
		/**
		 */
		
		public function readyToSendNewData():void
		{
			if(this.getSceneSyncAccount())
			{
				this.getSceneSyncAccount().readyToSendChange();
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		private var shareRoute:Vector.<int>;
		
		
		/**
		 */
		
		private function onSceneSyncFault(event:FaultEvent):void
		{
			ProxyCallUtils.quickCall(CallAppCommandType.SHOW_ALERT,this.getPluginMediator(),SceneSyncPlugin.SCENE_SYNC_ERROR_MSG);
		}
		
		/**
		 */
	
		protected function readLatestBackup():Boolean
		{
			return false;
		}
		/**
		 */
		
		
		override protected function sceneSyncReadExternal(input:SceneSyncData):void
		{
			//nothing
			this.sceneSyncReadSubscribedExternal(input);
		}
		
		
		/**
		 */
		
//		override protected function getAvailableContentControllers():Vector.<String>
//		{
//			return new Vector.<String>();
//		}
		
		/**
		 */
		
		override protected function sceneSyncWriteExternal(output:IDataOutput):void
		{
			output.writeInt(VERSION);
			
			output.writeUTF(this._settings.getBanner().getData());
		}
		
		/**
		 */
		
		override protected function sceneSyncReadSubscribedExternal(input:SceneSyncData):void
		{
			
			try
			{
				input.getData().readInt();
				this._settings.getBanner().setData(input.getData().readUTF());
			}catch(e:Error)
			{
				Logger.logError(e);
			}
		}
		
		protected function generageShareOnlineLink(data:SceneSyncShareOnlineCallData):void
		{
			this.shareRoute = data.getColumnRoute();
			
			this._service.sharePackedScene(ByteArray(this._helper.packSceneSync())).addEventListener(ServiceEvent.RESULT,onShareOnline);	
		}
		
		protected function onShareOnline(event:ServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onShareOnline);
			
			
			flash.net.navigateToURL(new URLRequest(CloveUrls.GET_SHARE_URL(event.data[0],this.shareRoute)));
		}
		
		/**
		 */
		
		protected function onGetSceneCall(target:EventListeningObserver):*
		{
			var event:CloveServiceEvent = target.getCurrentEvent();
			
			return event.data;
		}
		
		/**
		 */
		
		override protected function initialize():void
		{
			this.getService();
			
			_analytics = new AnalyticsPluginHelper(this.getPluginMediator());
			
			
			flash.utils.setInterval(this._service.getLatestSubscriptionSyncs,TIMEOUT_GET_SUBSCRIPTIONS);  
			this._service.getLatestSubscriptionSyncs();  
			
			
			  
			
			
			
			ProxyCallUtils.quickCall(CallAppMenuType.REGISTER_APP_ROOT_MENU_ITEM,this.getPluginMediator(),new AddRootMenuItemData("Scenes",this.getSceneSyncMenu()));
			
			
			var initialSubscription:String = ProxyCallUtils.getFirstResponse(CallSceneSyncablePluginType.SCENE_SYNC_GET_SUBSCRIPTIONS_BY_EMAIL,this.getPluginMediator());
			
			
			if(initialSubscription)
			{
				_hasInitialSubscriptions = true;
				
				var emails:Array = initialSubscription.split(",");
				
				for each(var email:String in emails)
				{
					_analytics.addStickyTag({brandEmail:email});  
					
					this._service.call(new CloveSceneGetAllCall(email)).addEventListener(CloveServiceEvent.RESULT,onGetSceneAutoSubscribe);
				}
			}
			super.initialize();
		}
		
		
		
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			
			
			
			//register the favorites menu view controller
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//this is here because if it's in the account, and the user REMOVES the account, then we'll get
			//another bookmarks item for each row.
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//			ProxyCallUtils.quickCall(CallCloveDataOptionViewControllerType.DATA_OPTION_CHILD_VIEW_CONTROLLERS,this.getPluginMediator(),this.getFavoritesMenuViewController());
			
		}
		
		/**
		 */
		
		protected function onNewSubscriptionSync(e:CloveServiceEvent):void
		{
			this._helper.loadSync(e.data,CallSceneSyncablePluginType.SCENE_SYNC_READ_SUBSCRIBED_EXTERNAL);
			//			var sync:SyncData = e.data;
			
		}
		
		
		/**
		 */
		
		private function onGetSceneAutoSubscribe(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onGetSceneAutoSubscribe);
			
			var data:Object = event.data;
			
			if(data.length == 0)
			{
				return;
			}
			
			for each(var sd:SceneData in data)
			{
				this._service.addSubscriptionToCurrentScene(sd.id,sd.name);
			}
		}
		
		/**
		 */
		
		private function onServiceError(event:CloveServiceEvent):void
		{
			ProxyCallUtils.quickCall(CallAppCommandType.SHOW_ALERT,this.getPluginMediator(),event.message);
		}
		
		/**
		 */
		
		protected function onGetUnsubscribedSceneData(event:CloveServiceEvent):void
		{
			this._helper.loadSync(event.data,CallSceneSyncablePluginType.SCENE_SYNC_READ_UNSUBSCRIBED_EXTERNAL);
		}
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_USERNAME,
				CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_USER_ID,
				CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_EMAIL,
				CallSceneSyncPluginType.SCENE_SYNC_SUBSCRIBE_TO_SCENE,
				CallSceneSyncPluginType.SCENE_SYNC_TRIGGER_READY,
				CallSceneSyncPluginType.SCENE_SYNC_REFRESH_SUBSCRIPTION,
				CallSceneSyncPluginType.SCENE_SYNC_UNSUBSCRIBE_FROM_SCENE,
				CallSceneSyncPluginType.SCENE_SYNC_GET_SUBSCRIBED_SCENES,
				CallSceneSyncPluginType.SCENE_SYNC_GENERATE_SHARE_ONLINE_LINK,
				CallCloveDataOptionViewControllerType.DATA_OPTION_CHILD_VIEW_CONTROLLERS,
				CallSceneSyncPluginType.SCENE_SYNC_READ_BACKUP]);
		}
		
		
		
		
	}
}