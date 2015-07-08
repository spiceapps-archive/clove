package com.spice.clove.rss.impl
{
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.rss.flex.FXRSSPlugin;
	import com.spice.clove.rss.impl.views.assets.RSSAssets;
	import com.spice.clove.rss.impl.views.installer.RSSPluginInstaller;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class RSSPluginFactory extends ClovePluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RSSPluginFactory()
		{
			this.setIcon16(RSSAssets.RSS_16_ICON);
			this.setIcon32(RSSAssets.RSS_32_ICON);
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
			return new RSSPlugin(this);
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
			return new RSSPluginInstaller(RSSPlugin(plugin));
		}
		
	}
}