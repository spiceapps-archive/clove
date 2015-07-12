package com.spice.clove.plugin.facebook.column.render
{
	import com.facebook.data.stream.StreamStoryData;
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.facebook.column.render.views.FacebookPhotoRow;

	public class FacebookPhotoItemRenderer implements ICloveColumnItemRenderer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var viewClass:Class = FacebookPhotoRow;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookPhotoItemRenderer()
		{
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
			return "";
		}
		/**
		 */
		
		public function getRenderedData(vo:Object):RenderedColumnData
		{
			var sd:StreamStoryData = StreamStoryData(vo);
			
			return null;
		}
	}
}