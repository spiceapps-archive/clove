package com.spice.clove.plugin.column.pref
{
	import mx.core.IDataRenderer;
	
	public interface IColumnPreferences extends IDataRenderer
	{
		function get formItems():Array;
		function set formItems(value:Array):void;
	}
}