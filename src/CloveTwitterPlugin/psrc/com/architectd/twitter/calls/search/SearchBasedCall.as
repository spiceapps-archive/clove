package com.architectd.twitter.calls.search
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.dataHandle.DataHandler;

	public class SearchBasedCall extends TwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		public static const SEARCH_URL:String = "http://search.twitter.com/";
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function SearchBasedCall(dataHandler:DataHandler,method:String,params:Object)
		{
			super(SEARCH_URL+method+".atom",dataHandler,params);
			
		}
		
		
		
		
	}
}