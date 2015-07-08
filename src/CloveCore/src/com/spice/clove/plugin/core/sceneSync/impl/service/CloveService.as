package com.spice.clove.plugin.core.sceneSync.impl.service
{
	import com.architectd.service.RemoteService;
	import com.architectd.service.calls.IServiceCall;
	import com.architectd.service.events.ServiceEvent;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.bugs.BugReportCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.favorites.AddFavoriteCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.favorites.CreateNewFavoriteCategoryCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.favorites.GetAvailableGroupsCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.favorites.GetFavoritesCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.scene.CloveSceneDeleteCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.scene.CloveSceneGetAllCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.scene.CloveSceneNewCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.scene.CloveSceneUpdateCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.screen.CloveScreenNewCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.sync.CloveSyncAddCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.sync.CloveSyncGetCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.sync.CloveSyncShareCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.thyme.AddLogsCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.data.FavoritesCategory;
	import com.spice.clove.plugin.core.sceneSync.impl.service.events.CloveServiceEvent;
	import com.spice.clove.plugin.core.sceneSync.impl.service.settings.CloveServiceSettings;
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.clove.sceneSync.core.service.data.SceneSubscriptionData;
	import com.spice.clove.sceneSync.core.service.data.SyncData;
	import com.spice.vanilla.core.notifications.SettingChangeNotification;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.flash.singleton.Singleton;
	
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.rpc.Fault;
	
	[Bindable]	
	public class CloveService extends RemoteService
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _settings:CloveServiceSettings;
		private var _availableCategories:Vector.<String>;
		private var _previousSceneId:Number;
		private var _logRoll:Array;
		private var _logSubmissionTimeout:int;
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var responseEvent:CloveServiceEvent;

		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveService(settings:CloveServiceSettings = null)
		{
			_settings = settings || new CloveServiceSettings();
			_logRoll = [];
			
			this._previousSceneId = this._settings.getCurrentScene().id;
			_settings.getCurrentScene().addObserver(new CallbackObserver(SettingChangeNotification.CHANGE,onCurrentSceneChange));
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		[Bindable(event="settingsChange")]
		public function get settings():CloveServiceSettings
		{
			return _settings;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		public static function getInstance():CloveService
		{
			return Singleton.getInstance(CloveService);
		}
		
		//LOGGING
		
		/**
		 */
		
		public function addLog(name:String,level:String,details:String,userComments:String = "",userEmail:String = ""):void
		{
			flash.utils.clearTimeout(_logSubmissionTimeout);
			
			this._logRoll.push({name:name,level:level,details:details,userComments:userComments,userEmail:userEmail});
			_logSubmissionTimeout = flash.utils.setTimeout(submitLogRoll,100);
		}
		
		
		/**
		 */
		
		public function logError(error:Error,uncaught:Boolean = false):void
		{
			this.addLog((uncaught?"UNCAUGHT ERROR-":"")+error.errorID+" - "+error.message,'error',error.getStackTrace());
		}
		
		/**
		 */
		
		private function submitLogRoll():void
		{  
			this.call(new AddLogsCall(this._logRoll));
		}
		
		//FAVORITES
		
		/**
		 */
		
		public function addFavorite(category:String,description:String,data:ICloveData):void
		{
			this.call(new AddFavoriteCall(category,data)).addEventListener(CloveServiceEvent.RESULT,onAddedFavorite);
		}
		
		/**
		 */
		
		public function getFavorites(category:String):GetFavoritesCall
		{
			
			if(!this._availableCategories)
			{
				
				//even if the category does NOT exist, the server automatically creates one for us
				this.getAvailableFavoriteCategories();
			}
			else
			if(_availableCategories.indexOf(category) == -1)
			{
				this.createNewCategory(category);
			}
			
			return this.call(new GetFavoritesCall(category));
		}
		
		/**
		 */
		
		public function getAvailableFavoriteCategories():void
		{
			this.call(new GetAvailableGroupsCall()).addEventListener(CloveServiceEvent.RESULT,onGetAvailableGroupsCall);
		
		}
		
		/**
		 */
		
		public function getLoadedAvailableCategories():Vector.<String>
		{
			return _availableCategories;
		}
		
		/**
		 */
		
		public function createNewCategory(name:String):void
		{
			this.call(new CreateNewFavoriteCategoryCall(name));
			this.getAvailableFavoriteCategories();
		}
		
		
		
		/**
		 */
		
		public function reportBug(title:String,description:String,priority:String,replyTo:String,settings:FileReference):BugReportCall
		{
			return this.call(new BugReportCall(title,description,priority,replyTo,settings));
		}
        /*
		 */
		
		public function setCredentials(username:String,password:String):void
		{
			this._settings.setCredentials(username,password);
		}
		
		
		/**
		 */
		
		public function addSubscriptionToCurrentScene(id:Number,displayName:String):void
		{
			if(this.settings.getCurrentScene().addSubscription(new SceneSubscriptionData("",0,displayName,0,id)))
				this.getLatestSubscriptionSync(id);
		}
		
		/**
		 */
		
		public function removeSubscriptionFromCurrentScene(id:Number):void
		{
			this.settings.getCurrentScene().removeSubscription(id);
			
			this.call(new CloveSyncGetCall(id)).addEventListener(CloveServiceEvent.RESULT,onGetUnsubscribedSceneData);
		}
		
		
        /**
		 */
		
		public function createScreenIfNone():Boolean
		{
			
			//if we don't have a screen ID now, then we need 
			//to retrieve one from the server before we continue synchronizing data.
			//once this is set and stored on file, we don't need to retrieve the screen ID
			if(_settings.getScreen().id == -1)
			{
				this.getNewScreen();
				return true;
			}
			return false;
		}
		
		/**
		 */
		
		
		public function renameCurrentScene(value:String):void
		{
			this.settings.getCurrentScene().setName(value);
			
			this.call(new CloveSceneUpdateCall(this.settings.getCurrentScene().id,value)).addEventListener(CloveServiceEvent.RESULT,this.onRenameScene);
		}
		
        /*
		 */
		
		public function getNewScreen():IServiceCall
		{
			return this.call(new CloveScreenNewCall());
		}
		
		
		/*
		 */
		
		public function deleteScene(scene:Number):IServiceCall
		{
			var deleteScene:CloveSceneDeleteCall = this.call(new CloveSceneDeleteCall(scene));
			deleteScene.addEventListener(CloveServiceEvent.RESULT,onDeleteScene);
			
			
			
			return deleteScene;
		}
		
		/**
		 */
	
		public function deleteCurrentScene():void
		{
			this.deleteScene(this._settings.getCurrentScene().id);
		}
		
		/*
		 */
		
		public function getLatestSync(useAnySyncStoredOnServer:Boolean = true):void
		{
			
			var scene:Number = this._settings.getCurrentScene().id;
			
			this.call(new CloveSyncGetCall(scene,useAnySyncStoredOnServer)).addEventListener(CloveServiceEvent.RESULT,onGetSync);
			
			
			
		}
		
		public function useSync(sync:SyncData):URLStream
		{
			this.settings.getSyncList().useSync(sync);
			var stream:URLStream = new URLStream();
			stream.load(new URLRequest(sync.url));
			
			Logger.log("loading sync url="+sync.url,this);
			
			return stream;
		}
		
		
		/**
		 */
		
		public function getLatestSubscriptionSyncs(useAnySync:Boolean = false):void
		{
			for each(var subscription:SceneSubscriptionData in this._settings.getCurrentScene().subscriptions.source)
			{
				this.getLatestSubscriptionSync(subscription.scene,useAnySync);
			}
		}
		
		/**
		 */
		
		public function getLatestSubscriptionSync(scene:int,useAnySync:Boolean = false):void
		{
			this.call(new CloveSyncGetCall(scene,useAnySync)).addEventListener(CloveServiceEvent.RESULT,onGetSubscriptionSync);
		}
		
		
		
		
		/*
		 */
		
		public function createScene(name:String,description:String = "desc"):void
		{
			if(this.canSendSync())
				this.call(new CloveSceneNewCall(name,description)).addEventListener(CloveServiceEvent.RESULT,onCreateScene);
		}
		
		/*
		 */
		
		public function getAllScenes():void
		{
			if(this.canSendSync())
				this.call(new CloveSceneGetAllCall()).addEventListener(CloveServiceEvent.RESULT,onGetAllScenes);
			
		}
		
		
		/**
		 */
		
		public function canSendSync():Boolean
		{
			var u:String = this.settings.getUsername().getData();
			var p:String = this.settings.getPassword().getData();
			
			return u && p && u != "" && p != "";
		}
		
		
		
		/*
		 */
		
		public function addSync(data:ByteArray):IServiceCall
		{
			return this.call(new CloveSyncAddCall(this._settings.getCurrentScene().id,this.settings.getScreen().id,data));
		}
		
		/**
		 */
		
		public function sharePackedScene(data:ByteArray):IServiceCall
		{
			return this.call(new CloveSyncShareCall(data));
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		override protected function onResult(event:ServiceEvent):void
		{
			super.onResult(event);
			
			this.responseEvent = CloveServiceEvent(event);
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onAddedFavorite(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onAddedFavorite);
			
			this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.ADDED_FAVORITE,1,""));
		}
		
		/**
		 */
		
		private function onGetAvailableGroupsCall(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onGetAvailableGroupsCall);
			
			
			
			_availableCategories = new Vector.<String>();
			for each(var data:FavoritesCategory in event.data)
			{
				_availableCategories.push(data.name);
			}
			
			this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.GET_AVAILABLE_FAVORITE_CATEGORIES,1,""));
		}
		/**
		 */
		
		private function onDeleteScene(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onDeleteScene);
			
			if(!this.callSuccess(event,"There was a problem deleting your scene."))
			{
				return;	
			}
			
			this.getAllScenes();
		}
		/**
		 */
		
		private function onCurrentSceneChange(target:CallbackObserver,n:INotification):void
		{
			var id:Number = this._settings.getCurrentScene().id;
			
			
			//onCurrentSceneChange will always be called on startup, so we 
			//need to make sure NOT to check for the latest sync if that's the case.
			if(id > -1 && _previousSceneId)
			{
				this.getLatestSync(true);
			}
			
			_previousSceneId = this._settings.getCurrentScene().id;
			
			this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.SCENE_CHANGED,1,null,this._settings.getCurrentScene()));
		}
		
		/**
		 */
		
		private function onGetSync(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onGetSync);
			
			if(!this.callSuccess(event,"There was a problem loading your scene from the Clove App server."))
			{
				return;	
			}
			
			
			var data:Array = event.data;
			
			if(data.length > 0)
			{
				this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.NEW_SYNC,1,null,data[0]));
			}
		}
		
		
		/**
		 */
		
		private function onGetSubscriptionSync(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onGetSubscriptionSync);
			
			if(!this.callSuccess(event,"There was a problem loading your subscription."))
			{
				return;	
			}
			
			var data:Array = event.data;
			
			if(data.length > 0)
			{
				this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.NEW_SUBSCRIPTION_SYNC,1,null,data[0]));
			}
		}
		
		/**
		 */
		
		private function onCreateScene(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onCreateScene);
			
			if(!this.callSuccess(event,"There was a problem creating your scene."))
			{
				return;	
			}
			
			
			this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.SCENE_CREATED,1,null,event.data[0]));
			
			
			this._settings.setCurrentScene(event.data[0]);
			
			
			this.getAllScenes();
		}
		
		/**
		 */
		
		private function onRenameScene(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onRenameScene);
			this.getAllScenes();
		}
		
		
		
		/**
		 */
		private function onGetAllScenes(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onGetAllScenes);
			
			if(!this.callSuccess(event,"There was a problem gathing all of the available scenes."))
			{
				return;	
			}
			
			var sceneId:Number = this._settings.getCurrentScene().id;
			
			
			var sceneExists:Boolean;
			for each(var scene:SceneData in event.data)
			{
				if(scene.id == sceneId)
				{
					sceneExists = true;
					break;
				}
			}
			
			if(!sceneExists && event.data.length > 0)
			{
				var sd:SceneData = event.data[event.data.length-1];
				
				//fixes the problem 
				_previousSceneId = sd.id;
				this._settings.setCurrentScene(sd);
			}
			
			
			this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.GET_ALL_SCENES,1,null,event.data));
		}
		
		
		/**
		 */
		
		protected function callSuccess(event:CloveServiceEvent,userMessage:String):Boolean
		{
			if(event.statusCode == -1)
			{
				this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.ERROR,event.statusCode,userMessage,event.message));
				return false;//fatal error
			}
			else
			if(event.statusCode > 0)
			{
				
				this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.ERROR,event.statusCode,event.message,event.data));
				return false;
			}
			else
			if(event.data is Fault)
			{
				this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.ERROR,event.statusCode,event.message,event.data));
			}
			
			return true;
			
		}
		
		
		/**
		 */
		
		private function onGetUnsubscribedSceneData(event:CloveServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onGetUnsubscribedSceneData);
			
			if(!this.callSuccess(event,"There was a problem gathering the data needed to unsubscribe from the selected scene."))
			{
				return;	
			}
			
			this.dispatchEvent(new CloveServiceEvent(CloveServiceEvent.GET_UNSUBSCRIBED_SCENE_DATA,1,null,event.data[0]));
		}

	}
}