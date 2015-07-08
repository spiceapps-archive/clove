package com.spice.clove.plugin.flash.views
{
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.menu.IMenuOptionButtonViewController;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	
	import mx.core.IDataRenderer;

	public interface IControllableView extends IDataRenderer
	{
		function getController():IProxyOwner;
		function setController(value:IProxyOwner):void;
	}
}