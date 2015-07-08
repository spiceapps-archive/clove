package com.architectd.digg2.calls.stories
{
	import com.architectd.digg2.calls.PrivateDiggCall;
	import com.architectd.digg2.data.handle.SuccessResponseHandler;

	public class BuryStoryCall extends PrivateDiggCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BuryStoryCall(storyId:String)
		{
			super('story.bury',{story_id:storyId},new SuccessResponseHandler(),false);
		}
	}
}