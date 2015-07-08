package com.architectd.service.oauth
{
	import com.spice.impl.queue.AbstractCue;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;

	public class OAuthGetRequestTokenCall extends AbstractCue
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _getRequestTokenUrl:String;
		private var _consumer:OAuthConsumer;
		private var _requestToken:OAuthToken;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function OAuthGetRequestTokenCall(getRequestTokenUrl:String,consumer:OAuthConsumer)
		{
			_getRequestTokenUrl = getRequestTokenUrl;
			_consumer = consumer;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function initialize():void
		{
			super.initialize();
			
			var request:OAuthRequest = new OAuthRequest(URLRequestMethod.GET,_getRequestTokenUrl,null,_consumer,null);
			var req:URLRequest = new URLRequest(request.buildRequest(new OAuthSignatureMethod_HMAC_SHA1()));
			var loader:URLLoader = new URLLoader(req);
			loader.addEventListener(Event.COMPLETE,onGetRequestToken);
			
			
		}
		
		
		/**
		 */
		
		public function getLoginUrl(authUrl:String):String
		{
			return authUrl+"?oauth_token="+this._requestToken.key;
		}
		
		/**
		 */
		
		
		public function getRequestToken():OAuthToken
		{
			return _requestToken;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onGetRequestToken(event:Event):void
		{
			_requestToken = OAuthUtil.getTokenFromResponse(event.target.data);
			
			this.complete();
		}
		
		
		
		
	}
}