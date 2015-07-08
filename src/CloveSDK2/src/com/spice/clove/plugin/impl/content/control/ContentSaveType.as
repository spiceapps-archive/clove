package com.spice.clove.plugin.impl.content.control
{
	public class ContentSaveType
	{
		
		/*
		tells the SQL database to add new items only  (for any entry, this is default)
		*/
		
		public static const FILL_NEW:int    = 1;
		
		/*
		tells the SQL database to overwrite any existing entries (for anything that might change IE: facebook comments)
		*/
		
		public static const OVERWRITE:int   = 2;
		
		/*
		tells the SQL database to push any overwritten, or new entries to the top as new (for any specific updates)
		*/
		
		public static const PUSH_TO_TOP:int = 4;
		
		/*
		*/
		
		public static const UNCLEAR_ON_OVERWRITE:int = 8;
		
		/*
		*/
		
		
		public static const DO_NOT_SAVE:int = 16;
		
		
	}
}