package com.spice.clove.events.plugin
{
	
	import flash.events.Event;
	
	
	/*
	  called when a link is selected 
	  @author craigcondon
	  
	 */	
	public class RenderedDataTextEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		
		public static const LINK_SELECT:String = "linkSelect";

        public var data:*;
        public var text:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function RenderedDataTextEvent(type:String,data:*,text:String)
		{
			super(type);
			
			
			this.data = data;
			this.text = text;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function clone():Event
		{
			return new RenderedDataTextEvent(type,this.data,this.text);
		}

	}
}