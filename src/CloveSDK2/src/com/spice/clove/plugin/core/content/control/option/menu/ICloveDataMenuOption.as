package com.spice.clove.plugin.core.content.control.option.menu
{
	import com.spice.vanilla.core.observer.IObserver;
	import com.spice.vanilla.core.proxy.IProxyOwner;

	public interface ICloveDataMenuOption extends IProxyOwner
	{
		function getName():String;
		function isSeparator():Boolean;
		function checked():Boolean;
		function enabled():Boolean;
		function getSubMenuItems():Vector.<ICloveDataMenuOption>;
	}
}