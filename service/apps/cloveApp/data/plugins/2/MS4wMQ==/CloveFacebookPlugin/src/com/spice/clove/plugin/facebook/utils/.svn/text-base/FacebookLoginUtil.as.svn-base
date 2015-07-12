package com.spice.clove.plugin.facebook.utils
{
	import com.facebook.Facebook;
	import com.facebook.events.FacebookEvent;
	import com.facebook.utils.DesktopSessionHelper;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	public class FacebookLoginUtil extends DesktopSessionHelper
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
        public var fsu:DesktopSessionHelper;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookLoginUtil()
		{
			super();
			
			
			
			
			this.apiKey = "fdb2dd8fb51838f5f36d69556f0d4604";
			
			
			this.addEventListener(FacebookEvent.PERMISSIONS_LOADED,onPermissionsLoaded);
			this.addEventListener( FacebookEvent.VERIFYING_SESSION,onVerifySession);
			
//			this.verifySession();
			
			
//			this.login();
//			this.shutdown();
//			
			
			//this.grantPermissions([FacebookPermissionType.READ_STREAM,FacebookPermissionType.STATUS_UPDATE]);
			
//			fsu = new BetterFacebookSessionUtil("fdb2dd8fb51838f5f36d69556f0d4604","89460eda6537649fdfbfc039eb5c432c",Application.application.loaderInfo);
//			connection = fsu.facebook;
//			fsu.activeSession.addEventListener(FacebookEvent.WAITING_FOR_LOGIN,onWaitingForLogin);
//			this.addEventListener(FacebookEvent.CONNECT,onLogin,false,99999);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get connection():Facebook
		{
			return this.facebook;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		/* public function verifyLogin():void
		{
			fsu.verifySession();
		}
		 */
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function onPermissionWinClose(event:Event) : void
		{
			super.onPermissionWinClose(event);
			
			this.verifySession();
			
//			this.complete();
			flash.utils.setTimeout(this.complete,500);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        /**
		 */
		
		private function onPermissionsLoaded(event:FacebookEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onPermissionsLoaded);
			
			var perms:Array = ['status_update','photo_upload','publish_stream','read_stream'];
			
			
			var toGrant:Array = [];
			
			for each(var perm:String in perms)
			{
				if(this.permissions[perm])
					continue;
				
				toGrant.push(perm);
			}
			
			if(toGrant.length > 0)
			{
				this.grantPermissions(toGrant);
				
				
			}
		}
		
		
		
		
		
		
		/**
		 */
		
		private function onVerifySession(event:FacebookEvent):void
		{
			
			if(event.success)
			{
				this.complete();
			}
		}
        
		
		
		/**
		 */
		
		private function onFBLogin(event:FacebookEvent):void
		{
			event.target.removeEventListener(event.type,onFBLogin);
			
			
		}
		
		
		/**
		 */
		
		private function complete():void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));	
		}

	}
}