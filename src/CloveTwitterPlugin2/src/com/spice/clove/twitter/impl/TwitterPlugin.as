package com.spice.clove.twitter.impl
{
	import com.architectd.service.oauth.OAuthLoginHelper;
	import com.architectd.twitter2.TwitterService;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.post.core.outgoing.ICloveAttachmentUploader;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.settings.AbstractServicePluginSettings;
	import com.spice.clove.service.impl.settings.ISettingAccountFactory;
	import com.spice.clove.service.impl.settings.ServiceSettingFactory;
	import com.spice.clove.twitter.core.calls.CallTwitterPluginType;
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;
	import com.spice.clove.twitter.impl.content.control.TwitterContentControllerFactory;
	import com.spice.vanilla.core.proxy.IProxyCall;
	
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;

	public class TwitterPlugin extends AbstractServicePlugin implements ISettingAccountFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _loginHelper:OAuthLoginHelper;
		private var _service:TwitterService;
		private var _uploaders:Vector.<ICloveAttachmentUploader>;
		
		public static const MIN_REFRESH_TIME:Number = 600000;//every 10 minutes
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterPlugin(oauthHelper:OAuthLoginHelper,factory:CloveTwitterPluginFactory)
		{
			super("Twitter","com.spice.clove.twitter",factory,new AbstractServicePluginSettings(new ServiceSettingFactory(this)));
				
			_loginHelper = oauthHelper;
			
			
			this.setContentControllerFactory(new TwitterContentControllerFactory(this));
			
			_uploaders = new Vector.<ICloveAttachmentUploader>();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallTwitterPluginType.TWITTER_PLUGIN_REGISTER_ATTACHMENT_UPLOADER: this.addPluginUploader(call.getData());
			}
			
			super.answerProxyCall(call);
		}
		
		/**
		 */
		
		public function addPluginUploader(value:ICloveAttachmentUploader):void
		{
			_uploaders.push(value);
			
			for each(var acc:TwitterPluginAccount in this.getAccounts())
			{
				acc.addPluginUploader(value);
			}
		}
		
		/**
		 */
		
		override public function addAcount():AbstractServiceAccount
		{
			var acc:TwitterPluginAccount = TwitterPluginAccount(super.addAcount());
			
			for each(var uploader:ICloveAttachmentUploader in this._uploaders)
			{
				acc.addPluginUploader(uploader);
			}
			
			return acc;
		}
		
		
		/**
		 */
		
		public function getPublicConnection():TwitterService
		{
			if(!_service)
			{
				_service = new TwitterService(this._loginHelper);
			}
			
			return _service;
		}
		/**
		 */
		
		override protected function getAvailableContentControllers():Vector.<String>
		{
			return TwitterContentControllerFactory(this.getContentControllerFactory()).getAvailablePublicFeeds();
		}
		
		

		/**
		 */
		
		public function getNewServiceAccount():AbstractServiceAccount
		{
			return new TwitterPluginAccount(this._loginHelper);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			
			
		}
		
		
		
		/**
		 */
		
		override protected function getRefreshTimeoutInterval(n:int):int
		{
			if(n == 0)
				return MIN_REFRESH_TIME;
			
			
			//we don't want to return the EXACT requests / hour because the user will always be interacting with the app
			return 3600000 / (TwitterService.MAX_REQUESTS_PER_HOUR - 20) * n;
		}
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			
			this.addAvailableCalls([CallTwitterPluginType.TWITTER_PLUGIN_REGISTER_ATTACHMENT_UPLOADER]);
		}
	}
}