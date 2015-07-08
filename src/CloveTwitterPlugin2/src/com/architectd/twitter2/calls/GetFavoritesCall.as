package com.architectd.twitter2.calls
{
	import com.architectd.service.oauth.OAuthServiceCue;
	import com.architectd.twitter2.responseHandler.TwitterJSONDMHandler;

	public class GetFavoritesCall extends AuthorizedTwitterCall
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var page:int;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetFavoritesCall(screenName:String,oauthService:OAuthServiceCue,page:int = 1)
		{
			this.page = page;
			
			super(screenName ? "http://api.twitter.com/1/favorites/"+screenName+".json" : "http://api.twitter.com/1/favorites.json",oauthService,new TwitterJSONDMHandler(),{page:page});
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
			this.getRequest().setParams({page:page});
			
			super.initialize();
		}
	}
}