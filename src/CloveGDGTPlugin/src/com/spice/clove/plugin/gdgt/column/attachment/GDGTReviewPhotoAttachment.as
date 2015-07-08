package com.spice.clove.plugin.gdgt.column.attachment
{
	import com.spice.clove.plugin.column.render.RenderedColumnDataAttachment;
	import com.spice.clove.plugin.gdgt.column.attachment.views.GDGTReviewPhotoAttachmentView;
	import com.spice.clove.views.icons.attachment.AttachmentIcons;
	
	public class GDGTReviewPhotoAttachment extends RenderedColumnDataAttachment
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function GDGTReviewPhotoAttachment()
		{
			super("View Photo",AttachmentIcons.PHOTO);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		override public function get attachmentView():Class
		{
			return GDGTReviewPhotoAttachmentView;
		}

	}
}