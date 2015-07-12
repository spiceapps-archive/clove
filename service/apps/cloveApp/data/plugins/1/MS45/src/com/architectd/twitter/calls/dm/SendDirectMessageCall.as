package com.architectd.twitter.calls.dm
{
	import com.architectd.twitter.calls.TwitterCall;
	
	import flash.net.URLRequestMethod;

	public class SendDirectMessageCall extends TwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function SendDirectMessageCall(screenName:String,text:String)
		{
			super("http://twitter.com/direct_messages/new.xml",null,{screen_name:screenName,text:text},true,URLRequestMethod.POST);
		}
	}
}