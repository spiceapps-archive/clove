package com.architectd.digg2.calls.stories
{
	import com.architectd.digg2.calls.PublicDiggCall;
	import com.architectd.digg2.data.handle.StoryResponseHandler;

	public class GetAllStoriesCall extends PublicDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetAllStoriesCall(container:String = null,count:int = 15,max_submit_date:Date = null,min_submit_date:Date = null)
		{	
			super("story.getAll",{container:container,
								  count:count,
								  max_promote_date:NaN,
								  max_submit_date:max_submit_date ? max_submit_date.getTime() : NaN,
								  media:null,
								  min_promote_date:NaN,
								  min_submit_date:min_submit_date ? min_submit_date.getTime() : NaN,
								  offset:NaN,
								  sort:null,
								  story_ids:null,
								  topic:null},new StoryResponseHandler());
			
		}
	}
}