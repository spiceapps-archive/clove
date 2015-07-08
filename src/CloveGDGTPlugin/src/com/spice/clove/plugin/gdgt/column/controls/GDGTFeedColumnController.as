package com.spice.clove.plugin.gdgt.column.controls
{
	import com.adobe.xml.syndication.atom.Atom10;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.events.plugin.RenderedDataTextEvent;
	import com.spice.clove.plugin.column.control.ColumnController;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.gdgt.column.render.GDGTColumnItemRenderer;
	import com.spice.clove.plugin.gdgt.postable.WriteGDGTReviewPostable;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Alert;
	
	public class GDGTFeedColumnController extends ColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Setting]
        public var feed:String;
        
        public static const GDGT_HOME:String = "http://gdgt.com/";
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _loader:URLLoader;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function GDGTFeedColumnController()
		{
			super(new GDGTColumnItemRenderer(null));
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		override public function set pluginController(value:IPluginController):void
		{
			super.pluginController = value;
			
			
			//needed for broadcasting item calls
			GDGTColumnItemRenderer(this.itemRenderer).pluginController = value;
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
			
			Logger.log("onColumnStartLoad",this);
			
			if(!_loader)
			{
				_loader = new URLLoader();
				_loader.addEventListener(Event.COMPLETE,onFeedLoad,false,0,true);
			}
			
			_loader.load(new URLRequest(this.feed));
		}
		
		/*
		 */
		
		override protected function onRendereDataIconClick(event:CloveColumnEvent):void
		{
			var data:RenderedColumnData = event.data;
			
			flash.net.navigateToURL(new URLRequest(GDGT_HOME));
		}
		
		/*
		 */
		
		override protected function onRenderedDataDoubleClick(event:CloveColumnEvent):void
		{
			var data:RenderedColumnData = event.data;
			
			flash.net.navigateToURL(new URLRequest(data.vo.link));
		}
		
		/*
		 */
		
		override protected function onRenderedDataLinkSelect(event:RenderedDataTextEvent):void
		{
			
			var spl:Array = event.text.split("+++");
			
			var url:String = spl[1];
			
			
			this.addActivePostable(new WriteGDGTReviewPostable(this.pluginController,event.data));
			
//			new CloveEvent(CloveEvent.ADD_ACTIVE_POSTABLE,
			
			//for demo, this is ONLY for postingwait			Alert.show(event.text);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        
        /*
		 */
		 
		private function onFeedLoad(event:Event):void
		{
			
			Logger.log("onFeedLoad",this);
			
			var atom:Atom10 = new Atom10();
			atom.parse(_loader.data);
			
			var items:Array = atom.entries;
			
			Logger.log(items);
			
			
			
			this.fillColumn(items);
			
		}

	}
}