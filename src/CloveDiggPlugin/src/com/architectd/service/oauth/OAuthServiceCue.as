package com.architectd.service.oauth
{
	import com.adobe.serialization.json.JSON;
	import com.spice.events.QueueManagerEvent;
	import com.spice.utils.queue.cue.StateCue;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import org.iotashan.oauth.IOAuthSignatureMethod;
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;

	public class OAuthServiceCue extends StateCue
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _consumer:OAuthConsumer;
		private var _requestTokenUrl:String;
		private var _accessTokenUrl:String;
		private var _authorizeUrl:String;
		private var _authenticateUrl:String;
		private var _accessToken:OAuthToken;
		private var _requestToken:OAuthToken;
		private var _signature:IOAuthSignatureMethod;
		private var _loginHelper:OAuthLoginHelper;
		private var _usernameKey:String;
		private var _pin:String;
		private var _screenName:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function OAuthServiceCue(consumerKey:String,
										consumerSecret:String,
										requestTokenUrl:String,
										accessTokenUrl:String,
										authorizeUrl:String,
										authenticateUrl:String,
										usernameKey:String,
										helper:OAuthLoginHelper,
										accessToken:OAuthToken = null,
										signature:IOAuthSignatureMethod = null)
		{
			
			_consumer = new OAuthConsumer(consumerKey,consumerSecret);
			
			_usernameKey	 = usernameKey;
			_requestTokenUrl = requestTokenUrl;
			_accessTokenUrl  = accessTokenUrl;
			_authorizeUrl    = authorizeUrl;
			_authenticateUrl = authenticateUrl;
			_accessToken	 = accessToken;
			_loginHelper     = helper;
			_signature       = signature ? signature : new OAuthSignatureMethod_HMAC_SHA1();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get pin():String
		{
			return _pin;
		}
		
		/**
		 */
		
		public function get screenName():String
		{
			return this._screenName;
		}
		
		
		/**
		 */
		
		public function getRequestUrl(url:String,params:Object,method:String = URLRequestMethod.GET):String
		{
			var oreq:OAuthRequest = new OAuthRequest(method,url,params,this._consumer,this._accessToken);
			return oreq.buildRequest(this._signature,OAuthRequest.RESULT_TYPE_URL_STRING);ES	
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function init():void
		{
			this.getRequestToken();
		}
		
		/**
		 */
		
		private function verifyAccessToken():void
		{
			var oreq:OAuthRequest = new OAuthRequest(URLRequestMethod.GET,this._authenticateUrl,null,_consumer,this._accessToken);
			var req:URLRequest = new URLRequest(oreq.buildRequest(_signature,OAuthRequest.RESULT_TYPE_URL_STRING));
			var loader:URLLoader = new URLLoader(req);
			loader.addEventListener(Event.COMPLETE,onVerifyAccessToken);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onError);
		}
		
		/**
		 */
		
		private function onVerifyAccessToken(event:Event):void
		{
			
			var val:Object = JSON.decode(event.target.data);
			this._screenName = val[this._usernameKey];
			
			
			this.complete();
			
		}
		
		/**
		 */
		
		private function getRequestToken():void
		{
			var request:OAuthRequest = new OAuthRequest(URLRequestMethod.GET,this._requestTokenUrl,null,_consumer,null);
			var req:URLRequest = new URLRequest(request.buildRequest(_signature));
			var loader:URLLoader = new URLLoader(req);
			loader.addEventListener(Event.COMPLETE,onGetRequestToken);
		}
		
		/**
		 */
		
		private function onGetRequestToken(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type,onGetRequestToken);
			
			_requestToken = getTokenFromResponse(e.target.data);
			var req:URLRequest = new URLRequest(this._authorizeUrl+"?oauth_token="+this._requestToken.key);
			this._loginHelper.addEventListener(QueueManagerEvent.CUE_COMPLETE,onLoginComplete);
			this._loginHelper.setLoginRequest(req).init();
		}
		
		/**
		 */
		
		private function onLoginComplete(e:QueueManagerEvent):void
		{
			_pin = _loginHelper.pin;
			
			e.currentTarget.removeEventListener(e.type,onLoginComplete);
			
			var oreq:OAuthRequest = new OAuthRequest(URLRequestMethod.GET,this._accessTokenUrl,{oauth_verifier:_pin},this._consumer,this._requestToken);
			var req:URLRequest = new URLRequest(oreq.buildRequest(_signature,OAuthRequest.RESULT_TYPE_URL_STRING));
			
			var loader:URLLoader = new URLLoader(req);
			loader.addEventListener(Event.COMPLETE,onGetAccessToken);
		}
		
		/**
		 */
		
		private function onGetAccessToken(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type,onGetAccessToken);
			
			this._accessToken = this.getTokenFromResponse(e.target.data);
			
			this.verifyAccessToken();
		}
		
		
		/**
		 */
		
		private function onError(event:IOErrorEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onError);
			
			this.complete(1);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function getTokenFromResponse( tokenResponse : String ) :OAuthToken 
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