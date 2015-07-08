package com.spice.clove.twitter.impl.account
{
	import com.architectd.service.oauth.OAuthLoginHelper;
	import com.architectd.twitter2.CallTwitterServiceType;
	import com.architectd.twitter2.TwitterService;
	import com.architectd.twitter2.calls.GetAllFavoritesCall;
	import com.architectd.twitter2.calls.GetAllFriendsCall;
	import com.architectd.twitter2.data.TwitterStatusData;
	import com.architectd.twitter2.data.TwitterUserData;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.data.ToasterNotificationData;
	import com.spice.clove.post.core.calls.CallCloveAttachmentUploaderType;
	import com.spice.clove.post.core.outgoing.ICloveAttachmentUploader;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.textCommands.core.calls.CallTextCommandsPluginType;
	import com.spice.clove.twitter.core.calls.CallTwitterPluginType;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.account.settings.TwitterAccountSettings;
	import com.spice.clove.twitter.impl.outgoing.TwitterWallPostable;
	import com.spice.clove.twitter.impl.text.command.UsernameTooltipCommandHandler;
	import com.spice.core.calls.CallRemoteServiceLoadCueType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.net.URLRequestHeader;
	import flash.utils.setTimeout;
	
	public class TwitterPluginAccount extends AbstractServiceAccount implements IProxyResponseHandler, IProxyBinding
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _service:TwitterService;
		private var _helper:OAuthLoginHelper;
		private var _getAllFriendsCue:GetAllFriendsCall;
		private var _getAllFavsCue:GetAllFavoritesCall;
		private var _settings:TwitterAccountSettings;
		private var _attachmentUploaders:Vector.<ICloveAttachmentUploader>;
		private var _defaultUploaders:Object;
		private var _plugin:TwitterPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterPluginAccount(oauthHelper:OAuthLoginHelper)
		{
			
			super((_settings = new TwitterAccountSettings()));
			
			this._defaultUploaders = {};
			
			//			this.setContentControllerFactory(new TwitterContentControllerFactory(this));
			
			_helper = oauthHelper;
			
		}
		
		
		//--------------------------------------------------------------------------
		//  
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get connection():TwitterService
		{
			if(!this._service)
			{
				this._service = new TwitterService(_helper,
					null,
					this._settings.getAccessToken().getData(),
					this._settings.getScreenName().getData());
				
				
				
				new ProxyBind(this._service.getProxy(),this,[CallTwitterServiceType.GET_TWITTER_USERNAME,
					CallTwitterServiceType.FOLLOWING_TWITTER_USER,
					CallTwitterServiceType.UNFOLLOWING_TWITTER_USER,
					CallTwitterServiceType.UNFAVORITING_SATUS,
					CallTwitterServiceType.FAVORITING_STATUS]);
				
				//bind the access token, and screen name to the settings
				this._settings.getAccessToken().bindTo(this._service.getProxy(),CallTwitterServiceType.GET_TWITTER_ACCESS_TOKEN);
				this._settings.getScreenName().bindTo(this._service.getProxy(),CallTwitterServiceType.GET_TWITTER_USERNAME);
				
				
				
				
				//if no access token, then login
				if(!this._settings.getAccessToken().getData())
				{
					
					//verify the login credentials incase the access token is bad, or this is the first logging in
					this._service.verifyLogin();
				}
				
				
				
			}
			
			
			return this._service;
		}
		
		
		/**
		 */
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallTwitterPluginType.TWITTER_PLUGIN_GET_OAUTH_HEADER: return this.respond(c,this.getOAuthHeader());
			}
			
			
			super.answerProxyCall(c);
		}
		
		
		/**
		 */
		public function getTwitterSettings():TwitterAccountSettings
		{
			return this._settings;
		}
		
		
		/**
		 */
		
		public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				//on twitter username change, store it in the settings so we don't have to make another call 
				case CallTwitterServiceType.GET_TWITTER_USERNAME: 
					return this.setName(n.getData());
				case CallTwitterServiceType.FOLLOWING_TWITTER_USER: return this.followUser(n.getData());
				case CallTwitterServiceType.UNFOLLOWING_TWITTER_USER: return this.unfollowUser(n.getData());
				case CallTwitterServiceType.FAVORITING_STATUS: return this.favStatus(n.getData());
				case CallTwitterServiceType.UNFAVORITING_SATUS: return this.unfavStatus(n.getData());
					
			}
			
		}
		
		
		
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallRemoteServiceLoadCueType.SERVICE_RESULT:
					
					//we're looking the the get all friends cue, so if it exists, handle it. Otherwise pass it to the super
					//method
					if(n.getCurrentTarget() == this._getAllFriendsCue)
					{
						this._getAllFriendsCue = null;
						
						//store all the methods
						return this._settings.storeFollowing(n.getData().getData());	
					}
					else
						if(n.getCurrentTarget() == this._getAllFavsCue)
						{
							this._getAllFavsCue = null;
							
							return this._settings.storeFavorites(n.getData().getData());
						}
			}
			
			this.handleProxyResponse(n);
			
		}
		
		
		/**
		 */
		
		override public function initialize(value:AbstractServicePlugin):void
		{
			super.initialize(value);
			_plugin = TwitterPlugin(value);
			
			this.setName(this._settings.getScreenName().getData());
			
			
			
			this.addPostable(new TwitterWallPostable(this));

		}
		
		
		/**
		 */
		
		public function getTwitterPlugin():TwitterPlugin
		{
			return this._plugin;
		}
		
		
		/**
		 */
		
		override public function applicationInitialized():void
		{
			super.applicationInitialized();
			

			
			
			//we add a delay to getting all friends since Twitter only allows one request. If the 
			//user has LOTS of friends, it will take a long time before they see any feeds.
			flash.utils.setTimeout(syncWithTwitter,10000);
			
			//register a text command
			ProxyCallUtils.quickCall(CallTextCommandsPluginType.TEXT_COMMANDS_REGISTER_INPUT_EVALUATOR,this.getPluginMediator(),new UsernameTooltipCommandHandler(this));
		}
		
		
		/**
		 */
		
		public function addPluginUploader(value:ICloveAttachmentUploader):void
		{
			
			new ProxyCall(CallCloveAttachmentUploaderType.SET_OWNER,value.getProxy(),this).dispatch().dispose();
			
			this.getAttachmentUploaders().push(value);
			
			
			
			for each(var supportedFileType:String in value.getSupportedFileTypes())
			{
				var defaultUploaderName:String = this._settings.getDefaultUploader(supportedFileType);
				
				
				//if it doesn't exist, or the uploader name is the att name
				if(!defaultUploaderName || defaultUploaderName == value.getName())
				{
					this.setDefaultAttachmentUploader(supportedFileType,value);
				}
			}
			
		}
		
		/**
		 */
		
		public function getDefaultUploader(fileType:String):ICloveAttachmentUploader
		{
			return this._defaultUploaders[fileType];
		}
		
		/**
		 */
		
		public function getAttachmentUploaders():Vector.<ICloveAttachmentUploader>
		{
			if(!this._attachmentUploaders)
			{
				this._attachmentUploaders = new Vector.<ICloveAttachmentUploader>();
			}
			
			return _attachmentUploaders;
		}
		
		
		/**
		 */
		
		public function getDefaultAttachmentUploader(type:String):ICloveAttachmentUploader
		{
			return this._defaultUploaders[type];
		}
		
		/**
		 */
		
		public function setDefaultAttachmentUploader(type:String,value:ICloveAttachmentUploader):void
		{
			this._settings.setDefualtUploader(type,value.getName());
			this._defaultUploaders[type] = value;
		}
		
		/**
		 */

		
		/**
		 */
		
		public function getOAuthHeader():URLRequestHeader
		{
			return this.connection.getOAuthHeader();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallTwitterPluginType.TWITTER_PLUGIN_REGISTER_ATTACHMENT_UPLOADER,
				CallTwitterPluginType.TWITTER_PLUGIN_GET_OAUTH_HEADER]);
		}
		/**
		 */  
		
		protected function followUser(user:TwitterUserData):void
		{
			
			this._settings.getFollowing().addString(user.screenName);
			
			
			ProxyCallUtils.quickCall(CallAppCommandType.DISPATCH_TOASTER_NOTIFICATION,this.getPluginMediator(),new ToasterNotificationData(this.getName(),"Following user "+user.screenName,this.getPluginFactory().getIcon32()))
		}
		
		/**
		 */  
		
		protected function unfollowUser(user:TwitterUserData):void
		{
			this._settings.getFollowing().removeString(user.screenName);
			
			ProxyCallUtils.quickCall(CallAppCommandType.DISPATCH_TOASTER_NOTIFICATION,this.getPluginMediator(),new ToasterNotificationData(this.getName(),"Unfollowing user "+user.screenName,this.getPluginFactory().getIcon32()));
		}
		
		
		/**
		 */
		
		protected function favStatus(data:TwitterStatusData):void
		{
			this._settings.getFavorites().addNumber(data.id);
		}
		
		/**
		 */
		
		protected function unfavStatus(data:TwitterStatusData):void
		{
			this._settings.getFavorites().removeNumber(data.id);
		}
		
		/**
		 */
		
		
		
		
		/**
		 */
		
		private function syncWithTwitter():void
		{
			
			if(_getAllFriendsCue)
				return;
			
			
			//make the call
			_getAllFavsCue    = this.connection.getAllFavorites();
			_getAllFriendsCue = this.connection.getAllFriends();
			
			
			//get all of the friends
			this.addDisposable(new ProxyBind(_getAllFriendsCue.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT],true));
			this.addDisposable(new ProxyBind(_getAllFavsCue.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT],true));
		}	
		
		
		
		
	}
}