package com.architectd.twitter.calls.timeline
{
	public class RetweetedToMeCall extends TimelineCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function RetweetedToMeCall(count:int = 15,page:int = 0)
		{
			super("retweeted_to_me",{count:count,page:page});
		}
	}
}