package com.architectd.twitter.calls.account
{
	import com.architectd.twitter.calls.TwitterCall;

	public class RateLimitStatusCall extends TwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function RateLimitStatusCall()
		{
			super("http://twitter.com/account/rate_limit_status.xml",null,null,true);
		}
	}
}