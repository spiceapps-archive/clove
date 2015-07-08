package com.spice.clove.twitter.impl.data.attachment
{
	import com.architectd.twitter2.data.TwitterData;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.impl.content.data.attachment.CloveDataAttachmentFactory;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachment;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachmentFactory;
	import com.spice.clove.plugin.impl.views.RegisteredViewController;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyMediator;

	public class TwitterDataAttachmentFactory extends CloveDataAttachmentFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _attViewController:RegisteredCloveDataViewController;
		private var _renderer:ICloveDataRenderer;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterDataAttachmentFactory(proxy:IProxyMediator,renderer:ICloveDataRenderer)
		{
			super(proxy);
		
			_renderer = renderer;
			
			_attViewController = new RegisteredCloveDataViewController(CallRegisteredViewType.GET_NEW_REGISTERED_DEFAULT_ROW_ATTACHMENT_VIEW_CONTROLLER,proxy);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		  
		/**
		 */
		
		override public function getNewAttachment(type:String):ICloveDataAttachment
		{
			switch(type)
			{
				case TwitterDataAttachmentType.CONVERSATION_ATTACHMENT: return new TwitterConversationAttachment(_attViewController,_renderer);
			}
			
			
			//look for any attachments registered by OTHER plugins
			return super.getNewAttachment(type);
		}
		
	}
}