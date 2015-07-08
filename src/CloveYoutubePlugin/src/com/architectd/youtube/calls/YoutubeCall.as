package com.architectd.youtube.calls
{
	import com.architectd.service.calls.ServiceCall;
	import com.architectd.service.loaders.TextLoader;
	import com.architectd.service.responseHandlers.IResponseHandler;

	public class YoutubeCall extends ServiceCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeCall(url:String,responder:IResponseHandler,method:String = "get")
		{
			super(url,new TextLoader(),responder,method);
		}
		
	}
}