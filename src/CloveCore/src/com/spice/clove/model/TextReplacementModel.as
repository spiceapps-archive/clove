package com.spice.clove.model
{
	import com.spice.utils.textCommand.TextCommandManager;
	
	
	/*
	  manages text handlers registered by columns. this enables explicit services like Twitter to handle text accordingly
	 */
	
	public class TextReplacementModel
	{


        public var rooTextManager:TextCommandManager = new TextCommandManager();
        
        //used when new data is put in the sql lite db
        public var rootCacheTextManager:TextCommandManager = new TextCommandManager();
		
		

	}
}