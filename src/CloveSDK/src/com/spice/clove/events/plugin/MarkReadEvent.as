package com.spice.clove.events.plugin
{
	import flash.events.Event;
	
	public class MarkReadEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const MARK_READ:String = "markRead";
        public static const MARK_ALL_READ:String = "markAllRead";
        
        public var data:*;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function MarkReadEvent(type:String,data:*)
		{
			super(type,true);
			
			this.data = data;
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
			return new MarkReadEvent(type,data);
		}

	}
}