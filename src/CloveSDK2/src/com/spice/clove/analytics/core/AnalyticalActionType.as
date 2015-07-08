package com.spice.clove.analytics.core
{
	
	
	
	/**
	 * one important thing to note about analytical types that record time spend is the IDLING TIME. What
	 * if the user isn't at the computer, and leaves Clove open? What about overnight? Idling users can easily screw up 
	 * the average, so within the app, there needs to be a THRESHOLD of time before sending to the server. This is depends
	 * on the type of action though. For an HTML page, we'll give about 10 minutes.
	 * @author craigcondon
	 * 
	 */	
	public class AnalyticalActionType
	{
		
		/**
		 * any link selected 
		 */		
		
		public static const LINK_SELECTED:String 	    = "linkSelected";
		
		
		/**
		 * this is set when a feed is currently on the screen. It's sent to the server
		 * once the user switches groups 
		 */		
		
		public static const TIME_VIEWING_FEED:String = "timeViewingFeed";
		
		/**
		 * the time spent viewing content in the internal HTML window
		 */
		
		public static const TIME_VIEWING_HTML_PAGE:String = "timeViewingInternalHtmlPage";
		
		
		/**
		 * sent once the application has been opened. Give an idea when people use the application
		 */
		
		public static const APPLICATION_OPENED:String = "applicationOpened";
		
		
		/**
		 * ???????
		 */
		
		public static const APPLICATION_CLOSED:String = "applicationClosed";
		
		
		/**
		 * the total time the application has been alive for 
		 */		
		
		public static const APPLICATION_LIVE_TIME:String = "applicationLiveTime";
		
		/**
		 * set when a link is sent out from the post window
		 */
		
		public static const LINK_SHARED:String = "linkShared";
		
		/**
		 * called when a url is loaded. This can be used easily for any plugin
		 * that doesn't have built-in search capabilities, such as RSS
		 */		
		
		public static const FEED_LOADED:String = "feedLoaded";
		
		
		/**
		 * the time spent interacting with the application. If the user
		 * stops interacting for a duration of time (10 minutes?) the active_time
		 * analytical information will be sent logging the duration they've use the app for
		 */
		
		public static const ACTIVE_TIME:String = "activeTime";
		
		
		/**
		 * called when a keyword has been entered for a particular feed. This is set
		 * in the search: [            ] field for Twitter, Facebook, user search, etc. 
		 * it's up to the PLUGIN however to define whether the field is a keyword, url, user, etc.
		 */		
		
		public static const KEYWORD_SEARCH:String = "keywordSearch";
		
		
		
		/**
		 * TO IMPLEMENT LATER!!!! this is tied into the attachments seen for each
		 * column row. Right now they're defined by the PLUGIN, but later the plugin must
		 * specify a generic type such as embeddedVideoUrl, picture, etc. in that case, we concat
		 * metadata and send them to the analytics ~ embeddedVideoUrl_selected,picture_selected....
		 */
		
		public static const METADATA_SELECTED:String = "metadataSelected";
		
	}
}