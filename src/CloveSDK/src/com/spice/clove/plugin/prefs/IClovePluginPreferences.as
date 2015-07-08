package com.spice.clove.plugin.prefs
{
	import mx.collections.ArrayList;
	import mx.core.IFlexDisplayObject;
	
	
	/*
	  the preferences used in each plugin factory. this is visible in the preference window under plugins.
	  @author craigcondon
	  
	 */	
	public interface IClovePluginPreferences extends IFlexDisplayObject
	{
		/*
		  
		  @param value the plugins specific to the current preference pane
		  
		 */		
		function set plugins(value:ArrayList):void;
	}
}