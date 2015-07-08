package com.spice.clove.rss.impl.content.control
{
	import com.adobe.xml.syndication.NewsParser;
	import com.adobe.xml.syndication.ParsingTools;
	import com.adobe.xml.syndication.generic.FeedFactory;
	import com.adobe.xml.syndication.generic.IFeed;
	import com.adobe.xml.syndication.rss.RSS20;
	import com.spice.clove.analytics.core.AnalyticalActionType;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerState;
	import com.spice.clove.rss.impl.cue.LoadRSSCue;
	import com.spice.impl.cache.MemoryCache;
	import com.spice.impl.queue.Queue;
	
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;

	public class RSSFeedHelper
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _target:CloveContentController;
		private var _queue:Queue;
		
		
		private static var _cache:MemoryCache;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RSSFeedHelper(target:CloveContentController,queue:Queue)
		{
			_target = target;
			_queue  = queue;
			
			if(!_cache)
			{
				_cache = new MemoryCache();
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function load(url:String):void
		{
			
			
			if(url.length == 0)
			{
				_target.showErrorMessage("404 not found"); 
				return;
			}
			
			if(url.indexOf("feed://") > -1)
			{
				url = url.replace("feed://","http://");
			}
			else
				if(url.indexOf("http://") == -1)
				{
					url = "http://"+url;
				}
			
			
			_target.recordAnalayticalData(AnalyticalActionType.FEED_LOADED,url);
			
			
			var data:Object = null;
			
			if((data = _cache.getCache(url)) == null)
			{
				_queue.addCue(new LoadRSSCue(url,this.onRSSFeedLoad));
			}
			else
			{
				this.parseRawXML(url,data);
			}
			
		}
		/**
		 */
		
		
		private function onRSSFeedLoad(cue:LoadRSSCue,event:*):void
		{
			
			event.currentTarget.removeEventListener(event.type,onRSSFeedLoad);
			
			if(event is IOErrorEvent)
			{
				_target.showErrorMessage("Unable to load RSS Feed.");
				return;
			}
			try
			{
				this.parseRawXML(cue.feed,event.target.data);
				
				this._target.setLoadingState(CloveContentControllerState.COMPLETE);
			}catch(e:Error)
			{
				_target.showErrorMessage("Unable to parse RSS.");
			}
			
		}
		
		
		/**
		 */
		
		private function parseRawXML(url:String,value:*):void
		{
			
			var feed:IFeed;
			
			if(value is IFeed)
			{
				feed = IFeed(value);
			}
			else
			{
				feed = FeedFactory.getFeedByString(value);
			}
			
			
			_cache.storeCache(url,feed,60);//cache for a minute
			
			this._target.setName(feed.metadata.title);
			
			this._target.fillColumn(feed.items);
		}
		
		/**
		 */
		
		private function parseRSS(rss:*,data:*):void
		{
			
			rss.parse(data);
			
			
			//			this.setName(RSS20(rss).
			
			_target.setName(RSS20(rss).channel.title);
			
			var items:Array = rss.items;
			
			
			//			this.setIcon16(rss.channel.link.match(/(.*?\\|.*)/)[0]+"/favicon.ico");
			
			_target.fillColumn(items);
		}
	}
}