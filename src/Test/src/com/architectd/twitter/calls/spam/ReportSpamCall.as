package com.architectd.twitter.calls.spam
{
	import com.architectd.twitter.calls.TwitterCall;

	public class ReportSpamCall extends TwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function ReportSpamCall(screenName:String)
		{
			super("http://twitter.com/report_spam.xml",null,{screen_name:screenName},true);
		}
	}
}