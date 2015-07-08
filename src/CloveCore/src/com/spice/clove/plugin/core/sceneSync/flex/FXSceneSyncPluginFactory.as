package com.spice.clove.plugin.core.sceneSync.flex
{
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPluginFactory;
	import com.spice.clove.plugin.core.sceneSync.impl.installer.SceneSyncPluginInstaller;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class FXSceneSyncPluginFactory extends SceneSyncPluginFactory
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FXSceneSyncPluginFactory()
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
			return new FXSceneSyncPlugin(this);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getNewPluginInstaller(plugin:IPlugin):IClovePluginInstaller
		{
			return new SceneSyncPluginInstaller(FXSceneSyncPlugin(plugin),this.getPluginMediator());
		}
	}
}