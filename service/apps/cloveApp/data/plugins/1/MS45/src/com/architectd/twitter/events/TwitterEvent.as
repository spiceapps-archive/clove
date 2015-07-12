package com.architectd.twitter.events
{
	import com.architectd.twitter.data.TwitterResult;
	
	import flash.events.Event;

	public class TwitterEvent extends Event
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const CALL_COMPLETE:String = "callComplete";
		public static const CALLING:String		 = "calling";
		
		public var result:TwitterResult;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		public function TwitterEvent(type:String,data:TwitterResult = null)
		{
			super(type);
			
			this.result = data;
		}
	}
}