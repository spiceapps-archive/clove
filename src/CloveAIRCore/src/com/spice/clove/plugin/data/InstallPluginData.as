package com.spice.clove.plugin.data
{
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class InstallPluginData
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var info:IInstalledPluginFactoryInfo;
		public var plugin:IPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function InstallPluginData(info:IInstalledPluginFactoryInfo,plugin:IPlugin)
		{
			this.info = info;
			this.plugin = plugin;
		}
	}
}