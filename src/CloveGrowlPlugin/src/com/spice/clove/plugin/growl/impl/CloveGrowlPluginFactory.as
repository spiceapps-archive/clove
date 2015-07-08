package com.spice.clove.plugin.growl.impl
{
	import com.spice.clove.plugin.growl.impl.views.assets.GrowlAssets;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class CloveGrowlPluginFactory extends ClovePluginFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function CloveGrowlPluginFactory()
		{
			this.setIcon32(GrowlAssets.GROWL_ICON_32);
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
			return new CloveGrowlPlugin(this);
		}
	}
}