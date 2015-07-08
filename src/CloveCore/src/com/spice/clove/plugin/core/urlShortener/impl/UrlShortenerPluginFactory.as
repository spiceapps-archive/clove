package com.spice.clove.plugin.core.urlShortener.impl
{
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class UrlShortenerPluginFactory extends ClovePluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UrlShortenerPluginFactory()
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
			return new UrlShortenerPlugin(this);
		}
	}
}