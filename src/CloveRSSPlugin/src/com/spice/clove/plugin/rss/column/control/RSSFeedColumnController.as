package com.spice.clove.plugin.rss.column.control
{
	import com.adobe.xml.syndication.rss.RSS20;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.control.ColumnController;
	import com.spice.clove.plugin.rss.CloveRSSPlugin;
	import com.spice.clove.plugin.rss.column.control.render.RSSFeedItemRenderer;
	import com.spice.clove.plugin.rss.cue.LoadRSSCue;
	
	import flash.xml.XMLDocument;
	
	import flexlib.controls.IconLoader;
	
	
	
	public class RSSFeedColumnController extends ColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
			
		[Bindable] 
		[Setting]
        public var feed:String;
		
		
		[Bindable] 
		[Setting]
		public var name:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function RSSFeedColumnController()
		{
			super(new RSSFeedItemRenderer());
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
        override protected function onColumnStartLoad(event:CloveColumnEvent):void
        {
        	
        	if(!this.feed || !this.pluginController || this.feed == "")
        	{
        		//breaks app
        		return;
//        		Logger.log("Feed or plugin controller doesn't exist. Cannot load feeds!",this,LogType.NOTICE);
        	}
        	
        	
			
			var cue:LoadRSSCue = new LoadRSSCue(this.feed,this.onComplete);
			
			this.setLoadCue(cue);
        	
        	 CloveRSSPlugin(this.pluginController.plugin).call(cue);
        }
        
        
        /*
		 */
		
		
        //--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
		 /*
		  */
		private function onComplete(event:Event):void
		{
			Logger.log("onComplete()",this);
			
			
			event.target.removeEventListener(event.type,onComplete);
			
			var item:XMLDocument = new XMLDocument(event.target.data);
			
			/* var version:Number = new Number(item.xmlDecl.toString().match("version=\"(.?)\"")[1]);
			
			
			if(version < 2)
			{
				this.parseRSS(new RSS10(),event.target.data);
				
			}
			else */
			{
				this.parseRSS(new RSS20(),event.target.data);	
			}
			
		}
		
		/*
		 */
		
		private function parseRSS(rss:*,data:*):void
		{
			rss.parse(data);

			var items:Array = rss.items;
			
			//get the site url http://engadget.com/feeds/monitors.xml
						
			//get the base url http://engadget.com/
						
			//get the fav icon http://engadget.com/favicon.ico
						
			
			RSSFeedItemRenderer(this.itemRenderer).rss = rss;
			RSSFeedItemRenderer(this.itemRenderer).icon  =     rss.channel.link.match(/(.*?\\|.*)/)[0]+"/favicon.ico";
			
			
			
			this.fillColumn(items);
		}

	}
}