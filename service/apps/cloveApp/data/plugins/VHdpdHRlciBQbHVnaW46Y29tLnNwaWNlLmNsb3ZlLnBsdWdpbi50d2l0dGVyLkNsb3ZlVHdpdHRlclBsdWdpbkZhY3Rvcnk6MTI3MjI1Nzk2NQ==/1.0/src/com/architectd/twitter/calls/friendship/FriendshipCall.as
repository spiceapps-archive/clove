package com.architectd.twitter.calls.friendship
{
	import com.architectd.twitter.calls.TwitterCall;

	public class FriendshipCall extends TwitterCall
	{
		public function FriendshipCall(method:String,screenName:String,params:Object = null)
		{
			params = params ? params : {};
			
			params.screen_name = screenName;
			
			super("http://twitter.com/friendships/"+method+".xml",null,params,true);
		}
	}
}