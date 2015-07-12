package com.architectd.twitter.calls.timeline
{
	public class HomeTimelineCall extends TimelineCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function HomeTimelineCall(count:int = 15,page:int = 0)
		{
			super("home_timeline",{count:count,page:page});
		}
	}
}