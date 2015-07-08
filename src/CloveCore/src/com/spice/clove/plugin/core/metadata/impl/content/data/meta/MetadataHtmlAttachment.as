package com.spice.clove.plugin.core.metadata.impl.content.data.meta
{
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.content.data.attachment.VisibleCloveDataAttachment;
	import com.spice.clove.plugin.impl.icons.attachment.AttachmentIcons;

	public class MetadataHtmlAttachment extends VisibleCloveDataAttachment
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function MetadataHtmlAttachment(type:String,viewController:ICloveDataViewController,inlineViewController:ICloveDataViewController,autoExpanded:Boolean = false)
		{
			super(type,viewController,inlineViewController,autoExpanded);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getIcon():*
		{
			return AttachmentIcons.VIDEO;
		}
	}
}