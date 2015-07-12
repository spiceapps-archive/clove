package com.architectd.twitter.calls.user
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.dataHandle.GetFriendsDataHandler;

	public class GetFriendsCall extends TwitterCall
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var nextCursor:Number;
		public var previousCursor:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function GetFriendsCall(screenName:String = null,cursor:Number = -1)
		{
			super("http://twitter.com/statuses/friends.xml",new GetFriendsDataHandler(),{cursor:cursor,screen_name:screenName},false,'get'/* ,-1 */);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		override protected function getData(data:*) : *
		{
			var rData:*	    = super.getData(data);
			
			this.nextCursor     = GetFriendsDataHandler(this.dataHandler).nextCursor;
			this.previousCursor = GetFriendsDataHandler(this.dataHandler).previousCursor;
			
			return rData;
		}
	}
}