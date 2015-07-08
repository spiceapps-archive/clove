package com.architectd.twitter2
{
	public class TwitterUrls
	{
		public static const TWITTER_URL_BASE:String = "http://twitter.com/";


		//OAuth
		public static const TWITTER_URL_OAUTH_BASE:String = TWITTER_URL_BASE+"oauth/";
		public static const TWITTER_URL_OAUTH_REQUST:String = TWITTER_URL_OAUTH_BASE+"request_token/";
		public static const TWITTER_URL_OAUTH_ACCESS:String = TWITTER_URL_OAUTH_BASE+"access_token/";
		public static const TWITTER_URL_OAUTH_AUTHORIZE:String = TWITTER_URL_OAUTH_BASE+"authorize";
//		public static const TWITTER_URL_OAUTH_VERIFY_URL:String = TWITTER_URL_OAUTH_BASE+"authorize/";
		//public static const TWITTER_URL_OAUTH_AUTHORIZE:String = TWITTER_URL_OAUTH_BASE+"authorize/";
		
		//account
		public static const TWITTER_URL_ACCOUNT_BASE:String = TWITTER_URL_BASE+"account/";
		public static const TWITTER_URL_ACCOUNT_AUTH:String = "https://api.twitter.com/1/account/verify_credentials.json";//TWITTER_URL_ACCOUNT_BASE+"verify_credentials.json";
		
		
		//search
		
		public static const TWITTER_SEARCH_BASE_URL:String = "http://search.twitter.com/";//TWITTER_URL_BASE+"search.json";
		public static const TWITTER_SEARCH_URL:String = TWITTER_SEARCH_BASE_URL+"search.json";
		
		//status
		public static const TWITTER_STATUS_BASE_URL:String   = "http://twitter.com/statuses/";
		public static const TWITTER_USER_TIMELINE_URL:String = TWITTER_STATUS_BASE_URL+"user_timeline.json";
		public static const TWITTER_UPDATE_STATUS_URL:String = TWITTER_STATUS_BASE_URL+"update.json";
		public static const TWITTER_SEND_DM_URL:String 		 = "http://twitter.com/direct_messages/new.json";
		public static const TWITTER_GET_DM_URL:String 		 = "http://api.twitter.com/1/direct_messages.json";
		public static const TWITTER_GET_MENTIONS_URL:String  = TWITTER_STATUS_BASE_URL+"mentions.json";
		public static const TWIITTER_GET_HOME_TIMELINE_URL:String  = TWITTER_STATUS_BASE_URL+"home_timeline.json";
		public static const TWITTER_GET_FRIENDS_URL:String   = TWITTER_STATUS_BASE_URL+"friends.json";
		
		
		//friendships
		public static const TWITTER_FRIENDSHIP_BASE_URL:String = "http://api.twitter.com/1/friendships/";
		public static const TWITTER_FRIENDSHIP_CREATE_URL:String = "http://api.twitter.com/1/friendships/create.json";
		public static const TWITTER_FRIENDSHIP_DELETE_URL:String = "http://api.twitter.com/1/friendships/destroy.json";
		
		
		//fav
		public static const TWITTER_FAVORITE_BASE_URL:String = "http://api.twitter.com/1/favorites/";
		public static const TWITTER_FAVORITE_CREATE_BASE_URL:String = "http://api.twitter.com/1/favorites/create/";
		public static const TWITTER_FAVORITE_DELETE_BASE_URL:String = "http://api.twitter.com/1/favorites/destroy/";
		
		public static function  GET_FAV_URL(id:Number):String
		{
			return TWITTER_FAVORITE_CREATE_BASE_URL+id+".json";
		}
		
		public static function  GET_UNFAV_URL(id:Number):String
		{
			return TWITTER_FAVORITE_DELETE_BASE_URL+id+".json";
		}
			
		
		
	}
}