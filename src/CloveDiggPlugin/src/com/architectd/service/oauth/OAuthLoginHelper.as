package com.architectd.service.oauth
{
	import com.spice.utils.queue.cue.Cue;
	
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;

	public class OAuthLoginHelper extends Cue
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		protected var _loginRequest:URLRequest;
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
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get pin():String
		{
			return this._pin;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setLoginRequest(request:URLRequest):OAuthLoginHelper
		{
			_loginRequest = request;
			return this;
		}
		
		/**
		 */
		
		override public function init():void
		{
			//abstract
		}
		
		
		/**
		 */
		
		protected function finish(pin:*):void
		{
			_pin = pin;
			this.complete();
		}
	}
}