package com.spice.clove.plugins.digg.column.render
{
	import com.architectd.digg2.data.StoryData;
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugins.digg.column.views.row.StoryRowBodyView;

	public class DiggStoryColumnItemRenderer implements ICloveColumnItemRenderer
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var viewClass:Class = StoryRowBodyView;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggStoryColumnItemRenderer()
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
			return vo.id;
		}
		
		/**
		 */
		
		public function getRenderedData(vo:Object):RenderedColumnData
		{
			var s:StoryData = StoryData(vo);
			
			
			return new RenderedColumnData().construct(s.id.toString(),new Date(1000000+s.diggs),s.title,s.description,s.thumbnail,s);
		}
	}
}