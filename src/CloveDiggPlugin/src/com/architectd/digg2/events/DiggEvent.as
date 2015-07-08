package com.architectd.digg2.events
{
	import flash.events.Event;

	public class DiggEvent extends Event
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const NEW_DATA:String = "newData";
		public static const ERROR:String    = "error";
		
		public var data:*;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggEvent(type:String,data:* = null)
		{
			super(type);
			
			this.data = data;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function clone() : Event
		{
			return new DiggEvent(type,data);
		}
	}
}