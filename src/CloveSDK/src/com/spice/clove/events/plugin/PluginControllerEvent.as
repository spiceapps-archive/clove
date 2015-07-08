package com.spice.clove.events.plugin
{
	import flash.events.Event;
	
	public class PluginControllerEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const PLUGIN_INITILIZED:String = "pluginInitialized";
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function PluginControllerEvent(type:String)
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
			return new PluginControllerEvent(type);
		}

	}
}