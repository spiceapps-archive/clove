package com.spice.clove.events
{
	import flash.events.Event;
	
	import mx.events.CollectionEvent;
	
	public class ColumnHistoryEvent extends CollectionEvent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const HISTORY_CHANGE:String = "historyChange";
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ColumnHistoryEvent(type:String,bubbles:Boolean,cancelable:Boolean,kind:String,location:int = -1,oldLocation:int = -1,items:Array = null)
		{
			super(type,bubbles,cancelable,kind,location,oldLocation,items);
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
			return new ColumnHistoryEvent(type,bubbles,cancelable,kind,location,oldLocation,items);
		}

	}
}