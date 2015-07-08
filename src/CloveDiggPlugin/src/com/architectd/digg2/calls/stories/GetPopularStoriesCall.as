package com.architectd.digg2.calls.stories
{
	import com.architectd.digg2.calls.PublicDiggCall;
	import com.architectd.digg2.data.handle.StoryResponseHandler;
	
	public class GetPopularStoriesCall extends PublicDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetPopularStoriesCall(container:String = null,count:int = 15,max_submit_date:Date = null,min_submit_date:Date = null)
		{
			super("story.getPopular",{container:container,
									  max_submit_date:max_submit_date ? max_submit_date.getTime()/1000 : NaN,
									  min_submit_date:min_submit_date ? min_submit_date.getTime()/1000 : NaN,
									  count:count},new StoryResponseHandler());
			
		}
	}
}