package com.spice.clove.plugin.core
{
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.proxy.IProxyOwner;

	public interface IClovePlugin extends IPlugin
	{
		/**
		 * the unique identifier that allows Clove to identify what type of plugin this is 
		 * @return 
		 * 
		 */		
		
		function getUID():String;
	}
}