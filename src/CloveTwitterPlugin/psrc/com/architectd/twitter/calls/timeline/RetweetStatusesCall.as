package com.architectd.twitter.calls.timeline
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.data.retweet.RetweetStatusesData;

	public class RetweetStatusesCall extends TwitterCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RetweetStatusesCall(statusId:String,count:int = 15)
		{
			super("http://api.twitter.com/1/statuses/retweets/"+statusId+".format",null,{count:count},true);
		}
	}
}