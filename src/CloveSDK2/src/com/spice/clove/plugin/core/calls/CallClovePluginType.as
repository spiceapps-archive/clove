package com.spice.clove.plugin.core.calls
{
	public class CallClovePluginType
	{
		
		/**
		 * the getter / setter for settings 
		 */		
		
		public static const GET_SETTINGS:String = "settings";
		
		
		/** 
		 */		
		
		public static const CHECK_FOR_UPDATESd:String = "checkForUpdates";
		
		
		/**
		 */
		
		public static const GET_NAME:String = "getName";
		
		/**
		 */
		
		public static const GET_DISPLAY_NAME:String = "getDisplayName";
		
		/**
		 * the feed controllers that talk to any remote service 
		 */		
		
		public static const GET_AVAILABLE_CONTENT_CONTROLLERS:String = "getAvailableContentControllers";
		
		
		
		/**
		 */
		
		public static const GET_LOADED_CONTENT_CONTROLLERS:String = "getLoadedContentControllers";
		
		
		/**
		 */
		
		public static const NEW_CONTENT_CONTROLLER:String = "newContentController";
		
		/**
		 */
		
		
		public static const GET_CONTENT_CONTROLLER_FACTORY:String = "getContentControllerFactory";
		
		
		/**
		 * passes to the abstract clove service delegate factory, and returns the target controller passed
		 * in the call getData()
		 */
		
		public static const GET_NEW_CONTENT_CONTROLLER:String = "getNewContentController";
		
		
		/**
		 */
		
		public static const GET_PLUGIN_FACTORY:String = "getPluginFactory";
		
		
		/**
		 * initializes the plugin
		 */
		
		public static const INITIALIZE:String = "initialize";
		
		
		/**
		 * called by plugin controller after all plugins have been initialized
		 */
		
		public static const APPLICATION_INITIALIZE:String = "applicationInitialize";
		
		/**
		 * called when the application is being Closed
		 */
		
		public static const APPLICATION_CLOSING:String = "applicationClosing";
		
		
		/**
		 */
		
		public static const GET_PLUGIN_CONTROLLER:String = "getPluginController";
		
		
		
		/**
		 */
		
		public static const GET_SEARCH_CONTENT_CONTROLLER:String = "getSearchContentController";
		
		
		/**
		 */
		
		public static const PLUGIN_IS_UNINSTALLING:String = "pluginIsUninstalling";
		
		
		
		/**
		 * TRUE if the plugin is in control over how many times each RSS feed is loaded
		 */  
		
		public static const IS_SELF_LOADING:String = "isSelfLoading";
		
		
	}
}