package com.spice.clove.events.plugin
{
	import flash.events.Event;
	
	
	/*
	  dispatched once the plugin is ready 
	  @author craigcondon
	  
	 */	
	public class PluginEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		public static const PLUGIN_READY:String = "pluginReady";
		public static const SET_SETTINGS:String = "setSettings";
		public static const REGISTER_COMMAND:String = "registerCommand";
		public static const ADD_AVAILABLE_COLUMN_CONTROLLER:String = "addAvailableColumnController";
		public static const ADD_POSTABLE:String = "addPostable";
		
		
		public var value:*;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function PluginEvent(type:String,value:Object = null)
		{
			super(type);
			
			
			this.value = value;
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
			return new PluginEvent(this.type,this.value);
		}

	}
}