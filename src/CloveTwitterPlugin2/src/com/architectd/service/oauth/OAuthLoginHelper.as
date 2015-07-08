package com.architectd.service.oauth
{
	
	import com.spice.impl.queue.AbstractCue;
	
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;

	public class OAuthLoginHelper extends AbstractCue
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		protected var _loginRequest:URLRequest;
		protected var _screenName:String;
		protected var _pin:*;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function OAuthLoginHelper()
		{
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function getPin():String
		{
			return this._pin;
		}
		
		
		public function setLoginRequest(request:URLRequest,screenName:String = null):OAuthLoginHelper
		{
			_loginRequest = request;
			_screenName	  = screenName;
			return this;
		}
		
		/**
		 */
		
		override public function initialize():void
		{
			//abstract
		}
		
		
		/**
		 */
		
		protected function finish(pin:*):void
		{
			_pin = pin;
			this.complete(pin);
		}
	}
}