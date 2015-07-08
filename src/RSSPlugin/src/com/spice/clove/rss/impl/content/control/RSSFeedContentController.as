package com.spice.clove.rss.impl.content.control
{
	import com.adobe.xml.syndication.generic.RSS20Item;
	import com.adobe.xml.syndication.rss.RSS20;
	import com.spice.clove.analytics.core.AnalyticalActionType;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerState;
	import com.spice.clove.plugin.impl.content.control.search.CloveSearchBasedContentController;
	import com.spice.clove.rss.impl.RSSPlugin;
	import com.spice.clove.rss.impl.content.control.render.RSSFeedDataRenderer;
	import com.spice.clove.rss.impl.cue.LoadRSSCue;
	import com.spice.impl.queue.Queue;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.xml.XMLDocument;

	public class RSSFeedContentController extends CloveSearchBasedContentController
	{  
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _feedTitle:StringSetting;
		private var _helper:RSSFeedHelper;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RSSFeedContentController(name:String,plugin:ClovePlugin,queue:Queue,dataRenderer:ICloveDataRenderer = null)
		{
			
			this.recordAnalyticalKeywordSearchData = false;
			
			
			super(name,plugin,dataRenderer || new RSSFeedDataRenderer(this,plugin));
			
			
			
			_feedTitle = this.getSettings().getNewSetting(BasicSettingType.STRING,"feedTitle") as StringSetting;
			_feedTitle.setData("RSS Feed");
			
			
			this.setName("RSS Feed");
			
			
			_helper = new RSSFeedHelper(this,queue);
			
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
			
			var term:String = this.getSearchTerm().getData();
			
			_helper.load(term);
//			RSSPlugin(this.getPlugin()).getQueue().addCue();
			
			
		
			
		}
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			this.setLoadingState(CloveContentControllerState.COMPLETE);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function searchTermChange():void
		{
			//do nothing
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
	}
}