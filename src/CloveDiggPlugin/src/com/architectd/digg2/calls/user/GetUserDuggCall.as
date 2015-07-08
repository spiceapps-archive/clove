package com.architectd.digg2.calls.user
{
	import com.architectd.digg2.calls.PublicDiggCall;
	import com.architectd.digg2.data.handle.StoryResponseHandler;

	public class GetUserDuggCall extends PublicDiggCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetUserDuggCall(user:String,count:int = 15,min_date:Date= null,max_date:Date = null)
		{
			super("user.getDugg",{username:user,
									count:count,
									min_date:min_date ? min_date.getTime() : NaN,
									max_date:max_date ? max_date.getTime() : NaN},new StoryResponseHandler());
		}
		
	}
}