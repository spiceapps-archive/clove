package com.spice.clove.proxy.responders
{
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	/**
	 * TEMPORARY measure to listen in for plugin calls to the application 
	 * @author craigcondon
	 * 
	 */	
	public class CloveAppPluginResponder implements IProxyResponseHandler, IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveAppPluginResponder()
		{
			new ProxyCall(CallAppCommandType.SET_APP_VIEW,ClovePluginMediator.getInstance(),null,this,this).dispatch();
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
				case CallAppCommandType.SET_APP_VIEW:
					//_model.rootView = n.getData();
				break;
			}
		}
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			this.handleProxyResponse(n);
		}
	}
}