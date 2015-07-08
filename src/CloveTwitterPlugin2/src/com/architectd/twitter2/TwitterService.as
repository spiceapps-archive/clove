package com.architectd.twitter2
{
	import com.architectd.service.oauth.OAuthLoginHelper;
	import com.architectd.service.oauth.OAuthServiceCue;
	import com.architectd.twitter2.calls.AuthorizedTwitterCall;
	import com.architectd.twitter2.calls.GetAllFavoritesCall;
	import com.architectd.twitter2.calls.GetAllFriendsCall;
	import com.architectd.twitter2.calls.GetConversationCall;
	import com.architectd.twitter2.calls.GetFavoritesCall;
	import com.architectd.twitter2.calls.GetFriendsCall;
	import com.architectd.twitter2.calls.TwitterCall;
	import com.architectd.twitter2.responseHandler.TwitterJSONDMHandler;
	import com.architectd.twitter2.responseHandler.TwitterJSONResponseHandler;
	import com.architectd.twitter2.responseHandler.TwitterJSONSearchHandler;
	import com.architectd.twitter2.responseHandler.TwitterJSONSingleStatusResponse;
	import com.architectd.twitter2.responseHandler.TwitterJSONSingleUserResponseHandler;
	import com.architectd.twitter2.responseHandler.TwitterJSONUserTimelineHandler;
	import com.flexoop.utilities.dateutils.DateUtils;
	import com.spice.core.calls.CallRemoteServiceLoadCueType;
	import com.spice.core.queue.ICue;
	import com.spice.impl.queue.Queue;
	import com.spice.impl.service.AbstractRemoteService;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthToken;
	
	public class TwitterService extends AbstractRemoteService
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const MAX_REQUESTS_PER_HOUR:int = 300;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _userName:String;
		private var _loginCue:OAuthServiceCue;
		private var _loginHelper:OAuthLoginHelper;
		private var _followCall:AuthorizedTwitterCall;
		private var _unfollowCall:AuthorizedTwitterCall;
		private var _waitingToFollow:Vector.<String> = new Vector.<String>();
		private var _waitingToUnfollow:Vector.<String> = new Vector.<String>();
		private var _waitingToFavorite:Vector.<Number> = new Vector.<Number>();
		private var _waitingToUnfavorite:Vector.<Number> = new Vector.<Number>();
		
		//yuck
		//		private var _hashMap:Dictionary = new Dictionary(true);
		//TODO for server implementation
		
		/*
		%begin
		if(true)
		print 'public static const CONSUMER_KEY:String = "CONSUMER_KEY_HERE";';
		print 'public static const CONSUMER_SECRET:String = "ff29BApJvsOXAQan1hk6D8KLOBXy0yS7TiAwTy1GSX0";';
		else*/
		
		public static const CONSUMER_KEY:String = "4t9K31sKsnx4RSbsOBOU1g";
		public static const CONSUMER_SECRET:String = "ff29BApJvsOXAQan1hk6D8KLOBXy0yS7TiAwTy1GSX0";
		
		public static const CONSUMER:OAuthConsumer = new OAuthConsumer(CONSUMER_KEY,CONSUMER_SECRET);
		
		/*endif
		end%*/
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterService(loginHelper:OAuthLoginHelper,
									   queue:Queue = null,
									   accessToken:OAuthToken = null,
									   screenName:String = null)
		{
			super(queue);
			
			_loginHelper = loginHelper;
			
			_loginCue = this.getNewOAuthCue(loginHelper,accessToken,screenName);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAccessToken():OAuthToken
		{
			return this._loginCue.getAccessToken();
		}
		
		/**
		 */
		
		public function setAccessToken(value:OAuthToken):void
		{
			this._loginCue.setAccessToken(value);
		}
		/**
		 */
		
		public function getOAuthHeader():URLRequestHeader
		{
			return this._loginCue.getRequestHeader(TwitterUrls.TWITTER_URL_ACCOUNT_AUTH);
		}
		
		/**
		 */
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallTwitterServiceType.GET_TWITTER_ACCESS_TOKEN: return this.respond(c,this._loginCue.getAccessToken());
				case CallTwitterServiceType.GET_TWITTER_USERNAME: return this.respond(c,this._loginCue.getUsername());
			}
			
			super.answerProxyCall(c);
		}
		
		
		/**
		 */
		
		override public function notifyProxyBinding(n:INotification):void
		{
			
			
			switch(n.getType())
			{
				
				//this is yucky code....
				case CallRemoteServiceLoadCueType.SERVICE_RESULT:
					
					
					var url:String = AuthorizedTwitterCall(n.getTarget()).getRequest().getUrl();
					var success:Boolean = n.getData().success();
					
					if(!success) return;
					
					var data:* = n.getData().getData();
					
					if(this.notifyIfCallback(url,TwitterUrls.TWITTER_FRIENDSHIP_CREATE_URL,CallTwitterServiceType.FOLLOWING_TWITTER_USER,this._waitingToFollow,data,"screenName"))
						return;
					
					if(this.notifyIfCallback(url,TwitterUrls.TWITTER_FRIENDSHIP_DELETE_URL,CallTwitterServiceType.UNFOLLOWING_TWITTER_USER,this._waitingToFollow,data,"screenName"))
						return;	
					
					if(this.notifyIfCallback(url,TwitterUrls.TWITTER_FAVORITE_CREATE_BASE_URL,CallTwitterServiceType.FAVORITING_STATUS,this._waitingToFavorite,data,"id"))
						return;
					
					if(this.notifyIfCallback(url,TwitterUrls.TWITTER_FAVORITE_DELETE_BASE_URL,CallTwitterServiceType.UNFAVORITING_SATUS,this._waitingToUnfavorite,data,"id"))
						return;
					
			}
			super.notifyProxyBinding(n);
		}
		
		private function notifyIfCallback(base:String,url:String,change:String,vect:*,data:*,key:String):Boolean
		{
			if(base.indexOf(url) > -1)
			{
				
				var i:int = vect.indexOf(data[key]);
				
				if(i > -1)
				{
					vect.splice(i,1);
				}
				
				this.notifyChange(change,data);
				return true;
			}
			return false;
		}
		
		
		
		/**
		 */
		
		public function verifyLogin():void
		{
			this.addCue(_loginCue);
		}
		/**
		 */
		
		public function loggedIn():Boolean
		{
			return _loginCue.hasAccessToken();
		}
		
		
		
		
		/**
		 */
		
		public function verifyOAuthToken(token:OAuthToken):void
		{
			_loginCue.verifyAccessToken(token);
		}
		
		/**
		 */
		
		public function getFriends(user:String):GetFriendsCall
		{
			return this.addAuthorizedCall(new GetFriendsCall(this._loginCue,user));
		}
		
		/**
		 */
		
		public function getAllFavorites(user:String = null):GetAllFavoritesCall
		{
			return this.addAuthorizedCall(new GetAllFavoritesCall(this._loginCue,user));
		}
		
		/**
		 */
		
		public function getFavorites(user:String = null,page:Number =1):GetFavoritesCall
		{
			return this.addAuthorizedCall(new GetFavoritesCall(user,this._loginCue,page));
		}
		
		/**
		 */
		
		public function favorite(statusId:Number):AuthorizedTwitterCall
		{
			this._waitingToFavorite.push(statusId);
			
			
			var favCall:AuthorizedTwitterCall = new AuthorizedTwitterCall(TwitterUrls.GET_FAV_URL(statusId),this._loginCue,new TwitterJSONSingleStatusResponse(),{id:statusId},URLRequestMethod.POST);
			
			new ProxyBind(favCall.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT],true);
			
			return this.addAuthorizedCall(favCall);
			
		}
		
		/**
		 */
		
		public function getWaitingToFavorite():Vector.<Number>
		{
			return this._waitingToFavorite;
		}
		
		/**
		 */
		
		
		public function unfavorite(statusId:Number):AuthorizedTwitterCall
		{
			this._waitingToUnfavorite.push(statusId);
			
			var unfavCall:AuthorizedTwitterCall = new AuthorizedTwitterCall(TwitterUrls.GET_UNFAV_URL(statusId),this._loginCue,new TwitterJSONSingleStatusResponse(),{id:statusId},URLRequestMethod.POST);
			
			new ProxyBind(unfavCall.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT],true);
			
			return this.addAuthorizedCall(unfavCall);
			
		}
		
		/**
		 */
		
		public function getWaitingToUnfavorite():Vector.<Number>
		{
			return this._waitingToUnfavorite;
		}
		
		/**
		 */
		
		public function follow(user:String):AuthorizedTwitterCall
		{
			this._waitingToFollow.push(user);
			
			this._followCall = new AuthorizedTwitterCall(TwitterUrls.TWITTER_FRIENDSHIP_CREATE_URL,
				this._loginCue,
				new TwitterJSONSingleUserResponseHandler(),
				{
					screen_name:user
				}, URLRequestMethod.POST);
			
			new ProxyBind(this._followCall.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT],true);
			
			return this.addAuthorizedCall(this._followCall);
		}
		
		
		
		
		
		/**
		 */
		public function getWaitingToFollow():Vector.<String>
		{
			return this._waitingToFollow;
		}
		
		/**
		 */
		
		public function unfollow(user:String):AuthorizedTwitterCall
		{
			
			this._waitingToUnfollow.push(user);
			
			this._unfollowCall = new AuthorizedTwitterCall(TwitterUrls.TWITTER_FRIENDSHIP_DELETE_URL,
				this._loginCue,
				new TwitterJSONSingleUserResponseHandler(),
				{
					screen_name:user
				},URLRequestMethod.POST);
			
			new ProxyBind(this._unfollowCall.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT],true);
			
			return this.addAuthorizedCall(this._unfollowCall);
		}
		
		/**
		 */
		
		public function getWaitingToUnfollow():Vector.<String>
		{
			return this._waitingToUnfollow;
		}
		/**
		 */
		
		public function getAllFriends(user:String = null):GetAllFriendsCall
		{
			return this.addAuthorizedCall(new GetAllFriendsCall(this._loginCue,user));
		}
		
		
		/**
		 */
		public function trackConversation(id:Number):GetConversationCall
		{
			
			return this.addCue(new GetConversationCall(id,this._loginCue));
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
				new TwitterJSONSearchHandler(),
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
				new TwitterJSONUserTimelineHandler(),
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
		
		public function getMentions(count:int = 15,
									sinceID:Number = NaN, 
									maxID:Number = NaN):AuthorizedTwitterCall
		{
			return this.makeBasicStatusTimelineCall(TwitterUrls.TWITTER_GET_MENTIONS_URL,count,NaN,sinceID,maxID);
		}
		
		
		/**
		 */
		
		public function getHomeTimeline(count:int 	   = 15,
									sinceID:Number = NaN, 
									maxID:Number   = NaN):AuthorizedTwitterCall
		{
			return this.makeBasicStatusTimelineCall(TwitterUrls.TWIITTER_GET_HOME_TIMELINE_URL,count,NaN,sinceID,maxID);
		}
		
		
		
		/**
		 */
		
		public function getDirectMessages(count:int = 15,
										  page:int = 0, 
										  sinceID:Number = NaN, 
										  maxID:Number = NaN):AuthorizedTwitterCall
		{
			return this.makeBasicStatusTimelineCall(TwitterUrls.TWITTER_GET_DM_URL,count,page,sinceID,maxID);
		}
		
		
		
		
		
		/**
		 */
		
		public function updateStatus(status:String,
									 inReplyToStatusId:Number = NaN,
									 lat:String = null,
									 long:String = null,
									 placeId:String = null,
									 displayCoordinates:Boolean = true):AuthorizedTwitterCall
		{
			return this.addAuthorizedCall(new AuthorizedTwitterCall(TwitterUrls.TWITTER_UPDATE_STATUS_URL,
				_loginCue,
				new TwitterJSONResponseHandler(),
				{
					status:status,
					in_reply_to_status_id:inReplyToStatusId,
					lat:lat,
					long:long,
					place_id:placeId,
					display_coordinates:displayCoordinates
				}, 
				URLRequestMethod.POST));
		}
		
		
		/**
		 */
		
		
		public function sendDirectMessage(screenName:String,message:String):AuthorizedTwitterCall
		{
			return this.addAuthorizedCall(new AuthorizedTwitterCall(TwitterUrls.TWITTER_SEND_DM_URL,
				_loginCue,
				new TwitterJSONResponseHandler(),
				{
					screen_name:screenName,
					text:message
				}, 
				URLRequestMethod.POST));
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		private function makeBasicStatusTimelineCall(url:String,
													 count:int = 15,
													 page:Number = NaN, 
													 sinceID:Number = NaN, 
													 maxID:Number = NaN):AuthorizedTwitterCall
		{
			return this.addAuthorizedCall(new AuthorizedTwitterCall(url,
				_loginCue,
				new TwitterJSONDMHandler(),
				{
					/*count:count,*/
					page:page,
					since_id:sinceID,
					max_id:maxID
				}));
		}
		
		/**
		 */
		
		public function addAuthorizedCall(call:ICue):*
		{
			if(!this._loginCue.hasAccessToken())
			{
				this.addCue(_loginCue);
			}
			
			return this.addCue(call);
		}
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			super.addAvailableCalls([CallTwitterServiceType.GET_TWITTER_ACCESS_TOKEN,
				CallTwitterServiceType.GET_TWITTER_USERNAME]);
		}
		
		/**
		 */
		
		
		
		protected function getNewOAuthCue(helper:OAuthLoginHelper,accessToken:OAuthToken = null,screenName:String = null):OAuthServiceCue
		{
			return new OAuthServiceCue(CONSUMER_KEY,
				CONSUMER_SECRET,
				TwitterUrls.TWITTER_URL_OAUTH_REQUST,
				TwitterUrls.TWITTER_URL_OAUTH_ACCESS,
				TwitterUrls.TWITTER_URL_OAUTH_AUTHORIZE,
				TwitterUrls.TWITTER_URL_ACCOUNT_AUTH,
				"screen_name",
				helper,
				accessToken,
				screenName);
		}
		
		
		/**
		 */
		
		override protected function cueComplete(data:*,cue:ICue):void
		{
			if(cue == this._loginCue)
			{
				this.notifyChange(CallTwitterServiceType.GET_TWITTER_ACCESS_TOKEN,this._loginCue.getAccessToken());
				this.notifyChange(CallTwitterServiceType.GET_TWITTER_USERNAME,this._loginCue.getUsername());
			}
			
			
			
			
			super.cueComplete(data,cue);
		}
	}
}