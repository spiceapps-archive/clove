package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class CloveAIREvent extends CairngormEvent
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const WIPE_SETTINGS:String = "wipeSettings";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function CloveAIREvent(type:String)
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
		
		override public function clone() : Event
		{
			return new CloveAIREvent(type);
		}
	}
}