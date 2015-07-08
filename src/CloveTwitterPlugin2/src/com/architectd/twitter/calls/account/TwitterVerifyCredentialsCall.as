package com.architectd.twitter.calls.account
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.dataHandle.IDataHandler;
	
	import flash.net.URLRequestMethod;
	import flash.system.Capabilities;
	
	public class TwitterVerifyCredentialsCall extends TwitterCall implements IDataHandler
	{
		
		
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function TwitterVerifyCredentialsCall():void
		{
			
			//NOTE: for some reason, authentication works differently on mac than on PC
//			
			
			super("http://twitter.com/account/verify_credentials.xml",this,null, Capabilities.os.indexOf("Mac") > -1  ? false : true,URLRequestMethod.GET/* ,-1 */);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function getResponseData(response:String):*
		{
			
			return true;
		}
		
		
		
	}
}