package com.spice.clove.plugin.core.content.control
{
	public class CloveFeedSaveType
	{
		
		/**
		 * concat data to the end  
		 */		
		public static const SAVE_NEW:int = 8;
		
		/**
		 * overwrite the current data 
		 */		
		public static const OVERWRITE:int = 16;
		
		/**
		 * removes ALL content, and saves 
		 */		
		public static const DUMP_AND_SAVE:int = 32;
	}
}