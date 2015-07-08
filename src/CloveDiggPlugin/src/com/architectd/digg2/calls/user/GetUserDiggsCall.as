package com.architectd.digg2.calls.user
{
	import com.architectd.digg2.calls.PublicDiggCall;
	import com.architectd.digg2.data.handle.UserDiggResponseHandler;
	
	public class GetUserDiggsCall extends PublicDiggCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function GetUserDiggsCall(username:String,count:Number = 100,offset:Number = 0)
		{
			super("user.getDiggs",{username:username,count:count,offset:offset},new UserDiggResponseHandler());
		}
		
	}
}