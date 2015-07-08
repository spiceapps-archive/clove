package com.architectd.digg.calls.stories
{
	import com.architectd.digg.calls.DiggCall;
	import com.architectd.digg.data.handle.StoryResponseHandler;
	
	public class GetPopularStoriesCall extends DiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetPopularStoriesCall()
		{
			super("http://services.digg.com/stories/popular",new StoryResponseHandler());
		}
	}
}