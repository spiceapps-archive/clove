package com.architectd.digg2.calls.search
{
	import com.architectd.digg2.calls.PublicDiggCall;
	import com.architectd.digg2.data.handle.IResponseHandler;
	import com.architectd.digg2.data.handle.StoryResponseHandler;

	public class DiggSearchStoriesCall extends PublicDiggCall
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggSearchStoriesCall(query:String,count:Number = NaN,page:Number = NaN)
		{
			super("search.stories",{query:query,count:count,offset:page,sort:'submit_date-desc'},new StoryResponseHandler());
			
			
		}
		
	}
}