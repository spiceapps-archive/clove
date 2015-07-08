package com.spice.clove.plugin.impl.content.data.attachment
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.media.Video;

	public class CloveDataAttachmentFactory implements ICloveDataAttachmentFactory, 
													   IProxyResponseHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _globalAttachmentFactories:Vector.<ICloveDataAttachmentFactory>;
		private var _proxy:IProxyMediator;
	
		protected var _defaultRowViewController:RegisteredCloveDataViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		
		
		
		/**
		 * Constructor 
		 * @param proxy the proxy mediator
		 * @param addAvailableAttachmentsCall the call to make to the proxy mediator when fetching available attachments registered
		 * by other plugins. One good use case is the Twitter Plugin making this call, and TweetLonger returning a an available expanded url attachment
		 * 
		 */		
		
		public function CloveDataAttachmentFactory(proxy:IProxyMediator,addAvailableAttachmentsCall:String = null,useGlobal:Boolean = true)
		{
			
			this._proxy = proxy;
			
			
			if(useGlobal)
			ProxyCallUtils.quickCall(CallAppCommandType.GET_REGISTERED_DATA_ATTACHENT_FACTORIES,proxy,null,this);
			
			this._defaultRowViewController = new RegisteredCloveDataViewController(CallRegisteredViewType.GET_NEW_REGISTERED_DEFAULT_ROW_ATTACHMENT_VIEW_CONTROLLER,proxy);
			
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallAppCommandType.GET_REGISTERED_DATA_ATTACHENT_FACTORIES: return this.addRegisteredAttachmentFactory(n.getData());
			}
		}
		
		/**
		 */
		
		public function getNewAttachment(name:String):ICloveDataAttachment
		{
			
			if(this._globalAttachmentFactories)
			{
				for each(var factory:ICloveDataAttachmentFactory in this._globalAttachmentFactories)
				{
					var data:ICloveDataAttachment = factory.getNewAttachment(name);
					
					if(data)
						return data;
				}
			}
			
			return null;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function addRegisteredAttachmentFactory(value:ICloveDataAttachmentFactory):void
		{
			if(!this._globalAttachmentFactories)
			{
				this._globalAttachmentFactories = new Vector.<ICloveDataAttachmentFactory>();
			}
			
			this._globalAttachmentFactories.push(value);
			
			
		}
		
	}
}