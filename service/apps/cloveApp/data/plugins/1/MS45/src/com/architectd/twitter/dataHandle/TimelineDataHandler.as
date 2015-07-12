package com.architectd.twitter.dataHandle
{
	import com.architectd.twitter.data.timeline.TimelineItemData;

	public class TimelineDataHandler extends DataHandler
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		override protected function getResponseData2(data:String) : *
		{
			var x:XML = new XML(data);
			
			var r:Array = [];
			
			for each(var status:XML in x.status)
			{
				r.push(new TimelineItemData(status));
			}
			
			
			
			return r;
		}
		
		
	}
}