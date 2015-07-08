package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class CreateColumnEvent extends CairngormEvent
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const CREATE_COLUMN:String = "createColumn";
        
        public var controllers:Array;
        public var callback:Function;
        public var metadata:Object;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CreateColumnEvent(controllers:Array,callback:Function = null,metadata:Object = null)
		{
			super(CREATE_COLUMN);
			
			this.controllers = controllers;
			this.callback   = callback;
			this.metadata   = metadata;
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
			return new CreateColumnEvent(controllers,callback,metadata);
		}

	}
}