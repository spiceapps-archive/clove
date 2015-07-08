package com.spice.clove.sceneSync.core.calls
{
	public class CallSceneSyncPluginType
	{
		/**
		 * tells the scene sync we're ready to sync to the server 
		 */		
		
		public static const SCENE_SYNC_TRIGGER_READY:String = "sceneSyncTriggerReady";
		
		
		/**
		 * tells scene sync to pull the latest backup from disc  
		 */		
		
		public static const SCENE_SYNC_READ_BACKUP:String = "sceneSyncReadBackup";
		
		/**
		 * tells the scene to retrieve the available scenes provided by the target username 
		 */		
		
		public static const SCENE_SYNC_GET_SCENES_BY_USERNAME:String = "sceneSyncGetScenesByUsername";
		
		
		/**
		 * refreshes the subscriptions. 
		 */		
		public static const SCENE_SYNC_REFRESH_SUBSCRIPTION:String = "sceneSyncRefreshSubscription";
		
		/**
		 * subscribes the users computer to the scene provided in the call. this is the ID 
		 */		
		
		public static const SCENE_SYNC_SUBSCRIBE_TO_SCENE:String = "sceneSyncSubscribeToScene";
		public static const SCENE_SYNC_UNSUBSCRIBE_FROM_SCENE:String = "sceneSyncUnsubscribeFromScene";
		public static const SCENE_SYNC_GET_SCENES_BY_USER_ID:String = "sceneSyncGetScenesByUserId";
		public static const SCENE_SYNC_GET_SCENES_BY_EMAIL:String = "sceneSyncGetScenesByEmail";
		
		
		/**
		 */
		
		public static const SCENE_SYNC_GET_SUBSCRIBED_SCENES:String = "sceneSyncGetSubscribedScenes";
		
		
		/**
		 */
		
		public static const SCENE_SYNC_GENERATE_SHARE_ONLINE_LINK:String = "sceneSyncGenerageShareOnlineLink";
		
		
		/**
		 */
		
		public static const OPEN_CREATE_NEW_SCENE_VIEW:String = "openCreateNewSceneView";
		
		
		/**
		 */
		
		public static const OPEN_SCENE_SYNC_PREFERENCE_VIEW:String = "openSceneSyncPreferenceView";
		
		
		
		
	}
}