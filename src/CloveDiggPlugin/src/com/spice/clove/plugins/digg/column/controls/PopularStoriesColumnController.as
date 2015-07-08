package com.spice.clove.plugins.digg.column.controls
{
	import com.architectd.digg2.calls.stories.GetPopularStoriesCall;
	import com.architectd.digg2.data.StoryData;
	import com.spice.clove.events.CloveColumnEvent;

	public class PopularStoriesColumnController extends DiggStoryColumnController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function PopularStoriesColumnController()
		{
			super();
			
			this.title = "Popular Stories";
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
			
			
			this.call(new GetPopularStoriesCall(null,30,maxDate,null));
		}
	}
}