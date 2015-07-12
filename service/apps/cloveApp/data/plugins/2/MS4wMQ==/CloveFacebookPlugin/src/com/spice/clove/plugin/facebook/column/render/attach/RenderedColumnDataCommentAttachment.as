package com.spice.clove.plugin.facebook.column.render.attach
{
	import com.spice.clove.events.plugin.ColumnControllerEvent;
	import com.spice.clove.plugin.column.control.IColumnController;
	import com.spice.clove.plugin.column.render.link.RenderedColumnDataLinkAttachment;
	import com.spice.clove.plugin.facebook.column.control.sub.FacebookCommentController;
	import com.spice.clove.plugin.facebook.data.PostComment;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;
	import com.spice.clove.views.icons.attachment.AttachmentIcons;
	
	public class RenderedColumnDataCommentAttachment extends RenderedColumnDataLinkAttachment
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable] 
        public var postComments:PostComment;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function RenderedColumnDataCommentAttachment(label:String = null)
		{
			super(label,label,AttachmentIcons.COMMENT);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		

		override public function select():void
		{	
			var c:IColumnController = this.data.column.controller;
			
			c.dispatchEvent(new ColumnControllerEvent(ColumnControllerEvent.SET_BREADCRUMB,new FacebookCommentController(this.data.rowuid)));
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		/* override public function get attachmentView():Class
		{
			return RenderedColumnDataCommentAttachmentView;
		} */
	}
}