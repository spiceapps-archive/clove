package com.architectd.digg.events
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
		
		public var data:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggEvent(type:String,data:Array = null)
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