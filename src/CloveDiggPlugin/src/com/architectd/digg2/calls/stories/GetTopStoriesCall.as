package com.architectd.digg2.calls.stories
{
	import com.architectd.digg2.calls.PublicDiggCall;
	import com.architectd.digg2.data.handle.StoryResponseHandler;
	
	public class GetTopStoriesCall extends PublicDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetTopStoriesCall(count:int = 15,page:int = 0, container:String = null, topicName:String = null)
		{
			super("story.getTop",{count:count,
								  offset:page,
								  
								  container:container,
								  topic:topicName},new StoryResponseHandler());
		}
		
		
	}
}