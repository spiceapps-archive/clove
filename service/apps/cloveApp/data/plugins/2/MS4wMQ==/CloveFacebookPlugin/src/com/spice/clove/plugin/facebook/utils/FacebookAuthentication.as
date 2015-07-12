package com.spice.clove.plugin.facebook.utils
{
	import com.facebook.events.FacebookEvent;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.controls.HTML;
	
	public class FacebookAuthentication extends HTML
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        
		
		public static const FACEBOOK_AUTH_URL:String = "https://ssl.facebook.com/desktopapp.php?api_key=";
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookAuthentication(url:String)
		{
			this.addEventListener(Event.LOCATION_CHANGE,onLocationChange);
		
			
			this.location = url;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function authenticate(authUrl:String):void
		{
			this.location = authUrl;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onLocationChange(event:Event):void
		{
			if(this.location.indexOf(FACEBOOK_AUTH_URL) > -1)
			{
				
				this.dispatchEvent(new FacebookEvent(FacebookEvent.CONNECT));
				
				
			}
		}
	}
}