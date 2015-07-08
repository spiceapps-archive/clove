package com.spice.clove.plugin.core.urlShortener.impl.shorteners
{
	import com.spice.clove.plugin.core.urlShortener.impl.UrlShortenerPlugin;
	import com.spice.clove.urlShortener.core.IUrlShortener;
	import com.spice.core.queue.ICue;

	public class BitlyUrlShortener implements IUrlShortener
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:UrlShortenerPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function BitlyUrlShortener(plugin:UrlShortenerPlugin)
		{
			this._plugin = plugin;	
		}
		
		/**
		 */
		
		public function getName():String
		{
			return "bit.ly";
		}
		
		/**
		 */
		
		public function shortenUrl(value:String):ICue
		{
			return new BitlyUrlShortenerCue(value,_plugin.getPluginMediator());
		}
	}
}