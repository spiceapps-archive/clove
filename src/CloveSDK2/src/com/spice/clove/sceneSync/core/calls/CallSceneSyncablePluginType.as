package com.spice.clove.sceneSync.core.calls
{
	public class CallSceneSyncablePluginType
	{
		public static const SCENE_SYNC_READ_EXTERNAL:String  = "sceneSyncReadExternal";
		public static const SCENE_SYNC_READ_SUBSCRIBED_EXTERNAL:String  = "sceneSyncReadSubscribedExternal";
		public static const SCENE_SYNC_READ_UNSUBSCRIBED_EXTERNAL:String  = "sceneSyncReadUnsubscribedExternal";
		public static const SCENE_SYNC_WRITE_EXTERNAL:String = "sceneSyncWriteExternal";
		public static const SCENE_SYNC_SWITCHED:String 		 = "sceneSyncSwitched";
		
		
		public static const SCENE_SYNC_GET_SUBSCRIPTIONS_BY_EMAIL:String = "sceneSyncGetSubscriptionsByEmail";
		
		
		/**
		 * the filter view for when the user types in a keyword for a column of interest 
		 */		
		public static const SCENE_SYNC_GET_FILTER_VIEW_CONTROLLER:String = "sceneSyncGetFilterViewController";
		
		
		/**
		 * the installer view for when the app opens for the first time
		 */		
		
		public static const SCENE_SYNC_GET_INSTALLER_VIEW_CONTROLLER:String = "sceneSyncGetInstallerViewController";
		
		
		public static const SCENE_SYNC_SET_FILTER_STR:String = "sceneSyncableSetFilterStr";
		
		
	}
}