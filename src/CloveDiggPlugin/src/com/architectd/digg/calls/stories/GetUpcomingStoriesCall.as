package com.architectd.digg.calls.stories
{
	import com.architectd.digg.calls.DiggCall;
	import com.architectd.digg.data.handle.StoryResponseHandler;
	
	public class GetUpcomingStoriesCall extends DiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetUpcomingStoriesCall()
		{
			super("http://services.digg.com/stories/upcoming",new StoryResponseHandler());
		}
	}
}