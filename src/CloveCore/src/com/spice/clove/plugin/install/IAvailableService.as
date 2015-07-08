package com.spice.clove.plugin.install
{
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	import com.spice.core.queue.ICue;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	
	new ClovePluginFactory
	
	public interface IAvailableService extends ICue
	{
		
		/* 
		  handles the plugin installation process
		 */		
		 
		//function get installer():IClovePluginInstaller;
		function get factory():IPluginFactory
		
		/*
		  installs the plugin
		 */		
		 
		function install():IInstalledPluginFactoryInfo;
		
		
		/*
		  TRUE if the plugin is selected to install initially 
		 */	
		 	
		function get selected():Boolean;
		
		function set selected(value:Boolean):void;
		
		/*
		  TRUE if the plugin can be toggle for install
		 */		
		 
		function get optional():Boolean;
		
		function set optional(value:Boolean):void;
		
		/*
		  TRUE if the plugin can be seen in the installer
		 */		
		 
		function get visible():Boolean;
		
		function set visible(value:Boolean):void;
		
		/*
		   The name of the plugin being installed
		 */
		 		
		function get name():String;
		
		function set name(value:String):void;
		
		/*
		  optional. This is for plugins with an ID they need
		 */
		
		function get uid():String;
	}
}