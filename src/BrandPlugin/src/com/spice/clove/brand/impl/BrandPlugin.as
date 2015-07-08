package com.spice.clove.brand.impl
{
	import com.spice.clove.brand.desktop.views.subscriptions.DesktopSubscriptionsView;
	import com.spice.clove.brand.impl.data.BrandSceneData;
	import com.spice.clove.brand.impl.views.header.BrandHeaderView;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.root.core.calls.CallRootPluginType;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncPluginType;
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.clove.sceneSync.core.service.data.SceneSubscriptionData;
	import com.spice.clove.sceneSync.core.service.settings.CloveServiceSettingType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;

	public class BrandPlugin extends  ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
//		public static const FIFA_USERNAME:String = "fifaUsername";
//		public static const FIFA_EMAIL:String    = "craig@spiceapps.com"
//		public static const FIFA_USER_ID:String  = "496"
			
		private var _getSubscribedCall:ProxyCall;
		private var _loadFIFASubscriptionsCall:ProxyCall;
		private var _brandUsername:String;
			
		
		[Bindable] 
		public var availableSubscriptions:ArrayCollection = new ArrayCollection();
		
		//[Bindable] 
		public var subscribedScenes:Object = {};
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BrandPlugin(name:String,uid:String,brandUsername:String,factory:ClovePluginFactory)
		{
			super(name,uid,new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
			
			this._brandUsername = brandUsername;
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function loadAvailableFIFASubscriptions():void
		{
			if(!_loadFIFASubscriptionsCall)
			{
				_loadFIFASubscriptionsCall = new ProxyCall(CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_USERNAME,this.getPluginMediator(),this._brandUsername,this);
			}
			this._loadFIFASubscriptionsCall.dispatch();
		}
		
		
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_USERNAME:
				case CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_USER_ID:
				case CallSceneSyncPluginType.SCENE_SYNC_GET_SCENES_BY_EMAIL: return this.onGetAvailableScenes(n.getData());
				case CallSceneSyncPluginType.SCENE_SYNC_GET_SUBSCRIBED_SCENES: return this.setSubscribedScenes(n.getData());
			}
			
			super.handleProxyResponse(n);
		}
		
		
		
		/**
		 */
		
		public function subscribeToScene(value:SceneData):void
		{
			ProxyCallUtils.quickCall(CallSceneSyncPluginType.SCENE_SYNC_SUBSCRIBE_TO_SCENE,this.getPluginMediator(),value.id);
		}
		
		/**
		 */
		
		public function unsubscribeFromScene(value:SceneData):void
		{
			ProxyCallUtils.quickCall(CallSceneSyncPluginType.SCENE_SYNC_UNSUBSCRIBE_FROM_SCENE,this.getPluginMediator(),value.id);
		}
		
		/**
		 */
		
		public function getSubscriptionsTitle():String
		{
			return "Subscriptions";
		}
		
		
		/**
		 */
		
		public function getBrandHeader():Class
		{
			return null;
		}
		
		/**
		 */
		
		public function getBrandFiller():Class
		{
			return null;
		}
		
		/**
		 */
		public function getSelectSceneLabel():String
		{
			return "Subscribe to Scene";
		}
		
		public function getSelectSceneMessage():String
		{
			return "What interests you?";
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.finishInitialization();
		}
		
		/**
		 */
		
		override protected function install():void
		{
			super.install();
			
			
			//subscribe to the worldcup scene so we have default columns
			this.subscribeToScene(new SceneData(CloveServiceSettingType.SCENE_DATA,1,this.getSubscriptionsTitle()));
			
			
			flash.utils.setTimeout(openSubscriptions,1000);
			
			
		}
		
		
		/**
		 */
		private function openSubscriptions():void
		{
			DesktopSubscriptionsView.open().plugin = this;
		}
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			var header:BrandHeaderView = new BrandHeaderView();
			header.plugin = this;
			
			ProxyCallUtils.quickCall(CallRootPluginType.ROOT_PLUGIN_ADD_HEADER_VIEW,this.getPluginMediator(),header);

			
			//once we've initialized, we call get the list of available subscriptions from scene sync
			this.loadAvailableFIFASubscriptions();
		}
		
		
		/**
		 */
		
		protected function onGetAvailableScenes(data:Array):void
		{
			var stack:Array = [];
			
			for each(var sd:SceneData in data)
			{
				stack.push(new BrandSceneData(sd));
			}
			
			this.availableSubscriptions.source = stack;
			
			
			if(!this._getSubscribedCall)
			{
				this._getSubscribedCall = new ProxyCall(CallSceneSyncPluginType.SCENE_SYNC_GET_SUBSCRIBED_SCENES,this.getPluginMediator(),null,this,this);
			}
			
			this._getSubscribedCall.dispatch();
		}
		
		/**
		 */
		
		protected function setSubscribedScenes(data:Array):void
		{
			
			this.subscribedScenes = {};
			
			for each(var scene:SceneSubscriptionData in data)
			{
				for each(var fsd:BrandSceneData in this.availableSubscriptions.source)
				{
					if(scene.scene == fsd.scene.id)
					{
						fsd.subscribed = true;
						break;
					}
				}
			}
		}
		
		
	}
}