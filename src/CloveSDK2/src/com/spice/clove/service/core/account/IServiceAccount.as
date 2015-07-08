package com.spice.clove.service.core.account
{
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.proxy.IProxyOwner;

	public interface IServiceAccount extends IProxyOwner
	{
		function getName():String;
		function getPlugin():IPlugin;
	}
}