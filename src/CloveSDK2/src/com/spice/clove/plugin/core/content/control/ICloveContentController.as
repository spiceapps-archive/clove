package com.spice.clove.plugin.core.content.control
{
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.proxy.IProxyResponder;

	public interface ICloveContentController extends /*IProxyResponder,*/ IProxyOwner
	{
		function getSettings():ISettingTable;
	}
}