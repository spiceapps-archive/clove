package com.spice.clove.plugin.rss.opmlImport
{
	import com.spice.clove.plugin.rss.CloveRSSPlugin;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	public class OPMLColumnCreator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _plugin:CloveRSSPlugin;
		private var _file:File;
		
//		private var _opmlData:OPMLData;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function OPMLColumnCreator(plugin:CloveRSSPlugin = null)
		{
			this._plugin = plugin;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function browse():void
		{
			_file = new File();
			_file.addEventListener(Event.SELECT,onFileSelect);
			//_file.addEventListener(Event.OPEN,onFileOpen);
			
			_file.addEventListener(Event.COMPLETE,onFileOpen);
			_file.browseForOpen("import OPML",[new FileFilter("import OPML","*.xml")]);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		public function get plugin():CloveRSSPlugin
		{
			return _plugin
		}
		
		
		/*
		 */
		public function set plugin(value:CloveRSSPlugin):void
		{
			_plugin = value;
			
			
			/* if(_opmlData)
			{
				this.addGroup(_opmlData);
			} */
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onFileSelect(event:Event):void
		{
			event.target.removeEventListener(event.type,onFileSelect);
			
			_file.load();
			
		}
		
		/*
		 */
		
		private function onFileOpen(event:Event):void
		{/* 
			event.target.removeEventListener(event.type,onFileOpen);
			
			
			var data:ByteArray = File(event.target).data;
			
			
			
			var script:String = data.readUTFBytes(data.bytesAvailable);
			
			
			 var parser:OPMLParser = new OPMLParser();
			 
			 _opmlData = parser.importOPML(script);
			 
			 
			if(_plugin)
				this.addGroup(_opmlData); */
			
		}
		
		/*
		 */
		
		private function addGroup(opml:*):void
		{
			/* var group:GroupColumn = new GroupColumn();
			group.title = opml.title;
			
			for each(var sub:RSSSubscription in opml.subscriptions)
			{
				var col:RSSFeedColumn = new RSSFeedColumn(sub.title,sub.xmlUrl);
				col.installColumn(_plugin);
				
				group.children.addItem(col);
			}
			
			
			this._plugin.addColumn(group); */
		}

	}
}