package com.spice.clove.plugins.digg.column.controls
{
	import com.architectd.digg2.calls.stories.GetTopStoriesCall;
	import com.spice.clove.events.CloveColumnEvent;
	
	public class GetTopStoriesColumnController extends DiggStoryColumnController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetTopStoriesColumnController()
		{
			super();
			
			this.title = "Top Stories";
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
		
		override protected function loadContent(maxDate:Date=null) : void
		{
			this.call(new GetTopStoriesCall(50));
		}
	}
}