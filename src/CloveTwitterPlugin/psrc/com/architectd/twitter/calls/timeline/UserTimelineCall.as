package com.architectd.twitter.calls.timeline
{
	public class UserTimelineCall extends TimelineCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UserTimelineCall(screenName:String = null,count:int = 15,page:int = 0,sinceID:Number = NaN,maxID:Number = NaN)
		{
			super("user_timeline",{count:count,page:page,screen_name:screenName,since_id:sinceID,max_id:maxID});
		}
	}
}