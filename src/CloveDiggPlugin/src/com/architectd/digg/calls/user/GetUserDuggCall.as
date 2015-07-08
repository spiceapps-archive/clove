package com.architectd.digg.calls.user
{
	import com.architectd.digg.calls.DiggCall;
	import com.architectd.digg.data.handle.IResponseHandler;
	import com.architectd.digg.data.handle.StoryResponseHandler;

	public class GetUserDuggCall extends DiggCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetUserDuggCall(user:String)
		{
			super("http://services.digg.com/user/"+user+"/dugg",new StoryResponseHandler());
		}
		
	}
}