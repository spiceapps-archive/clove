package com.spice.clove.plugins.digg.column.controls
{
	import com.architectd.digg2.calls.stories.GetAllStoriesCall;
	import com.spice.clove.events.CloveColumnEvent;
	

	public class AllStoriesColumnController extends DiggStoryColumnController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AllStoriesColumnController()
		{
			super();
			
			this.title = "All Stories";
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
		
		override protected function loadContent(minDate:Date=null) : void
		{
			this.call(new GetAllStoriesCall(null,15,null,minDate));
		}
		
	
	}
}