package com.spice.clove.events
{
	import flash.events.Event;
	
	public class ClovePluginEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const LOAD_COLUMNS:String = "loadColumns";
        public static const UNINSTALL:String    = "uninstall";
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ClovePluginEvent(type:String)
		{
			super(type);
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
			return new ClovePluginEvent(type);
		}

	}
}