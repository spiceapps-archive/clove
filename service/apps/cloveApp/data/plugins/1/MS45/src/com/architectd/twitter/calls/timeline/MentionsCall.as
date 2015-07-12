package com.architectd.twitter.calls.timeline
{
	public class MentionsCall extends TimelineCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function MentionsCall(count:int = 15,page:int = 0,sinceID:Number = NaN,maxID:Number = NaN)
		{
			super("mentions",{count:count,page:page,since_id:sinceID,max_id:maxID});
		}
	}
}