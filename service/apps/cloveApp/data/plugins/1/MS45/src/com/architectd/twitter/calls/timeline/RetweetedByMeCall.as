package com.architectd.twitter.calls.timeline
{
	public class RetweetedByMeCall extends TimelineCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function RetweetedByMeCall(count:int = 15,page:int = 0)
		{
			super("retweeted_by_me",{count:count,page:page});
		}
	}
}