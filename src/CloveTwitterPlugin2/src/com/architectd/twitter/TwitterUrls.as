package com.architectd.twitter
{
	public class TwitterUrls
	{
		public static const TWITTER_URL_BASE:String = "http://twitter.com/";


		//OAuth
		public static const TWITTER_URL_OAUTH_BASE:String = TWITTER_URL_BASE+"oauth/";
		public static const TWITTER_URL_OAUTH_REQUST:String = TWITTER_URL_OAUTH_BASE+"request_token/";
		public static const TWITTER_URL_OAUTH_ACCESS:String = TWITTER_URL_OAUTH_BASE+"access_token/";
		public static const TWITTER_URL_OAUTH_AUTHORIZE:String = TWITTER_URL_OAUTH_BASE+"authorize/";
//		public static const TWITTER_URL_OAUTH_VERIFY_URL:String = TWITTER_URL_OAUTH_BASE+"authorize/";
		//public static const TWITTER_URL_OAUTH_AUTHORIZE:String = TWITTER_URL_OAUTH_BASE+"authorize/";
		
		//account
		public static const TWITTER_URL_ACCOUNT_BASE:String = TWITTER_URL_BASE+"account/";
		public static const TWITTER_URL_ACCOUNT_AUTH:String = TWITTER_URL_ACCOUNT_BASE+"verify_credentials.json";
		
		//search
		
		public static const TWITTER_SEARCH_BASE_URL:String = "http://search.twitter.com/";//TWITTER_URL_BASE+"search.json";
		public static const TWITTER_SEARCH_URL:String = TWITTER_SEARCH_BASE_URL+"search.atom";
		
		//status
		public static const TWITTER_STATUS_BASE_URL:String = "http://twitter.com/statuses/";
		public static const TWITTER_USER_TIMELINE_URL:String = TWITTER_STATUS_BASE_URL+"user_timeline.xml";
	}
}