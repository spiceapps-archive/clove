package com.spice.clove.plugin.facebook.column.render.attach
{
	import com.facebook.data.stream.PhotoMedia;
	import com.spice.clove.plugin.column.render.RenderedColumnDataAttachment;
	import com.spice.clove.views.icons.attachment.AttachmentIcons;

	public class RenderedColumnDataPhotoAttachment extends RenderedColumnDataAttachment
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var photo:*;
		public var src:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RenderedColumnDataPhotoAttachment(photo:PhotoMedia = null,src:String = null)
		{
			super(src,AttachmentIcons.PHOTO);
			
			this.photo = photo;
			this.src   = src;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function get attachmentView() : Class
		{
			return RenderedCOlumnDataPhotoAttachmentView;
		}
	}
}