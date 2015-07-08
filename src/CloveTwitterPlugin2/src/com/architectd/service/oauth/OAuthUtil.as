package com.architectd.service.oauth
{
	import org.iotashan.oauth.OAuthToken;

	public class OAuthUtil
	{
		/**
		 */
		
		public static function getTokenFromResponse( tokenResponse : String ) :OAuthToken 
		{
			var result:OAuthToken = new OAuthToken();
			
			var params:Array = tokenResponse.split( "&" );
			for each ( var param : String in params ) 
			{
				var paramNameValue:Array = param.split( "=" );
				
				if( paramNameValue.length == 2 ) 
				{
					if( paramNameValue[0] == "oauth_token" ) 
					{
						result.key = paramNameValue[1];
					} else 
						if( paramNameValue[0] == "oauth_token_secret" ) 
						{
							result.secret = paramNameValue[1];
						}
				}
			}
			
			return result;
		}
	}
}