package com.spice.clove.plugin.core.content.control
{
	
	
	/**
	 * the factory class used to instantiate new feed controllers 
	 * @author craigcondon
	 * 
	 */	
	public interface ICloveContentControllerFactory
	{
		/**
		 * creates new delegate 
		 * @param name the name of the service delegate
		 * @return 
		 * 
		 */		
		function getNewContentController(name:String):ICloveContentController;
		
		
		/**
		 * the string array of the available service delegates. For clove, this appears in the column settings
		 * @return available delegates list
		 * 
		 */		
		
		
		function getAvailableContentControllers():Vector.<String>;
	}
}