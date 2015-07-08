package com.spice.clove.plugin.load
{
	import com.spice.clove.plugin.install.IAvailableService;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	
	import flash.events.IEventDispatcher;
	
	
	/*
	  installed plugin information. any class using this interface must
	  also be externalizable, since the info is saved in the ClovePluginList
	  @author craigcondon
	  
	 */	
	 
	public interface IInstalledPluginFactoryInfo extends IEventDispatcher
	{
		
		/*
		  returns the plugin loaded
		 */

		function get loadedPluginFactory():IPluginFactory;
		
		/*
		 */
		
		function loadPluginFactory():void;
		
		/*
		 */
		
		function get factoryClass():String;
		
		
		/*
		 */
		
		function getAvailableService():IAvailableService;
		
		/*
		 */
		
		function uninstall():void;
	}
}