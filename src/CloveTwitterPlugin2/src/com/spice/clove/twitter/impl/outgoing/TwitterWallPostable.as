package com.spice.clove.twitter.impl.outgoing
{
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.service.core.calls.CallToServiceAccountType;
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;
	import com.spice.core.calls.CallRemoteServiceLoadCueType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	public class TwitterWallPostable extends TwitterPostable implements IProxyBinding, IProxyResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _updateCall:ProxyCall;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterWallPostable(plugin:TwitterPluginAccount)
		{
			super(plugin);
			
			//bind the display name
			new ProxyCall(CallToServiceAccountType.GET_NAME,plugin.getProxy(),null,this,this).dispatch();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		override public function initialize():void
		{
			super.initialize();
			
			
			_updateCall = new ProxyCall(CallRemoteServiceLoadCueType.SERVICE_RESULT,_account.connection.updateStatus(this.getMessage().getText()).getProxy(),null,this,this).dispatch()
			
		}
		/**
		 */
		
		public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallToServiceAccountType.GET_NAME: return this.setName(n.getData()); //display name = craigcondon myusername5000
				case CallRemoteServiceLoadCueType.SERVICE_RESULT: return this.complete();
			}
		}
		/**
		 */
		
		override public function notifyProxyBinding(n:INotification):void
		{
			this.handleProxyResponse(n);	
			
			super.notifyProxyBinding(n);
		}
		
		
		override protected function complete(status:*=true):void
		{
			_updateCall.dispose();
			
			super.complete(status);
		}
		
		
	}
}