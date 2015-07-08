package com.spice.clove.plugin.core.install
{
	import com.spice.core.queue.ICue;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.impl.proxy.IProxyResponder;

	
	/**
	 * IProxyResponder to handle get properties
	 * INotifier to dispatch a complete event for items with OAuth
	 * @author craigcondon
	 * 
	 */	
	public interface IClovePluginInstaller extends ICue
	{
		function getPlugin():IPlugin;
	}
}