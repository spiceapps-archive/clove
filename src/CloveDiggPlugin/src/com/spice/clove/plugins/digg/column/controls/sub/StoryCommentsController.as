package com.spice.clove.plugins.digg.column.controls.sub
{
	import com.architectd.digg2.calls.comment.GetCommentRepliesCall;
	import com.architectd.digg2.calls.stories.GetStoryCommentsCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugins.digg.column.controls.DiggColumnController;
	import com.spice.clove.plugins.digg.column.render.sub.DiggCommentItemRenderer;
	
	public class StoryCommentsController extends DiggColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable] 
        [Setting]
        public var renderedColumnData:RenderedColumnData;
        
        [Bindable] 
        [Setting]
        public var isReplyToComment:Boolean;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function StoryCommentsController(rcd:RenderedColumnData = null,isReplyToComment:Boolean = false)
		{
			super(new DiggCommentItemRenderer());
			
			this.renderedColumnData = rcd;
			this.isReplyToComment = isReplyToComment;
			
			this.title = "Comments";
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function onColumnStartLoad(event:CloveColumnEvent):void
		{
			if(this.isReplyToComment)
				this.call(new GetCommentRepliesCall(this.renderedColumnData.rowuid));
			else
				this.call(new GetStoryCommentsCall(this.renderedColumnData.rowuid));
		}
		
		
		/**
		 */
		
		override protected function onRenderedDataDoubleClick(event:CloveColumnEvent):void
		{
			this.setBreadcrumb(new StoryCommentsController(event.data,true));
		}
		

	}
}