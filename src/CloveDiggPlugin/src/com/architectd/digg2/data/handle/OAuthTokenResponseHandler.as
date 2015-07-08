package com.architectd.digg2.data.handle
{
	import com.coderanger.QueryString;
	import com.yahoo.oauth.OAuthToken;
	
	public class OAuthTokenResponseHandler implements IResponseHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getResult(raw:String):Array
		{			
			var obj:Object = new QueryString(raw).toPostObject();
			
			
			return [new OAuthToken(obj.oauth_token,obj.oauth_token_secret)];
		}
	}
}