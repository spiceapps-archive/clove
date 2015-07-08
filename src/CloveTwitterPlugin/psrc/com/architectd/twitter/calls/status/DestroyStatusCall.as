package com.architectd.twitter.calls.status
{
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.dataHandle.StatusDataHandler;
	
	public class DestroyStatusCall extends TwitterCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DestroyStatusCall(statusId:String)
		{
			super("http://twitter.com/statuses/destroy/"+statusId+".xml",new StatusDataHandler(),null,true);
		}
	}
}