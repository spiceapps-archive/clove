package com.architectd.digg2.calls.stories
{
	import com.architectd.digg2.calls.PublicDiggCall;
	import com.architectd.digg2.data.handle.StoryResponseHandler;
	
	public class GetUpcomingStoriesCall extends PublicDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetUpcomingStoriesCall(count:int = 15, page:int = 0, container:String = null,max_submit_date:Date = null,min_submit_date:Date = null)
		{
			super("story.getUpcoming",{container:container,
									   max_submit_date:max_submit_date ? max_submit_date.getTime() : NaN,
									   min_submit_date:min_submit_date ? min_submit_date.getTime() : NaN,
									   count:count,
									   offset:page},new StoryResponseHandler());
		}
	}
}