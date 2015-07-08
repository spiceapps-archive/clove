package com.spice.clove.plugin.core.views.content
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	

	public interface ICloveContentPreferenceViewController extends IProxyOwner
	{
		function getTarget():ICloveContentController;
		function setTarget(value:ICloveContentController):void;
	}
}