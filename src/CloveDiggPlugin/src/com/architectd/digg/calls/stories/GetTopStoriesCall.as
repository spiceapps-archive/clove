package com.architectd.digg.calls.stories
{
	import com.architectd.digg.calls.DiggCall;
	import com.architectd.digg.data.handle.StoryResponseHandler;
	
	public class GetTopStoriesCall extends DiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetTopStoriesCall()
		{
			super("http://services.digg.com/stories/top",new StoryResponseHandler());
		}
	}
}