package com.architectd.twitter.calls.friendship
{
	public class CreateFriendshipCall extends FriendshipCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function CreateFriendshipCall(screenName:String,follow:Boolean = true)
		{
			super("create",screenName,{follow:follow});
		}
	}
}