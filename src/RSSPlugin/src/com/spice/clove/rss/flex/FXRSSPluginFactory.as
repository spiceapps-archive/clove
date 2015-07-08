package com.spice.clove.rss.flex
{
	import com.spice.clove.rss.impl.RSSPluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class FXRSSPluginFactory extends RSSPluginFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FXRSSPluginFactory()
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
			return new FXRSSPlugin(this);
		}
	}
}