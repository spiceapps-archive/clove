package com.spice.clove.plugin.core.sceneSync.desktop
{
	import com.spice.clove.plugin.core.sceneSync.flex.FXSceneSyncPluginFactory;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class SceneSyncDesktopPluginFactory extends FXSceneSyncPluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncDesktopPluginFactory()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function newPlugin():IPlugin
		{  
			return new SceneSyncDesktopPlugin(this);
		}
	}
}