package com.architectd.twitter.calls.status
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.dataHandle.StatusDataHandler;
	
	import flash.net.URLRequestMethod;

	public class StatusUpdateCall extends TwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function StatusUpdateCall(status:String,inReplyToStatusId:String = null)
		{
			super("http://twitter.com/statuses/update.xml",new StatusDataHandler(),{status:status,in_reply_to_status_id:inReplyToStatusId},true,URLRequestMethod.POST);
		}
	}
}