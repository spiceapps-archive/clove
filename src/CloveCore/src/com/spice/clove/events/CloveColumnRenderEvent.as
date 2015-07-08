package com.spice.clove.events
{
	import flash.events.Event;
	
	public class CloveColumnRenderEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const RENDER:String = "render";
        
        public var data:Array;
        
   		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CloveColumnRenderEvent(type:String,data:Array)
		{
			super(type,true);
			this.data   = data;
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
			return new CloveColumnRenderEvent(type,data);
		}

	}
}