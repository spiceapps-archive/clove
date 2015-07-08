package com.architectd.twitter
{
	import com.architectd.service.oauth.OAuthLoginHelper;
	import com.architectd.service.oauth.OAuthServiceCue;
	import com.architectd.twitter.calls.ITwitterCall;
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.calls.search.KeywordSearchCall;
	import com.architectd.twitter.calls.search.SearchBasedCall;
	import com.architectd.twitter.calls.timeline.UserTimelineCall;
	import com.architectd.twitter.data.search.KeywordSearchItemData;
	import com.architectd.twitter.dataHandle.AtomDataHandler;
	import com.architectd.twitter.dataHandle.TimelineDataHandler;
	import com.flexoop.utilities.dateutils.DateUtils;
	import com.spice.utils.queue.QueueManager;
	import com.spice.utils.queue.cue.ICue;
	
	import org.iotashan.oauth.OAuthToken;
	
	public class Twitter
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _queue:QueueManager;
		private var _oauthCue:OAuthServiceCue;
		private var _oauthHelper:OAuthLoginHelper;
		private var _consumerKey:String = "4t9K31sKsnx4RSbsOBOU1g";
		private var _consumerSecret:String = "ff29BApJvsOXAQan1hk6D8KLOBXy0yS7TiAwTy1GSX0";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function Twitter(oauthHelper:OAuthLoginHelper,accessToken:OAuthToken = null)
		{
			_queue = new QueueManager();
			
			_oauthCue = this.newOAuthHelper(oauthHelper,accessToken);
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function newOAuthHelper(helper:OAuthLoginHelper,accessToken:OAuthToken = null):OAuthServiceCue
		{
			return new OAuthServiceCue(_consumerKey,
										_consumerSecret,
										TwitterUrls.TWITTER_URL_OAUTH_REQUST,
										TwitterUrls.TWITTER_URL_OAUTH_ACCESS,
										TwitterUrls.TWITTER_URL_OAUTH_AUTHORIZE,
										TwitterUrls.TWITTER_URL_ACCOUNT_AUTH,
										"screen_name",
										helper,
										accessToken);
		}
		
		
		/**
		 */
		
		public function verifyOAuthToken(token:OAuthToken):void
		{
			_oauthCue.verifyAccessToken(token);
		}
		
		/**
		 */
		
		public function search(keyword:String,
							   num:Number = 15,
							   page:Number = 0,
							   sinceDate:Date = null,
							   untilDate:Date = null,
							   sinceId:Number = NaN,
							   maxID:Number = NaN):TwitterCall
		{
			
			
			return this.addCue(new TwitterCall(TwitterUrls.TWITTER_SEARCH_URL,
												new AtomDataHandler(KeywordSearchItemData),
												{
													q:keyword,
													rpp:num,
													page:page,
													since:sinceDate ? DateUtils.dateFormat(sinceDate,"YYYY-MM-DD") : null,
													until:untilDate ? DateUtils.dateFormat(untilDate,"YYYY-MM-DD") : null,
													since_id:sinceId,
													max_id:maxID
												}));
		
		}
		
		
		/**
		 */
		
		public function getUserTimeline(screenName:String = null,
										count:int = 15,
										page:int = 0,
										sinceID:Number = NaN,
										maxID:Number = NaN):TwitterCall
		{
			return this.addCue(new TwitterCall(TwitterUrls.TWITTER_USER_TIMELINE_URL,
											   new TimelineDataHandler(),
											   {
												   count:count,
												   page:page,
												   screen_name:screenName,
												   since_id:sinceID,
												   max_id:maxID
											   }));
		}
		
		
		
		/**
		 */
		
		public function addCue(cue:ICue):*
		{
			_queue.addCue(cue);
			return cue;
		}
		
		
		
		
		
	}
}