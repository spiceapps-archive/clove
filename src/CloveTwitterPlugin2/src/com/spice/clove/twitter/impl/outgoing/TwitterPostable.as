package com.spice.clove.twitter.impl.outgoing
{
	import com.spice.clove.post.core.calls.CallToPostPluginType;
	import com.spice.clove.post.core.outgoing.ICloveAttachment;
	import com.spice.clove.post.core.outgoing.ICloveAttachmentUploader;
	import com.spice.clove.post.impl.outgoing.AbstractClovePostable;
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;
	import com.spice.core.calls.CallCueType;
	import com.spice.core.queue.ICue;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	

	public class TwitterPostable extends AbstractClovePostable implements IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		protected var _account:TwitterPluginAccount;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterPostable(account:TwitterPluginAccount,name:String = null)
		{
			super(name);
			
			_account = account;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallCueType.COMPLETE: this.addUrlToPostMessage(n.getData());
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
		}
		
		
		/**
		 */
		
		
		override protected function prepareAttachment(n:ICloveAttachment):void
		{
			super.prepareAttachment(n);
			
			
		
			
			var type:String = n.getFileReference().name.replace(/.*?\.(?=\w+)/i,"");
			
			
			var uploader:ICloveAttachmentUploader = _account.getDefaultUploader(type);
			
			
			if(!uploader)
				return;
			
			
			
			var upCue:ICue = uploader.upload(n);
			new ProxyBind(upCue.getProxy(),this,[CallCueType.COMPLETE],true);
			upCue.initialize();
			
		}
		
		
		/**
		 */
		
		protected function addUrlToPostMessage(value:String):void
		{
			ProxyCallUtils.quickCall(CallToPostPluginType.ADD_TEXT_TO_POST_WINDOW,this._account.getPluginMediator(),value);
		}
	}
}