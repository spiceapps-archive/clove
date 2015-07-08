package com.spice.clove.nectars.impl.data.attachment
{
	import com.architectd.service.responseHandlers.IResponseHandler;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachment;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachmentFactory;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	public class NectarsDataAttachmentFactory implements ICloveDataAttachmentFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _attViewController:RegisteredCloveDataViewController;
		private var _mediator:IProxyMediator;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function NectarsDataAttachmentFactory(mediator:IProxyMediator)
		{
			_attViewController = new RegisteredCloveDataViewController(CallRegisteredViewType.GET_NEW_REGISTERED_DEFAULT_ROW_ATTACHMENT_VIEW_CONTROLLER,mediator);
			_mediator = mediator;
		}
		
		
		/**
		 */
		
		public function getNewAttachment(name:String):ICloveDataAttachment
		{
			switch(name)
			{
				case NectarsDataAttachmentType.LONG_URL_EXPAND_ATTACHMENT: return new NectarsDataAttachment(name,_attViewController,_mediator);
			}
			
			return null;
		}
	}
}