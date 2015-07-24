package com.cloveHello.plugin.column.render
{
	import com.cloveHello.plugin.column.views.row.HelloColumnRowBodyView;
	import com.cloveHello.plugin.service.vo.MessageVO;
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.IViewRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	
	public class HelloCloveColumnItemRenderer implements ICloveColumnItemRenderer, IViewRenderer
	{
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function HelloCloveColumnItemRenderer()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function getViewClass(rcd:RenderedColumnData):Class
		{
			return HelloColumnRowBodyView;
		}
		
        /**
		 */
		
		public function getUID(vo:Object):String
		{
			return MessageVO(vo).uid;
		}
		
		/**
		 */
		
		public function getRenderedData(vo:Object):RenderedColumnData
		{
			return new RenderedColumnData(vo.uid,vo.dateAdded,vo.title,vo.message);
		}

	}
}