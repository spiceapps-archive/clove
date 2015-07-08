package com.spice.clove.plugin.core.calls
{
	import com.spice.core.calls.CallCueType;

	public class CallClovePluginInstallerType
	{
		/**
		 * lets the plugin installer know the plugin has been installed. It also passes the plugin instance returned in the factory
		 */
		
		public static const PLUGIN_INSTALLED:String = "pluginInstalled";
		
		
		/**
		 */
		
		public static const OPEN_PLUGIN_INSTALLER_WITH_AVAILABLE:String = "openPluginInstallerWithAvailable";
		
		
		/**
		 * tells the plugin installer to return the installer view. NOTE: the view needs to have mediator before being passed to the 
		 * intallation handler. This mediator is usually the installer itself.
		 */		
		
		public static const GET_INSTALLER_VIEW_CONTROLLER:String = "getInstallerViewController";
		
		
		/**
		 * call to return the icon to use for the installer
		 */
		
		public static const GET_ICON:String = "getIcon";
		
		/**
		 * asks the installer to see if it's ready 
		 */		
		
		public static const IS_FINISHED:String = CallCueType.COMPLETE;
	}
}