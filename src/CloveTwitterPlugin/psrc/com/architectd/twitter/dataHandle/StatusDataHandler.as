package com.architectd.twitter.dataHandle
{
	import com.architectd.twitter.data.timeline.TimelineItemData;

	public class StatusDataHandler extends DataHandler
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
			return [new TimelineItemData(new XML(raw))];
		}
		
	}
}