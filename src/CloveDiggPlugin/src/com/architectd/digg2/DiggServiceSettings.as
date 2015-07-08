package com.architectd.digg2
{
	import com.spice.utils.storage.SharedObjectSettings;
	import com.spice.utils.storage.persistent.SettingManager;
	import com.yahoo.oauth.OAuthToken;
	
	[Bindable] 
	public class DiggServiceSettings implements IDiggServiceSettings
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        
		[Setting]
		public var pin:String;
		
		
		[Setting]
		public var loggedInUser:String;
		
		
		[Setting] 
		public var requestTokenSecret:String;
		
		[Setting]
		public var requestTokenKey:String;
		
		[Setting]
		public var accessTokenSecret:String;
		
		[Setting]
		public var accessTokenKey:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
		private var _accessToken:OAuthToken;
		private var _requestToken:OAuthToken;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function DiggServiceSettings()
		{
			new SettingManager(new SharedObjectSettings("DiggService"),this);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get accessToken():OAuthToken
		{
			if(!_accessToken && this.accessTokenKey && this.accessTokenSecret)
			{
				_accessToken = new OAuthToken(this.accessTokenKey,this.accessTokenSecret);
			}
			return this._accessToken;
		}
		
		/**
		 */
		 
		
		public function set accessToken(value:OAuthToken):void
		{
			this._accessToken = value;
			
			this.accessTokenKey	   = value.key;
			this.accessTokenSecret = value.secret;
		}
		
		
		/**
		 */
		
		public function get requestToken():OAuthToken
		{
			if(!_requestToken && this.requestTokenKey && this.requestTokenSecret)
			{
				_requestToken = new OAuthToken(this.requestTokenKey,this.requestTokenSecret);
			}
			return this._requestToken;
		}
		
		/**
		 */
		 
		
		public function set requestToken(value:OAuthToken):void
		{
			this._requestToken = value;
			
			this.requestTokenKey = value.key;
			this.requestTokenSecret = value.secret;
		}
		
		
			
		 
	}
}