package com.architectd.service.oauth
{
	import flash.events.DataEvent;

	public class OAuthDesktopLoginHelper extends OAuthLoginHelper
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _oauthWindow:OAuthDesktopLoginWindow;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function OAuthDesktopLoginHelper()
		{
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
			_oauthWindow = new OAuthDesktopLoginWindow();
			_oauthWindow.loginRequest = this._loginRequest;
			_oauthWindow.addEventListener(DataEvent.DATA,onPIN);
			_oauthWindow.open();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		private function onPIN(event:DataEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onPIN);
			
			this.finish(event.data);
		}
		
	}
}