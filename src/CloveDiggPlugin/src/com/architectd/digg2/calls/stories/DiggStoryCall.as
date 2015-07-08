package com.architectd.digg2.calls.stories
{
	import com.architectd.digg2.calls.PrivateDiggCall;
	import com.architectd.digg2.data.handle.SuccessResponseHandler;

	public class DiggStoryCall extends PrivateDiggCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggStoryCall(storyId:Number)
		{
			
			super("story.digg",{story_id:storyId},new SuccessResponseHandler());
		}
	}
}