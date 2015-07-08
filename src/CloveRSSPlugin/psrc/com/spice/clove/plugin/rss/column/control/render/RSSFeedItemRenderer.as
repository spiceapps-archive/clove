package com.spice.clove.plugin.rss.column.control.render
{
	import com.adobe.xml.syndication.rss.Item20;
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.IViewRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.column.render.RenderedColumnDataAttachment;
	
	public class RSSFeedItemRenderer implements ICloveColumnItemRenderer, IViewRenderer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _rss20:*
		private var _currentImage:Object;
		private var _icon:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function RSSFeedItemRenderer()
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get rss():*
		{
			return _rss20;
		}
		
		/**
		 */
		
		public function set rss(value:*):void
		{
			this._rss20 = value;
			
			
		}
		
		/**
		 */
		
		public function get icon():Object
		{
			return _icon;	
		}
		
		/**
		 */
		
		public function set icon(value:Object):void
		{
			this._icon = value;
			
		}
		

		
		//--------------------------------------------------------------------------
   	    // 
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		
		public function getUID(vo:Object):String
		{
			return vo.pubDate + vo.title;
		}
		
		/**
		 */
		
		public function getRenderedData(vo:Object):RenderedColumnData
		{
			
			var data:RenderedColumnData = new RenderedColumnData();
			data.construct(vo.pubDate + vo.title,vo.pubDate,vo.title,vo.description,String(_icon),{link:vo.link});
			
			var c:RenderedColumnDataAttachment;
			
			//data.addAttachment(new RenderedColumnDataRSSAttachment(Item20(vo).description));
			
			
			return data;
//			return new RenderedColumnData(vo.pubDate + vo.title,new Date(),{icon:_icon,item:vo});
		}
		
		
		/**
		 */
		
		public function getViewClass(value:RenderedColumnData):Class
		{
			return RSSRowHolder;
		}
       

		

	}
}