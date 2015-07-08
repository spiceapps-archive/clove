package com.spice.clove.bing.impl.content.control.search
{
	import com.spice.clove.bing.impl.BingPlugin;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.content.control.search.CloveSearchBasedContentController;
	import com.spice.clove.rss.impl.content.control.RSSFeedContentController;
	import com.spice.clove.rss.impl.content.control.RSSFeedHelper;
	import com.spice.clove.rss.impl.content.control.render.RSSFeedDataRenderer;

	public class BingSearchContentController extends CloveSearchBasedContentController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _helper:RSSFeedHelper;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BingSearchContentController(factoryName:String,plugin:BingPlugin)
		{
			var renderer:RSSFeedDataRenderer = new RSSFeedDataRenderer(this,plugin)
			super(factoryName,plugin,renderer,null,"Bing Search: ");
			
			_helper = new RSSFeedHelper(this,plugin.getQueue());
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function loadNewer2(data:ICloveData=null):void
		{
			
			if(this.getSearchTerm().getData() == "")
			{
				this.fillColumn([]);
				return;
			}
			
			
			var search:String = "http://www.bing.com/search?q="+this.getSearchTerm().getData()+"&go=&form=QBLH&qs=n&sk=&sc=8-5&format=rss";
			
			
			_helper.load(search);
		}
		
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
		}
		
		
		
	}
}