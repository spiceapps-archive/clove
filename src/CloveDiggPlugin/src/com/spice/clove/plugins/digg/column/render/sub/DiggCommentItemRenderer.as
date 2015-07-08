package com.spice.clove.plugins.digg.column.render.sub
{
	import com.architectd.digg2.data.CommentData;
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	
	public class DiggCommentItemRenderer implements ICloveColumnItemRenderer
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function DiggCommentItemRenderer()
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
			return CommentData(vo).id.toString();
		}
		
		/**
		 */
		
		public function getRenderedData(vo:Object):RenderedColumnData
		{
			
			var cd:CommentData = CommentData(vo);
			
			
			var rcd:RenderedColumnData = new RenderedColumnData().construct(cd.id.toString(),cd.submitted,cd.user.username+(cd.replies > 0 ? " - "+cd.replies+" replies" : ""),cd.comment);
			
			
			
			
			return rcd;
		}

	}
}