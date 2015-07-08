package com.architectd.digg2.calls.user
{
	import com.architectd.digg2.calls.DiggCall;
	import com.architectd.digg2.data.UserData;
	import com.architectd.digg2.data.handle.IResponseHandler;
	import com.architectd.digg2.calls.PublicDiggCall;

	public class GetUserFriendsCall extends PublicDiggCall implements IResponseHandler
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var count:Number;
		public var page:Number;
		public var total:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructorhtt
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetUserFriendsCall(username:String,count:int = 100,page:int = 0)
		{
			
			super("friend.getAll",{count:count,offset:page,username:username},this);
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
			
			
			this.count = ex.@count;
			this.page  = ex.@offset;
			this.total = ex.@total;
			
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