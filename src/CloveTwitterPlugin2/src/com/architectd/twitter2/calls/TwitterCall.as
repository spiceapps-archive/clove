package com.architectd.twitter2.calls
{
	import com.spice.impl.service.IRemoteServiceResponseHandler;
	import com.spice.impl.service.RemoteServiceLoadCue;
	import com.spice.impl.service.RemoteServiceRequest;
	import com.spice.impl.service.loaders.TextLoader;
	
	public class TwitterCall extends RemoteServiceLoadCue
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterCall(url:String,
									responseHandler:IRemoteServiceResponseHandler,
									params:Object)
		{
			super(new RemoteServiceRequest(url,params,responseHandler),new TextLoader());
			
		}
	}
}