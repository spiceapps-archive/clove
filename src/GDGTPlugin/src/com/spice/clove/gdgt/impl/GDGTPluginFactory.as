package com.spice.clove.gdgt.impl
{
	import com.spice.clove.gdgt.impl.views.assets.GDGTAssets;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class GDGTPluginFactory extends ClovePluginFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GDGTPluginFactory()
		{
			this.setIcon16(GDGTAssets.ICON_16x16);
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
			return new GDGTPlugin(this);
		}
		
	}
}