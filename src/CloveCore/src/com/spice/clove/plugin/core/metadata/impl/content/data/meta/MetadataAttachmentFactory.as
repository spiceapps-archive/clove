package com.spice.clove.plugin.core.metadata.impl.content.data.meta
{
	import com.spice.clove.plugin.core.metadata.flex.views.attachment.EmbeddableHtmlAttachmentView;
	import com.spice.clove.plugin.core.metadata.flex.views.attachment.EmbeddableVideoAttachmentView;
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.clove.plugin.impl.content.data.CloveMetadataType;
	import com.spice.clove.plugin.impl.content.data.attachment.CloveDataAttachmentFactory;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachment;
	import com.spice.vanilla.core.proxy.IProxyMediator;

	public class MetadataAttachmentFactory extends CloveDataAttachmentFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function MetadataAttachmentFactory(mediator:IProxyMediator)
		{
			super(mediator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getNewAttachment(name:String):ICloveDataAttachment
		{
			switch(name)
			{  
				case CloveMetadataType.EMBEDDABLE_HTML_VIDEO: return new MetadataVideoAttachment(name,_defaultRowViewController,new CloveDataViewController(EmbeddableVideoAttachmentView));
				case CloveMetadataType.AUTO_EXPANDED_EMBEDDABLE_HTML: return new MetadataHtmlAttachment(name,_defaultRowViewController,new CloveDataViewController(EmbeddableHtmlAttachmentView),true);
				case CloveMetadataType.HTML_URL: return new MetadataLinkAttachment(name,_defaultRowViewController,IProxyMediator(_defaultRowViewController.getProxyMediator()));
			}
			
			return super.getNewAttachment(name);
		}
	}
}