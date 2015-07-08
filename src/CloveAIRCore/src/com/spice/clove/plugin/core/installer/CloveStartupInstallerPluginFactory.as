package com.spice.clove.plugin.core.installer
{
	import com.spice.vanilla.core.plugin.IPlugin;

	public class CloveStartupInstallerPluginFactory extends CloveInstallerPluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveStartupInstallerPluginFactory()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function newPlugin():IPlugin
		{
			return new CloveStartupInstallerPlugin(this);
		}
	}
}