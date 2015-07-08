package com.spice.clove.plugin.core.calls
{
	public class CallClovePluginControllerType
	{
		/**
		 * the plugin mediator that allows plugins to make calls to other plugins registered
		 */
		
		public static var GET_PLUGIN_MEDAITOR:String = "getPluginMediator";
		
		
		/**
		 */
		
		public static const GET_PLUGIN_CONTROLLER_BY_UID:String = "getPluginByUID";
		
		/**
		 */
		
		public static const GET_PLUGIN_CONTROLLER_WITH_CONTENT_CONTROLLERS:String = "getPluginWithContentControllers";
		
		
		public static const GET_PLUGIN_CONTROLLER_BY_PLUGIN_FACTORY_CLASS:String = "getPluginControllerByPluginFactoryClass";
		public static const GET_PLUGIN_CONTROLLER_BY_PLUGIN_FACTORY_PATH:String  = "getPluginControllerByPluginFactoryPath";
		
		
//		public static const GET_PLUGIN_CONTROLLER_BY_FACTORY_CLASS:String = "getPluginControllerByFactoryClass";
		
		
		public static const GET_PLUGIN_CONTROLLER_WITH_ACCOUNT:String = "getPluginControllerWithAccount";
		
		
		public static const GET_POSTABLES:String = "getPostables";
		public static const GET_PLUGIN:String = "pluginControllerGetPlugin";
		public static const GET_PLUGIN_FACTORY_PATH:String = "getPluginFactoryPath";
		
		/**
		 */
		
		
		public static const GET_PLUGIN_UID:String = "getPluginUID";
		
		
		public static const PLUGIN_CONTROLLER_IS_UNINSTALLING:String = "pluginControllerIsUninstalling";
	}
}