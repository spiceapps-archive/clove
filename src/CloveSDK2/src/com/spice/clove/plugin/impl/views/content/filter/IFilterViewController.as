package com.spice.clove.plugin.impl.views.content.filter
{
	import com.spice.vanilla.core.proxy.IProxyOwner;
	
	import flash.geom.Rectangle;

	public interface IFilterViewController extends IProxyOwner
	{
		function open(position:Rectangle):void;
		function close():void;
		function getFilteredList():Array;
		function useItemAt(index:int):void;
		function setFilterableList(value:Array):void;
		function getFilter():String;
		function setFilter(value:String):void;
		function setFocus():void;
	}
}