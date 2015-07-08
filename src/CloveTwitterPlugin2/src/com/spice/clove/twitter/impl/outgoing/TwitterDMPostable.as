package com.spice.clove.twitter.impl.outgoing
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.post.core.outgoing.ICloveAttachment;
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;
	import com.spice.core.calls.CallRemoteServiceLoadCueType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;

	public class TwitterDMPostable extends TwitterPostable implements IProxyBinding
		
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _target:ICloveData;
		private var _callBind:ProxyBind;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterDMPostable(target:ICloveData,account:TwitterPluginAccount)
		{
			_target = target;
			
			super(account,"Direct Message: "+target.getTitle());
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getData())
			{
				case CallRemoteServiceLoadCueType.SERVICE_RESULT: return this.complete();
			}
			
			super.notifyProxyBinding(n);
			
		}
		
		
		/**
		 */
		
		override protected function complete(status:* = true):void
		{
			super.complete(status);
			
			
			_callBind.dispose();
		}
		
		/**
		 */
		
		override public function initialize():void
		{
			super.initialize();
			
			var call:IProxyOwner = _account.connection.sendDirectMessage(this._target.getTitle(),this.getMessage().getText());
			
			_callBind = new ProxyBind(call.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT],true);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function prepareAttachment(n:ICloveAttachment):void
		{
			super.prepareAttachment(n);
		}
		
	}
}