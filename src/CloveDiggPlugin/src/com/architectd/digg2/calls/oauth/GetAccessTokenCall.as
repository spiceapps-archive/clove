package com.architectd.digg2.calls.oauth
{
	import com.architectd.digg2.calls.PrivateDiggCall;
	import com.architectd.digg2.data.handle.OAuthTokenResponseHandler;
	import com.yahoo.oauth.OAuthToken;
	
	public class GetAccessTokenCall extends PrivateDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetAccessTokenCall()
		{
			super("oauth.getAccessToken",{oauth_callback:'http://digg.com/'},new OAuthTokenResponseHandler());
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function get token():OAuthToken
		{
			return this.service.settings.requestToken;
		}
		/**
		 */
		
		override protected function setRawData(raw:String) : void
		{
			super.setRawData(raw);
			
			this.service.settings.accessToken = this.data[0];
		}
		/**
		 */
		
		override protected function getAllParams() : Object
		{
			super.getAllParams().oauth_verifier = this.service.settings.pin;
			
			return super.getAllParams();
		}
		
		
	}
}