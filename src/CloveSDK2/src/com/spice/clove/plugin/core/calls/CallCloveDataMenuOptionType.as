package com.spice.clove.plugin.core.calls
{
	public class CallCloveDataMenuOptionType
	{
		/**
		 * could be an observer. In which case, we provide all of the names, and create menu items based on them 
		 */		
		public static const GET_NAME:String = "getNames";
		public static const IS_SEPARATOR:String = "isSeparator";
		public static const GET_SUB_MENU_ITEMS:String = "getSubMenuItems";
		public static function MENU_ITEM_SELECTED(name:String):String
		{
			return name;
		}
		
	}
}