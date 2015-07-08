package com.spice.clove.plugin.core.sceneSync.impl
{
	import com.spice.clove.plugin.core.sceneSync.impl.views.assets.SceneSyncAssets;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class SceneSyncPluginFactory extends ClovePluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncPluginFactory()
		{
			this.setIcon16(SceneSyncAssets.CLOVE_16);
			this.setIcon32(SceneSyncAssets.CLOVE_32);
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
			return new SceneSyncPlugin(this);
		}
	}
}