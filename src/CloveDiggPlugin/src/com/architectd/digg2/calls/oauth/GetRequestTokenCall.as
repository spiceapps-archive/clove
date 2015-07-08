package com.architectd.digg2.calls.oauth
{
	import com.architectd.digg2.calls.PrivateDiggCall;
	import com.architectd.digg2.data.handle.OAuthTokenResponseHandler;
	import com.yahoo.oauth.OAuthToken;
	
	public class GetRequestTokenCall extends PrivateDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetRequestTokenCall()
		{
			super("oauth.getRequestToken",{oauth_callback:'http://digg.com/'},new OAuthTokenResponseHandler());
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override protected function get token() : OAuthToken
		{
			return null;
		}
		/**
		 */
		
		override protected function setRawData(raw:String) : void
		{
			super.setRawData(raw);
			
			this.service.settings.requestToken = this.data[0];
		}
		
		
		
	}
}