package com.architectd.digg.calls.stories
{
	import com.architectd.digg.calls.DiggCall;
	import com.architectd.digg.data.handle.StoryResponseHandler;

	public class GetAllStoriesCall extends DiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetAllStoriesCall()
		{
			super("http://services.digg.com/stories/",new StoryResponseHandler());
		}
	}
}