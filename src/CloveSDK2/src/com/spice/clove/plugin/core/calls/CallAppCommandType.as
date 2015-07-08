package com.spice.clove.plugin.core.calls
{
	import com.spice.clove.root.core.calls.CallRootPluginType;

	public class CallAppCommandType
	{
		
		/**
		 * sets the application view
		 */
		
		public static const SET_APP_VIEW:String = "setAppView";
		
		
		/**
		 * dispatched once clove data is processed. The motivation behind providing the command
		 * is to notify any notification systems such as Growl
		 */
		
		public static const DATA_PROCESSED:String = "dataProcessed";
		
		/**
		 * the global content loader queue for column content controllers
		 * so we don't have multiple, concurrent loads that bog the application down
		 */
		
		public static const GET_GLOBAL_CONTENT_LOADER_QUEUE:String = "getGlobalContetnLoaderQueue";
		
		
		/**
		 * the global call for retrieving text replacements for clove data.
		 */
		
		public static const GET_DEFAULT_TEXT_REPLACEMENTS:String = "getDefaultTextReplacements";
		
		
		/**
		 * sets the application dimensions (desktop only). This value passed should be a rectangle
		 */
		
		public static const SET_APPLICATION_DIMENSIONS:String = "setApplicationDimensions";
		
		
		
		/**
		 * an alert notification the user see's 
		 */
		
		public static const SHOW_ALERT:String = "dispatchAlert";
		
		/**
		 * dispatches a notification to the proxy mediator that's handled by notification plugins such as Growl, or similar. This is
		 * something the user always sees.
		 */
		
		public static const DISPATCH_TOASTER_NOTIFICATION:String = "dispatchToasterNotification";
		
		
		/**
		 */
		
		public static const NAVIGATE_TO_URL:String = "navigateToUrl";
		
		
		public static const GET_APPLICATION_NAME:String = "getApplicationName";
		
		
		/**
		 */
		
		public static const GET_SHARE_APP_TEXT:String = "getShareAppText";
		
		
		
		/**
		 */
		
		public static const GET_SPLASH_PAGE_HTML_URL:String = "getSplashPageHtmlUrl";
		
		/**
		 */
		
		public static const GET_DEFAULT_PLUGINS:String ="getDefaultPlugins";
		
		
		/**
		 * returns attachment factories registered by plugins. IE: longUrl plugin used in Twitter data attachent 
		 */		
		
		public static const GET_REGISTERED_DATA_ATTACHENT_FACTORIES:String = "getRegisteredDataAttachmentFactories";
		
		
		/**
		 * returns clove data renderers that handle new, incomming data. this is particularly useful for plugins that specialize
		 * in decorating other plugins, such as google maps, bing, longurl, etc.
		 */
		
		public static const GET_REGISTERED_CLOVE_DATA_RENDERERS:String = "getRegisteredCloveDataRenderers";
		
		/**
		 */
		
		public static const GET_UPDATE_URL:String = "getUpdateUrl";
		
		
		/**
		 */
		
		public static const ENTER_IDLE_MODE:String = "enterIdleMode";
		
		/**
		 */
		
		public static const ENTER_ACTIVE_MODE:String = "enterActiveMode";
		
		
		
	}
}