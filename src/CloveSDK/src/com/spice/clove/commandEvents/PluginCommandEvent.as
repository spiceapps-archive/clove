package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	
	/*
	  PluginEvent is used to access the plugin functionality through MVC. This will
	  reduce the likelyness of any illegal overwrite of class X
	  @author craigcondon
	  
	 */	
	public class PluginCommandEvent extends CairngormEvent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const ADD_AVAILABLE_FEED:String = "addAvailableFeed";
        public static const ADD_POSTABLE:String       = "addPostable";
        
        
        public var controller:*;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function PluginCommandEvent(type:String,controller:*)
		{
			super(type);
			
			
			this.controller = controller;
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
			return new PluginCommandEvent(type,this.controller);
		}

	}
}