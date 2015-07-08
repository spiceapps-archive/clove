package com.architectd.twitter.dataHandle
{
	import com.architectd.twitter.data.dm.DirectMessagesData;

	public class DMHandler extends DataHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getResponseData2(raw:String) : *
		{
			var x:XML = new XML(raw);
			
			var r:Array = [];
			
			for each(var dm:XML in x.direct_message)
			{
				r.push(new DirectMessagesData(dm));
			}
			
			return r;
		}
	}
}