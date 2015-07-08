package com.architectd.twitter2.calls
{
	import com.architectd.service.oauth.OAuthServiceCue;
	import com.architectd.twitter2.TwitterUrls;
	import com.architectd.twitter2.responseHandler.TwitterJSONGetFriendsHandler;
	import com.spice.impl.service.RemoteServiceResult;

	public class GetFriendsCall extends AuthorizedTwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var cursor:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function GetFriendsCall(oauthService:OAuthServiceCue,screen_name:String,cursor:Number = -1)
		{
			this.cursor = cursor;
			
			super(TwitterUrls.TWITTER_GET_FRIENDS_URL,oauthService,new TwitterJSONGetFriendsHandler(),{cursor:cursor});
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function initialize():void
		{
			this.getRequest().setParams({cursor:cursor});
			
			super.initialize();
		}
		
	}
}