package com.spice.clove.plugin.core.metadata.impl.content.data.meta
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.metadata.impl.MetadataPlugin;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.content.data.attachment.CloveDataAttachment;
	import com.spice.clove.plugin.impl.content.data.attachment.VisibleCloveDataAttachment;
	import com.spice.clove.plugin.impl.icons.attachment.AttachmentIcons;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;

	public class MetadataLinkAttachment extends VisibleCloveDataAttachment
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _mediator:IProxyMediator;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function MetadataLinkAttachment(type:String,viewController:ICloveDataViewController,mediator:IProxyMediator)
		{
			super(type,viewController);
			this._mediator = mediator;
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
			return AttachmentIcons.LINK;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function visibleAttachmentClick():void
		{
			ProxyCallUtils.quickCall(CallAppCommandType.NAVIGATE_TO_URL,_mediator,this.getMetadata().getData());
		}
	}
}