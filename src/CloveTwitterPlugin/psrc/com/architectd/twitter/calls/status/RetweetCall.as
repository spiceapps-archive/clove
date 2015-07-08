package com.architectd.twitter.calls.status
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.dataHandle.StatusDataHandler;

	public class RetweetCall extends TwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RetweetCall(statusId:String)
		{
			
			//SWITCH TO RetweetStatusData
			super("http://api.twitter.com/1/statuses/retweet/"+statusId+".xml",new StatusDataHandler(),null,true);
		}
	}
}