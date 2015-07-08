package com.spice.clove.plugin.impl
{
	import com.spice.clove.plugin.core.IClovePlugin;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallClovePluginControllerType;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.calls.data.SceneSyncData;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.ICloveContentControllerFactory;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.post.core.calls.CallFromPostPluginType;
	import com.spice.clove.post.core.outgoing.IClovePostable;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncablePluginType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.plugin.AbstractPlugin;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	
	import flash.utils.IDataOutput;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	
	/**
	 * 
	 * @author craigcondon
	 *   
	 */
	
	public class ClovePlugin extends AbstractPlugin implements IProxyResponder, 
															   IProxyBinding, 
															   IClovePlugin
	{  
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 * the default postables to show in the drop menu for the post window 
		 */		
		private var _defaultPostables:Vector.<IClovePostable>;
		
		  
		/**
		 * creates new service delegates 
		 */		
		
		private var _contentFactory:ICloveContentControllerFactory;
		
		
		/**
		 * the plugin settings 
		 */		
		
		private var _settings:ClovePluginSettings;
		
	
		
		/**
		 * the name of this plugin. this never changes
		 */
		
		private var _name:String;
		
		
		/**
		 */
		
		private var _uid:String;
		
		/**
		 * the display name of this plugin. this can change depending
		 * on the type of data stored
		 */
		
		private var _displayName:String;
		
		
		private var _factory:ClovePluginFactory;
		
		
		private var _initialized:Boolean;
		
		private var _applicationInitialized:Boolean;
		
		private var _firstTimeInitialized:Boolean;
		
		private var _selfLoading:Boolean;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ClovePlugin(pluginName:String,
									uid:String,
									settings:ClovePluginSettings,
									factory:ClovePluginFactory)
		{
			super();
			Singleton.enforce(this);
			
			this._name = pluginName;
			this._uid  = uid;
			this._displayName = pluginName;
			
			this._settings = settings;
			
			this._factory = factory;
			
			this._defaultPostables = new Vector.<IClovePostable>();
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		public function getUID():String
		{
			return this._uid;
		}
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			
			switch(call.getType())
			{
				
				case CallClovePluginType.GET_NAME: return this.respond(call,this._name);
				case CallClovePluginType.GET_SETTINGS: return this.respond(call,this._settings);
				case CallFromPostPluginType.GET_DEFAULT_POSTABLES: return this.respond(call,this.getPostables());
				case CallClovePluginType.GET_DISPLAY_NAME:return this.respond(call,this._displayName);
				case CallClovePluginType.APPLICATION_CLOSING:return this.applicationClosing();
				case CallClovePluginType.GET_PLUGIN_FACTORY: return this.respond(call,this._factory);
				case CallAppCommandType.ENTER_ACTIVE_MODE: return this.enterActiveMode();
				case CallClovePluginType.IS_SELF_LOADING: return this.startStopSelfLoading(call.getData());
				case CallAppCommandType.ENTER_IDLE_MODE: return this.enterIdleMode();
				case CallClovePluginType.APPLICATION_INITIALIZE: return this.applicationInitialized();
				case CallClovePluginType.GET_SEARCH_CONTENT_CONTROLLER: return this.respondWithNewSearchContentControllers(call,call.getData());
				case CallClovePluginType.GET_PLUGIN_CONTROLLER: return this.respond(call,this.getPluginController());
				case CallClovePluginType.GET_AVAILABLE_CONTENT_CONTROLLERS:
					
					if(this._contentFactory)
					{
						this.respond(call,this.getAvailableContentControllers());
					}
				return;
				case CallClovePluginType.GET_NEW_CONTENT_CONTROLLER:
					
					//the delegate to instantiate
					var delegateName:String = call.getData();
					
					if(this._contentFactory)
					{
						//respond with the new service delegate. This is also used when columns
						//are saved locally, and need to retrieve the service delegate used for that item.
						//Though AS3 DOES allow objects to be serialized, for this architecture, we always have
						//this line passed instead to provide a system that stays useable across multiple platforms, without
						//changing any code.
						this.respond(call,this.getNewContentController(delegateName));
					}
					
				return;
				case CallClovePluginType.GET_CONTENT_CONTROLLER_FACTORY:
					if(this._contentFactory)
					{
						this.respond(call,this._contentFactory);
					}
				return;
				
				
				case CallSceneSyncablePluginType.SCENE_SYNC_WRITE_EXTERNAL: return this.sceneSyncWriteExternal(call.getData());
				case CallSceneSyncablePluginType.SCENE_SYNC_READ_EXTERNAL: return this.sceneSyncReadExternal(call.getData());
				case CallSceneSyncablePluginType.SCENE_SYNC_READ_SUBSCRIBED_EXTERNAL: return this.sceneSyncReadSubscribedExternal(call.getData());
				case CallSceneSyncablePluginType.SCENE_SYNC_SWITCHED: return this.sceneSyncSwitched();
				case CallSceneSyncablePluginType.SCENE_SYNC_READ_UNSUBSCRIBED_EXTERNAL: return this.sceneSyncReadUnsubscribedExternal(call.getData());
				
				
			}
			
			super.answerProxyCall(call);
		}
		
		
		/**
		 */
		public function getNewContentController(type:String):ICloveContentController
		{
			return this._contentFactory.getNewContentController(type);
		}
		
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallClovePluginControllerType.PLUGIN_CONTROLLER_IS_UNINSTALLING: return this.pluginControllerIsUninstalling();
			}
			this.handleProxyResponse(n);
		}
		
		
		
		/**
		 */
		
		public function setContentControllerFactory(factory:ICloveContentControllerFactory):void
		{
			this._contentFactory = factory;
		}
		
		
		/**
		 */
		
		public function getContentControllerFactory():ICloveContentControllerFactory
		{
			return this._contentFactory;
		}
			
		
		
		/**
		 */
		
		public function getLoadedContentControllers():Array
		{
			return ProxyCallUtils.getResponse(CallClovePluginType.GET_LOADED_CONTENT_CONTROLLERS,this.getProxy());
		}
		
		/**
		 */
		
		public function getPostables():Vector.<IClovePostable>
		{
			
			return _defaultPostables;
		}
		
		
		/**
		 */
		
		public function addPostable(postable:IClovePostable):void
		{
			
			
			_defaultPostables.push(postable);
			
			var newPostables:Vector.<IClovePostable> = new Vector.<IClovePostable>();
			newPostables.push(postable);
			 
			this.notifyChange(CallFromPostPluginType.GET_DEFAULT_POSTABLES,newPostables);
		}
		
		
		
		
		
		
		/**
		 */
		
		public function setSettings(value:ClovePluginSettings):void
		{
			this._settings = value;	
		}
		
		/**
		 */
		
		public function getName():String
		{
			return this._name;
		}
		
		/**
		 */
		
		public function getPluginFactory():ClovePluginFactory
		{
			return this._factory;
		}
		
		/**
		 */
		
		public function getDisplayName():String
		{
			return _displayName;
		}
		
		/**
		 * the display name of this plugin. This could be a name associated with
		 * an account it's hooked up to, such as Facebook, twitter, digg etc. This is 
		 * usually only set if multiples of the same plugin can be added.
		 */
		
		public function setDisplayName(value:String):void
		{
			if(!value) 
				value = this._name;
			
			_displayName = value;
			
			this.notifyChange(CallClovePluginType.GET_DISPLAY_NAME,value);
		}
		
		
		/**
		 */
		
		public function initialized():Boolean
		{
			return this._initialized;
		}
		/**
		 */
		
		public function getApplicationInitialized():Boolean
		{
			return this._applicationInitialized;
		}
		
		
		private var _refreshTimeout:int;
		private var _hasContentControllers:Boolean;
		
		/**
		 */
		
		public function linkNewContentController(value:CloveContentController):void
		{
			_hasContentControllers = true;
			
			this.startStopSelfLoading(this.isSelfLoading());
		}
		
		
		/**
		 */
		
		public function isSelfLoading():Boolean
		{
			return this._selfLoading;
		}
		
		
		/**
		 */
		
		public function startStopSelfLoading(value:Boolean):void
		{
			this._selfLoading = value;
			
			flash.utils.clearInterval(this._refreshTimeout);
			
			if(value)
			{
				_refreshTimeout = flash.utils.setInterval(refreshFeeds,this.getRefreshTimeoutInterval(this.getLoadedContentControllers().length));
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function refreshFeeds():void
		{
			var controllers:Array = this.getLoadedContentControllers();
			
			for each(var controller:CloveContentController in controllers)
			{
				controller.loadNewer();
			}
		}
		
		/**
		 */
		
		protected function getRefreshTimeoutInterval(numControllers:int):int
		{  
			return 10*60*1000;//10 minutes
		}
		
		
		/**
		 * writes the plugin data to the scene sync data which gets pushed to the server
		 */
		
		protected function sceneSyncWriteExternal(output:IDataOutput):void
		{
//			this._settings.writeExternal(output);  	
		}
		
		/**
		 */
		
		protected function sceneSyncReadExternal(input:SceneSyncData):void
		{
//			this._settings.readExternal(input);
		}
		
		/**
		 */
		
		protected function sceneSyncReadSubscribedExternal(input:SceneSyncData):void
		{
			//abstract
		}
		
		/**
		 */
		
		protected function sceneSyncReadUnsubscribedExternal(input:SceneSyncData):void
		{
			//abstract
		}
		
		/**
		 */
		
		protected function sceneSyncSwitched():void
		{
			
		}
		
		
		/**
		 */
		
		protected function enterIdleMode():void
		{
			Logger.log("enterIdleMode",this);
		}
		
		/**
		 */
		
		protected function enterActiveMode():void
		{
			Logger.log("enterActiveMode",this);
		}
		
		/**
		 */
		
		protected function getAvailableContentControllers():Vector.<String>
		{
			return this._contentFactory.getAvailableContentControllers();
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
 			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallClovePluginType.APPLICATION_INITIALIZE,
									CallClovePluginType.GET_NEW_CONTENT_CONTROLLER,
									CallClovePluginType.GET_PLUGIN_CONTROLLER,
									CallClovePluginType.GET_SETTINGS,
									CallClovePluginType.GET_AVAILABLE_CONTENT_CONTROLLERS,
									CallClovePluginType.GET_DISPLAY_NAME,
									CallClovePluginType.GET_NAME,
									CallClovePluginType.GET_CONTENT_CONTROLLER_FACTORY,
									CallClovePluginType.GET_SEARCH_CONTENT_CONTROLLER,
									CallFromPostPluginType.GET_DEFAULT_POSTABLES,
									CallClovePluginType.APPLICATION_CLOSING,
									CallClovePluginType.GET_PLUGIN_FACTORY,
									CallClovePluginType.IS_SELF_LOADING,
									CallAppCommandType.ENTER_ACTIVE_MODE,
									CallAppCommandType.ENTER_IDLE_MODE,
									CallSceneSyncablePluginType.SCENE_SYNC_READ_EXTERNAL,
									CallSceneSyncablePluginType.SCENE_SYNC_WRITE_EXTERNAL,
									CallSceneSyncablePluginType.SCENE_SYNC_SWITCHED,
									CallSceneSyncablePluginType.SCENE_SYNC_READ_SUBSCRIBED_EXTERNAL,
									CallSceneSyncablePluginType.SCENE_SYNC_READ_UNSUBSCRIBED_EXTERNAL]);
			
		}
		
		
		/**
		 */
		
		protected function pluginControllerIsUninstalling():void
		{
			this.notifyChange(CallClovePluginType.PLUGIN_IS_UNINSTALLING,this);
		}
		
		
		/**
		 * send back new search content controllers with the keyword attached to the call
		 */
		
		protected function respondWithNewSearchContentControllers(call:IProxyCall,searchTerm:String):void
		{
			//abstract
		}
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();	
			
			if(!this._settings.installed().getData())
			{
				_firstTimeInitialized = true;
				this.install();
			}
			else
			{
				this.installed();	
			}
		}
		
		
		
		
		/**
		 */
		
		protected function applicationInitialized():void
		{
			if(this._applicationInitialized)
				throw new Error("Cannot call applicationInitialized on the same plugin twice: "+this._displayName);
			
			this._applicationInitialized = true;
			
			this.notifyChange(CallClovePluginType.APPLICATION_INITIALIZE,true);
			//abstract
		}
		
		
		/**
		 */
		
		protected function applicationClosing():void
		{
			//abstract
		}
		
		/**
		 */
		
		protected function install():void
		{
			
		}
		
		/**
		 */
		
		protected function installed():void
		{
			
		}
		
		/**
		 */
		
		protected function firstTimeInitialized():Boolean
		{
			return _firstTimeInitialized;
		}
		
		/**
		 */
		
		override protected function finishInitialization():void
		{
			this._settings.installed().setData(true);
			
			if(!this.getPluginMediator())
				return;
			
			
			
			
			
			_initialized = true;
			
			this.getProxyController().setProxyMediator(this.getPluginMediator());
			
			
			ProxyCallUtils.bind(this.getPluginController().getProxy(),this,[CallClovePluginControllerType.PLUGIN_CONTROLLER_IS_UNINSTALLING]);

			//this goes to the root
			if(this._contentFactory)
			{
				this.notifyChange(CallClovePluginType.GET_CONTENT_CONTROLLER_FACTORY,this._contentFactory);
			}
			
			if(this._defaultPostables && this._defaultPostables.length > 0)
			{
				this.notifyChange(CallFromPostPluginType.GET_DEFAULT_POSTABLES,this._defaultPostables);
			}
				
			super.finishInitialization();
		}
	}
}