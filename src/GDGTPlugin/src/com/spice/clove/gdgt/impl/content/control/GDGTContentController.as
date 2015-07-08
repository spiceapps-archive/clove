package com.spice.clove.gdgt.impl.content.control
{
	import com.spice.clove.gdgt.impl.GDGTPlugin;
	import com.spice.clove.gdgt.impl.content.control.render.GDGTFeedDataRenderer;
	import com.spice.clove.rss.impl.content.control.RSSFeedContentController;
	import com.spice.impl.queue.Queue;

	public class GDGTContentController extends RSSFeedContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GDGTContentController(name:String,plugin:GDGTPlugin)
		{
			var queue:Queue = new Queue();
			queue.start();
			
			super(name,plugin,queue,new GDGTFeedDataRenderer(this,plugin));
			
			this.getSearchTerm().setData("feed://user.gdgt.com/architectd/feed/");
		}
		
		
		
		
	}
}