package com.architectd.twitter.calls.dm
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.dataHandle.DMHandler;

	public class GetDirectMessageCall extends TwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function GetDirectMessageCall(count:int = 15,page:int = 0,sinceID:Number = NaN,maxID:Number = NaN)
		{
			super("http://twitter.com/direct_messages.xml",new DMHandler(),{count:count,page:page,since_id:sinceID,max_id:maxID},true);
		}
	}
}