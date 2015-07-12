package com.spice.clove.plugin.facebook.utils
{
	import com.facebook.data.StringResultData;
	import com.facebook.events.FacebookEvent;
	import com.facebook.session.DesktopSession;
	
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	
	public class AIRDesktopSession extends DesktopSession
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


       public var authURL:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function AIRDesktopSession(api_key:String,secret:String)
		{
			super(api_key,secret);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function tokenCreated():void
		{
			Alert.show(this.login_url);
		}
		
		/**
		 */
		
		override protected function onLogin(p_event:FacebookEvent):void {

			p_event.target.removeEventListener(FacebookEvent.COMPLETE, onLogin);


			if (p_event.success) {

				_auth_token = (p_event.data as StringResultData).value;
				
				
				//now that we have an auth_token we need the user to login with it

				var request:URLRequest = new URLRequest();

				var loginParams:String = '?';


				if (_offline_access) {

					loginParams += 'ext_perm=offline_access&';

				}

				

				request.url = login_url+loginParams+"api_key="+api_key+"&v="+api_version+"&auth_token="+_auth_token;
				
				
				this.authURL = request.url;

				_waiting_for_login = true;

				dispatchEvent(new FacebookEvent(FacebookEvent.WAITING_FOR_LOGIN));

			} else {

				onConnectionError(p_event.error);

			}

		}

	}
}