package com.architectd.twitter.calls.list
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.dataHandle.TimelineDataHandler;

	public class GetListStatusesCall extends TwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function GetListStatusesCall(count:int = 15,page:int = 0)
		{
			super("http://api.twitter.com/1/user/lists/list_id/statuses.xml",new TimelineDataHandler(),{per_page:count,page:page});
		}
	}
}