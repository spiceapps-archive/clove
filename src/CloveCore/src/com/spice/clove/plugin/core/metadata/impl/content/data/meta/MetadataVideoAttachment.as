package com.spice.clove.plugin.core.metadata.impl.content.data.meta
{
	import com.spice.clove.plugin.core.metadata.impl.assets.MetadataAssets;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.content.data.attachment.VisibleCloveDataAttachment;

	public class MetadataVideoAttachment extends VisibleCloveDataAttachment
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function MetadataVideoAttachment(type:String,viewController:ICloveDataViewController,inlineViewController:ICloveDataViewController)
		{
			super(type,viewController,inlineViewController);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getLabel():String
		{
			return "Watch Video";
		}
		
		/**
		 */
		
		override public function getIcon():*
		{
			return MetadataAssets.VIDEO_ICON;
		}
		
	}
}