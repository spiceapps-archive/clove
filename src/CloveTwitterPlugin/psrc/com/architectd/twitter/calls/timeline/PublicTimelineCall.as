package com.architectd.twitter.calls.timeline
{
	
	
	public class PublicTimelineCall extends TimelineCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function PublicTimelineCall(sinceID:Number = NaN,maxID:Number = NaN)
		{
			super("public_timeline",{since_id:sinceID,max_id:maxID},false);
		}
	}
}