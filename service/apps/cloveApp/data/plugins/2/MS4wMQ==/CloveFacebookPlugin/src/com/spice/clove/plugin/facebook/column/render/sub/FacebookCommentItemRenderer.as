package com.spice.clove.plugin.facebook.column.render.sub
{
	import com.facebook.data.stream.PostCommentData;
	import com.spice.clove.plugin.column.render.IReusableCloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;
	
	public class FacebookCommentItemRenderer implements IReusableCloveColumnItemRenderer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function FacebookCommentItemRenderer()
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
			return PostCommentData(vo).id;
		}
		
		/**
		 */
		
		public function getRenderedData(value:Object):RenderedColumnData
		{
			var pcd:PostCommentData = PostCommentData(value);
			
		
			
			return new RenderedColumnData().construct(pcd.id,pcd.time,null,pcd.text,null,pcd);
		}
		
		
		/**
		 */
		
		public function reuse(rcd:RenderedColumnData):void
		{
			_model.friendModel.getFriendInfo(rcd.vo.fromid).bindRenderedData(rcd);
		}
	}
}