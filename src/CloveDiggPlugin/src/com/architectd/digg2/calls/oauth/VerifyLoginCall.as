package com.architectd.digg2.calls.oauth
{
	import com.architectd.digg2.calls.PrivateDiggCall;
	import com.architectd.digg2.data.VerifyLoginData;
	import com.architectd.digg2.data.handle.VerifyLoginHandler;
	import com.architectd.digg2.digg_service_internal;
	import com.architectd.digg2.events.DiggEvent;

	use namespace digg_service_internal;
	
	public class VerifyLoginCall extends PrivateDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function VerifyLoginCall(loginOnFail:Boolean = true)
		{
			super("oauth.verify",null,new VerifyLoginHandler(),false,loginOnFail);
			
		}
		
		
		
		/**
		 */
		
		override protected function setRawData(raw:String) : void
		{
			super.setRawData(raw);
			
			
			var d:VerifyLoginData = this.data[0];
			
			this.service.settings.loggedInUser = d.username;
			
			
		}
		
		
		
	}
}