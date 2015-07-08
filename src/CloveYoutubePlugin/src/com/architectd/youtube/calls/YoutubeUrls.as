package com.architectd.youtube.calls
{
	public class YoutubeUrls
	{
		
		//OAUTH
		public static const OAUTH_GET_REQUEST_TOKEN_URL:String = "https://www.google.com/accounts/OAuthGetRequestToken";
		public static const OAUTH_AUTHORIZE_URL:String = "https://www.google.com/accounts/Authorize";
		public static const OAUTH_ACCESS_URL:String = "https://www.google.com/accounts/Authorize";
		
		
		//base
		public static const BASE_URL:String = "http://gdata.youtube.com/feeds/";
		
		//search
		public static const SEARCH_TOP_RATED:String       = BASE_URL+"api/standardfeeds/top_rated";
		public static const SEARCH_TOP_FAVORITES:String   = BASE_URL+"api/standardfeeds/top_favorites";
		public static const SEARCH_MOST_VIEWED:String     = BASE_URL+"api/standardfeeds/most_viewed";
		public static const SEARCH_MOST_POPULAR:String    = BASE_URL+"api/standardfeeds/most_popular";
		public static const SEARCH_MOST_RECENT:String     = BASE_URL+"api/standardfeeds/most_recent";
		public static const SEARCH_MOST_DISCUSSED:String  = BASE_URL+"api/standardfeeds/most_discussed";
		public static const SEARCH_MOST_RESPONDED:String  = BASE_URL+"api/standardfeeds/most_responded";
		public static const SEARCH_MOST_RECENTLY_FEATURED:String  = BASE_URL+"api/standardfeeds/most_featured";
		public static const SEARCH_VIDEOS_FOR_MOBILE:String       = BASE_URL+"api/standardfeeds/watch_on_mobile"; //not likely to be used for desktop bersion
		
		public static const  SEARCH_VIDEOS_BASE:String = BASE_URL+"api/videos";
		
		//user
		public static function GET_USER_VIDEOS(name:String):String
		{
			return BASE_URL+"api/users/"+name+"/uploads";
		}
		
		
		public static function GET_EMBED_URL(id:String):String
		{
			return "http://www.youtube.com/v/"+id+"&hl=en_US&fs=1&";
		}
		
		/**
		 */
		
		public static function GET_EMBED_ICON_SMALL(id:String):String
		{
			return "http://i.ytimg.com/vi/"+id+"/2.jpg"; //2 is small, 0 is big
		}
		
		public static function GET_EMBED_ICON_BIG(id:String):String
		{
			return "http://i.ytimg.com/vi/"+id+"/0.jpg"; //2 is small, 0 is big
		}
	}
}