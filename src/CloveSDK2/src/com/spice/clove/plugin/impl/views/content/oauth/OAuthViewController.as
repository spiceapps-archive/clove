package com.spice.clove.plugin.impl.views.content.oauth
{
	import com.spice.clove.plugin.core.calls.CallCloveOAuthType;
	import com.spice.clove.plugin.core.calls.CallClovePluginFactoryType;
	import com.spice.clove.plugin.core.views.oauth.IOAuthViewController;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.core.calls.CallCueType;
	import com.spice.impl.service.oauth.OAuthGetAccessTokenCall;
	import com.spice.impl.service.oauth.OAuthGetRequestTokenCall;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	import com.spice.vanilla.impl.proxy.ProxyPassThrough;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthToken;

	public class OAuthViewController extends ProxyOwner implements IOAuthViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _title:String;
		private var _usesPIN:Boolean;
		private var _oauthPIN:String;
		private var _getAccessUrl:String;
		private var _showOAuthPIN:Boolean;
		private var _oauthLoginUrl:String;
		private var _getRequestUrl:String;
		private var _authorizedLink:String;
		private var _consumer:OAuthConsumer;
		private var _currentHTTPLocation:String;
		private var _factory:ClovePluginFactory;
		protected var _getRequestTokenCall:OAuthGetRequestTokenCall;
		protected var _getAccessTokenCall:OAuthGetAccessTokenCall;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function OAuthViewController(authorizedLink:String,
											getAccessUrl:String,
											getRequestUrl:String,
											consumer:OAuthConsumer,
											factory:ClovePluginFactory,
											title:String,
											usesPIN:Boolean = false)
		{
			this._authorizedLink = authorizedLink;
			this._getAccessUrl = getAccessUrl;
			this._factory = factory;
			this._usesPIN = usesPIN;
			this._getRequestUrl = getRequestUrl;
			this._consumer = consumer;
			this._title = title;
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallCloveOAuthType.GET_OAUTH_PIN: 
					if(this._oauthPIN) 
						this.respond(c,this._oauthPIN); 
					return;
				case CallCloveOAuthType.SET_OAUTH_PIN: return this.loginComplete(c.getData());
				case CallCloveOAuthType.SHOW_OAUTH_PIN: return this.respond(c,this._showOAuthPIN);
				case CallCloveOAuthType.GET_OAUTH_TITLE: return this.respond(c,this._title);
				case CallCloveOAuthType.GET_OAUTH_CURRENT_HTTP_LOCATION: return this.respond(c,this.getCurrentHTTPLocation());
				case CallCloveOAuthType.SET_OAUTH_CURRENT_HTTP_LOCATION: return this.setCurrentHTTPLocation(c.getData());
			}
		}
		
		/**
		 */
		
		public function getRequestToken():OAuthToken
		{
			return this._getRequestTokenCall.getRequestToken();
		}
		
		/**
		 */
		
		public function getAccessToken():OAuthToken
		{
			return this._getAccessTokenCall.getAccessToken();
		}
		
		/**
		 */
		
		public function usesPIN():Boolean
		{
			return _usesPIN;
		}

		/**
		 */
		
		public function loginComplete(pin:String=null):void
		{
			this._oauthPIN = pin;
			
			this.fetchOAuthAccessUrl(pin);
			
			
			this.notifyChange(CallCloveOAuthType.GET_OAUTH_PIN,pin);
			
		}
		
		
		/**
		 */
		
		public function getTitle():String
		{
			return _title;
		}
		
		/**
		 */
		
		public function setTitle(value:String):void
		{
			this._title = value;
		}
		
		
		/**
		 */
		public function getCurrentHTTPLocation():String
		{
			if(!this._currentHTTPLocation)
			{
				this.fetchOAuthLoginUrl();
				this._currentHTTPLocation = "about:blank";
			}
			
			return this._currentHTTPLocation;
		}
		
		/**
		 */
		
		public function setCurrentHTTPLocation(value:String):void
		{
			if(this._currentHTTPLocation == value)
				return;
			
			this._currentHTTPLocation = value;
			
			
			
			if(value == this._authorizedLink && this._usesPIN)
			{
				this.setShowOAuthPin(true);
			}
			
			this.notifyChange(CallCloveOAuthType.GET_OAUTH_CURRENT_HTTP_LOCATION,this.getCurrentHTTPLocation());
		}
		
		/**
		 */
		
		public function getShowOAuthPIN():Boolean
		{
			return this._showOAuthPIN;
		}
		
		/**
		 */
		
		public function setShowOAuthPin(value:Boolean):void
		{
			this._showOAuthPIN = value;
			
			this.notifyChange(CallCloveOAuthType.SHOW_OAUTH_PIN,value);
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			//passthrough
			addDisposable(new ProxyPassThrough(_factory.getProxy(),
								 this.getProxyController(),
								 [CallClovePluginFactoryType.GET_ICON_32]));
			
			
			this.addAvailableCalls([CallCloveOAuthType.GET_OAUTH_CURRENT_HTTP_LOCATION,
									CallCloveOAuthType.SET_OAUTH_CURRENT_HTTP_LOCATION,
									CallCloveOAuthType.GET_OAUTH_ICON,
									CallCloveOAuthType.GET_OAUTH_PIN,
									CallCloveOAuthType.SET_OAUTH_PIN,
									CallCloveOAuthType.SHOW_OAUTH_PIN,
									CallCloveOAuthType.GET_OAUTH_TITLE,
									CallCloveOAuthType.GET_ACCESS_TOKEN]);
		}
		/**
		 */
		
		protected function fetchOAuthLoginUrl():void
		{
			this._getRequestTokenCall = new OAuthGetRequestTokenCall(this._getRequestUrl,this._consumer);
			this._getRequestTokenCall.getProxy().bindObserver(new CallbackObserver(CallCueType.COMPLETE,onGetRequestToken));
			this._getRequestTokenCall.initialize();
		}
		
		private function onGetRequestToken(target:CallbackObserver,n:INotification):void
		{
			n.getTarget().removeObserver(target);
			this.completeGetRequestToken();
			
		}
		
		
		
		/**
		 */
		protected function fetchOAuthAccessUrl(pin:String):void
		{
			this._getAccessTokenCall = new OAuthGetAccessTokenCall(this._getAccessUrl,this._consumer,this._getRequestTokenCall.getRequestToken(),pin);
			this._getAccessTokenCall.getProxy().bindObserver(new CallbackObserver(CallCueType.COMPLETE,onGetAccessToken));
			this._getAccessTokenCall.initialize();
			
		}
		
		private function onGetAccessToken(target:CallbackObserver,n:INotification):void
		{
			n.getTarget().removeObserver(target);
			this.completeGetAccessToken();
			
		}
		
		/**
		 */
		
		protected function completeGetRequestToken():void
		{
			//abstract. set login url here
		}
		
		/**
		 */
		
		protected function completeGetAccessToken():void
		{
			//abstract
			_currentHTTPLocation = null;
			this.notifyChange(CallCloveOAuthType.GET_ACCESS_TOKEN,this.getAccessToken());
		}
		/**
		 */
		
		protected function setOAuthLoginUrl(value:String):void
		{
			_oauthLoginUrl = value;
			
			
			this.setCurrentHTTPLocation(value);
		}
		
		
	}
}