package com.architectd.digg2.calls.stories
{
	import com.architectd.digg2.calls.PublicDiggCall;
	import com.architectd.digg2.data.handle.CommentHandler;
	
	public class GetStoryCommentsCall extends PublicDiggCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function GetStoryCommentsCall(storyId:String,count:Number = 100,offset:Number = 0,sort:String = null)
		{
			super("story.getComments",{story_id:storyId,count:count,offset:offset},new CommentHandler());
		}

	}
}