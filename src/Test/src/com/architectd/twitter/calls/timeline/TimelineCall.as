package com.architectd.twitter.calls.timeline
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.dataHandle.TimelineDataHandler;

	public class TimelineCall extends TwitterCall
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const STATUS_URL:String = "http://twitter.com/statuses/";
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function TimelineCall(method:String,params:Object = null,authenticate:Boolean = true)
		{
			super(STATUS_URL+method+".xml",new TimelineDataHandler(),params,authenticate);
		}
		
	}
}