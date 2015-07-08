package com.spice.clove.twitter.impl.views.oauth
{
	import com.architectd.service.oauth.OAuthGetRequestTokenCall;
	import com.architectd.service.oauth.OAuthServiceCue;
	import com.architectd.twitter2.TwitterService;
	import com.architectd.twitter2.TwitterUrls;
	import com.spice.clove.plugin.core.calls.CallCloveOAuthType;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.impl.views.content.oauth.OAuthViewController;
	import com.spice.core.calls.CallCueType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	public class CloveTwitterOAuthViewController extends OAuthViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveTwitterOAuthViewController(factory:ClovePluginFactory)
		{
			super(TwitterUrls.TWITTER_URL_OAUTH_AUTHORIZE,TwitterUrls.TWITTER_URL_OAUTH_ACCESS,TwitterUrls.TWITTER_URL_OAUTH_REQUST,TwitterService.CONSUMER,factory,"Clove requires you to login to Twitter.",true);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		override protected function completeGetRequestToken():void
		{
			super.completeGetRequestToken();
			
			if(this._getRequestTokenCall && this._getRequestTokenCall.getRequestToken())
			this.setOAuthLoginUrl(TwitterUrls.TWITTER_URL_OAUTH_AUTHORIZE+"?oauth_token="+this._getRequestTokenCall.getRequestToken().key);
		}
		
		
		
	}
}