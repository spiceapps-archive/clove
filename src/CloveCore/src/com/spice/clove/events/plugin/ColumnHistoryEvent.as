package com.spice.clove.events.plugin
{
	import flash.events.Event;
	
	public class ColumnHistoryEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        public static const HISTORY_CHANGE:String = "historyChange";
        
        public var responseArray:Array;
        public var kind:String;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ColumnHistoryEvent(type:String,kind:String,response:Array = null,bubbles:Boolean = true)
		{
			super(type,bubbles);
			this.kind   = kind;
			this.responseArray = response == null ? [] : response;
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
			return new ColumnHistoryEvent(type,kind,responseArray,bubbles);
		}

	}
}