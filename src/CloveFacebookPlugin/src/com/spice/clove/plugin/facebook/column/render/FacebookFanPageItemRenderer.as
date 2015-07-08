package com.spice.clove.plugin.facebook.column.render
{
	import com.facebook.data.pages.PageInfoData;
	import com.facebook.data.stream.StreamStoryData;
	import com.spice.clove.plugin.column.render.RenderedColumnData;

	public class FacebookFanPageItemRenderer extends FacebookStreamItemRenderer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		public var fanPage:PageInfoData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookFanPageItemRenderer()
		{
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		override public function getRenderedData(vo:Object) : RenderedColumnData
		{
			var data:RenderedColumnData = super.getRenderedData(vo);
			
			
			var ssd:StreamStoryData = StreamStoryData(vo);
			
			if(/*ssd.actor_id == this.fanPage.page_id.toString()*/ ssd.target_id == "")//fan page
			{
				data.title = this.fanPage.name;
				data.icon = this.fanPage.pic_small;
			}
			
			
			return data;
		}
		/**
		 */
		
		override public function reuse(data:RenderedColumnData) : void
		{
			if(!data.icon|| data.icon == "")
				super.reuse(data);
		}
	}
}