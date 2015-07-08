package com.architectd.service.oauth
{
	import com.adobe.serialization.json.JSON;
	import com.spice.core.calls.CallCueType;
	import com.spice.events.QueueManagerEvent;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.utils.SystemUtil;
	import com.spice.utils.queue.cue.ICue;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.ConcreteProxyController;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import org.iotashan.oauth.IOAuthSignatureMethod;
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;

	public class OAuthServiceCue extends AbstractCue implements IProxyBinding
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
		private var _loginHelperBindingCall:ProxyCall;
		
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
										screenName:String = null,
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
			_screenName		 = screenName;
			_signature       = signature || new OAuthSignatureMethod_HMAC_SHA1();
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
			return oreq.buildRequest(this._signature,OAuthRequest.RESULT_TYPE_URL_STRING);
		}
		
		/**
		 */
		
		public function getRequestHeader(url:String = null,params:Object = null,method:String = URLRequestMethod.GET):URLRequestHeader
		{
			
			var oreq:OAuthRequest = new OAuthRequest(method,url ? url : _authenticateUrl,params,this._consumer,this._accessToken);
			return oreq.buildRequest(this._signature,OAuthRequest.RESULT_TYPE_HEADER);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function hasAccessToken():Boolean
		{
			return this._accessToken != null;
		}
		
		
		/**
		 */
		
		public function getAccessToken():OAuthToken
		{
			return this._accessToken;
		}
		/**
		 */
		
		public function setAccessToken(value:OAuthToken):void
		{
			this._accessToken = value;
		}
		
		
		
		/**
		 */
		public function getUsername():String
		{
			return this._screenName;
		}
		
		
		/**
		 */
		
		override public function initialize():void
		{
			if(this._accessToken)
			{
				this.verifyAccessToken()
			}
			else
			{
				this.getRequestToken();
			}
		}
		
		/**
		 */
		
		public function verifyAccessToken(accessToken:OAuthToken = null):void
		{
			if(accessToken)
				_accessToken = accessToken;
			
			var oreq:OAuthRequest = new OAuthRequest(URLRequestMethod.GET,this._authenticateUrl,null,_consumer,this._accessToken);
			var req:URLRequest = new URLRequest(oreq.buildRequest(_signature,OAuthRequest.RESULT_TYPE_URL_STRING));
			
			
			if(SystemUtil.runningAIR)
			{
				req["authenticate"] = false;	
				req["manageCookies"] = false;
				req["cacheResponse"] = false;
				req["useCache"] = false;
			}
			
			var loader:URLLoader = new URLLoader(req);
			
			loader.addEventListener(Event.COMPLETE,onVerifyAccessToken);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onVerifyError);
		}
		
		
		/**
		 */
		
		public function notifyProxyBinding(binding:INotification):void
		{
			switch(binding.getType())
			{
				case CallCueType.COMPLETE: onLoginComplete();
			}
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
			
			if(!_loginHelperBindingCall)
			{
				_loginHelperBindingCall = new ProxyCall(CallCueType.COMPLETE,this._loginHelper.getProxy(),null,null,this).dispatch();
			}
			else
			{
				_loginHelperBindingCall.bind(this);
			}
			
			
			this._loginHelper.setLoginRequest(req,this._screenName).initialize();
		}
		
		/**
		 */
		
		private function onLoginComplete():void
		{
			_loginHelperBindingCall.unbind();
			
			_pin = _loginHelper.getPin();
			
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
		
		
		
		/**
		 */
		private function onVerifyError(event:IOErrorEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onVerifyError);
			
			this.getRequestToken();
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