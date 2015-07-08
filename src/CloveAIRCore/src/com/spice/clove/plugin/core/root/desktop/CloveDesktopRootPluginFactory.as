package com.spice.clove.plugin.core.root.desktop
{
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class CloveDesktopRootPluginFactory extends ClovePluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveDesktopRootPluginFactory()
		{
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
			return new CloveDesktopRootPlugin(this);
		}
	}
}