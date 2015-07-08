package com.spice.clove.plugin.product.mediate
{
	import com.spice.clove.plugin.mediate.IPluginCall;
	
	
	/*
	  call that is handelable for plugins such as best buy / newegg/ amazon etc. 
	  @author craigcondon
	  
	 */	
	 
	public interface IProductCall extends IPluginCall
	{
		/*
		  the product name 
		 */
		 
		function get productName():String;
		
		
	}
}