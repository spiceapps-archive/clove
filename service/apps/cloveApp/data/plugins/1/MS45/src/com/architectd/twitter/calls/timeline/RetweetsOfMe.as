package com.architectd.twitter.calls.timeline
{
	

	public class RetweetsOfMe extends TimelineCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function RetweetsOfMe(count:int = 15,page:int = 0)
		{
			super("retweets_of_me",{count:count,page:page});
		}
	}
}