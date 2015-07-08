package com.spice.clove.plugins.digg.column.controls
{
	import com.architectd.digg2.calls.stories.GetUpcomingStoriesCall;
	import com.spice.clove.events.CloveColumnEvent;
	
	public class UpcomingStoriesColumnController extends DiggStoryColumnController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UpcomingStoriesColumnController()
		{
			super();
			
			this.title = "Upcoming Stories";
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function onColumnStartLoad(event:CloveColumnEvent) : void
		{
			this.loadContent();
		}
		
		/**
		 */
		
		override protected function loadContent(maxDate:Date = null):void
		{
			this.call(new GetUpcomingStoriesCall(30,0,null,maxDate));
		}
	}
}