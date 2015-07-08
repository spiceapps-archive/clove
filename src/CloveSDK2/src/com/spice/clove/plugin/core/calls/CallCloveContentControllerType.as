package com.spice.clove.plugin.core.calls
{

	public class CallCloveContentControllerType
	{
		
		/**
		 * loads content from the server 
		 */		
		
		public static const LOAD_NEWER:String = "loadNewer";
		
		/**
		 */
		
		public static const LOAD_OLDER:String = "loadOlder";
		
		
		public static const DISPLAY_ERROR_MESSAGE:String = "displayErrorMessage";
		
		
		/**
		 */
		
		public static const GET_FACTORY_NAME:String = "getFactoryName";
		
		
		
		/**
		 * the 16x16 icon for the content controller 
		 */
		
		public static const GET_ICON_16:String = "getIcon16";
		
		/**
		 * the item renderer that converts VO data to CloveData
		 */
		
		public static const GET_ITEM_RENDERER:String = "getItemRenderer";
		
		
		/**
		 * the preference view controller for the feed. This is a proxy item set by the factory, and should
		 * only be set in the PluginFactory since it may change depending on the version of flash currently running
		 */
		
		public static const GET_PREFERENCE_VIEW_CONTROLLER:String = "getPreferenceViewController";
		
		/**
		 */
		
		public static const SET_COLUMN:String = "setColumn";
		
		/**
		 * the name of the seed
		 */
		
		public static const GET_NAME:String = "getName";
		
		
		/**
		 * the data option controllers visible in each row
		 */
		
		public static const GET_DATA_OPTION_CONTROLLERS:String = "getDataOptionControllers";
		
		
		
		/**
		 * the settings to use to save to disk
		 */
		
		public static const GET_SETTINGS:String = "getSettings";
		
		
		/**
		 * returns the column view factory 
		 */		
		
		public static const GET_COLUMN_VIEW_FACTORY:String = "getColumnViewFactory";
		
		
		/**
		 */
		
		public static const GET_PLUGIN:String = "getPlugin";
		
		/**
		 */
		
		public static const GET_DATA_ORDER_BY:String = "getDataOrderBy";
		
		/**
		 */
		
		public static const LOADING_CONTENT:String = "loadingContent";
		
		
		/**
		 * the current state in the load process. 2 = complete, 1 = error, 0 = loading
		 */
		
		public static const GET_LOADING_STATE:String = "getLoadingState";
		
		/**
		 */
		
		public static const REMOVE_CONTENT:String = "removeContent";
		
		
		/**
		 */
		
		public static const SET_BREADCRUMB:String = "setBreadcrumb";
		
		/** 
		 */		
		public static const GET_BREADCRUMB:String = "getBreadcrumb";
		
		/**
		 * resets the UID for the clove column for synchronization
		 */
		
		public static const RESET_UID:String = "resetUID";
		
		
		public static const DISPOSED:String = "disposed";
		
	}
}