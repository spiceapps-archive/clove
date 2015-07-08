package com.architectd.digg2
{
	import com.yahoo.oauth.OAuthToken;
	
	public interface IDiggServiceSettings
	{
		function get pin():String;
		function set pin(value:String):void;
		
		function get accessToken():OAuthToken;
		function set accessToken(value:OAuthToken):void;
		
		function get requestToken():OAuthToken;
		function set requestToken(value:OAuthToken):void;
		
		function get loggedInUser():String;
		function set loggedInUser(value:String):void;
	}
}