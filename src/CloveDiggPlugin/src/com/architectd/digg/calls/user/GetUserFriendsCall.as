package com.architectd.digg.calls.user
{
	import com.architectd.digg.calls.DiggCall;
	import com.architectd.digg.data.UserData;
	import com.architectd.digg.data.handle.IResponseHandler;

	public class GetUserFriendsCall extends DiggCall implements IResponseHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetUserFriendsCall(username:String)
		{
			super("http://services.digg.com/user/"+username+"/friends",this);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getResult(raw:String):Array
		{
			var r:Array = [];
			
			
			var ex:XML = new XML(raw);
			var ud:UserData;
			
			for each(var user:XML in ex.user)
			{
				ud = new UserData(user.@name,
								  user.@registered,
								  user.@profileviews,
								  user.@icon,
								  user.@mutual as Boolean);
				
				r.push(ud);
			}
			
			return r;
		}
	}
}