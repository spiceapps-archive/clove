package org.iotashan.oauth
{
	

	/**
	 * The OAuthToken class is for holding on to a Token key and private strings.
	*/
	
	[RemoteClass(alias="org.iotashan.oauth.OAuthToken")]
	
	[Bindable] 
	public class OAuthToken
	{
		public var key:String;
		public var secret:String;
		
		/**
		 * Constructor class.
		 * 
		 * @param key Token key. Default is an empty string.
		 * @param secret Token secret. Default is an empty string.
		*/
		public function OAuthToken(key:String="",secret:String="")
		{
			this.key = key;
			this.secret = secret;
		}
		
		
		
		/**
		 * Returns if the Token is empty or not
		*/
		public function get isEmpty():Boolean {
			if (key.length == 0 && secret.length == 0) {
				return true;
			} else {
				return false;
			}
		}
	}
}