package com.spice.clove.plugin.youtube.impl.views.oauth
{
	import com.architectd.youtube.calls.YoutubeUrls;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.impl.views.content.oauth.OAuthViewController;

	public class YoutubeOAuthViewController extends OAuthViewController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeOAuthViewController(factory:ClovePluginFactory)
		{
			super(YoutubeUrls.OAUTH_AUTHORIZE_URL,
				YoutubeUrls.OAUTH_ACCESS_URL,
				  YoutubeUrls.OAUTH_GET_REQUEST_TOKEN_URL,
				  null,
				  factory,
				  "Clove requires you to log into Youtube.",
				  true);
		}
	}
}