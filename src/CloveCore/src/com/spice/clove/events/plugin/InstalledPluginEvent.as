package com.spice.clove.events.plugin
{
	import flash.events.Event;
	
	public class InstalledPluginEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const PLUGIN_LOADED:String = "pluginLoaded";
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InstalledPluginEvent(type:String)
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
			return new InstalledPluginEvent(type);
		}

	}
}