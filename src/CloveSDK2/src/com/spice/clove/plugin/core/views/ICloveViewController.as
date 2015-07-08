package com.spice.clove.plugin.core.views
{
	import com.spice.vanilla.core.proxy.IProxyOwner;
	
	import flash.display.DisplayObject;

	public interface ICloveViewController extends IProxyOwner
	{
		function setView(view:ICloveViewTarget):void;
	}
}