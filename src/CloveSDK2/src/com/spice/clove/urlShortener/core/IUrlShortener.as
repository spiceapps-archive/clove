package com.spice.clove.urlShortener.core
{
	import com.spice.core.queue.ICue;

	
	/**
	 * shortens a url, and returns the cue that loads the result from the server 
	 * @author craigcondon
	 * 
	 */	
	public interface IUrlShortener
	{
		/**
		 * used for identification when setting the default url shortener 
		 * @return 
		 * 
		 */		
		function getName():String;
		
		
		
		/**
		 * called when shorteneing the url 
		 * @param value
		 * @return 
		 * 
		 */		
		function shortenUrl(value:String):ICue;
	}
}