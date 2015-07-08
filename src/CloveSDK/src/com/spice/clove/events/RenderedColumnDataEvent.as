package com.spice.clove.events
{
	import flash.events.Event;

	public class RenderedColumnDataEvent extends Event
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const UPDATE:String = "udpate";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function RenderedColumnDataEvent(type:String)
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
			return new RenderedColumnDataEvent(type);
		}
	}
}