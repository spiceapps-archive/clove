package com.architectd.twitter.calls.timeline
{
	public class FriendsTimelineCall extends TimelineCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FriendsTimelineCall(count:int = 15,page:int = 0,sinceID:Number = NaN,maxID:Number = NaN)
		{
			super("friends_timeline",{count:count,page:page,since_id:sinceID,max_id:maxID});
		}
	}
}