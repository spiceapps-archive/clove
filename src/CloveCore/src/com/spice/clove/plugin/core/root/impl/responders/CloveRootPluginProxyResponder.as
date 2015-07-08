package com.spice.clove.plugin.core.root.impl.responders
{
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.content.control.ICloveContentControllerFactory;
	import com.spice.clove.plugin.core.root.impl.data.AvailableServiceDelegateData;
	import com.spice.clove.plugin.core.root.impl.models.CloveRootModelLocator;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;

	
	/**
	 *  
	 * @author craigcondon
	 * 
	 */	
	public class CloveRootPluginProxyResponder extends ProxyOwner implements IProxyResponseHandler, IProxyBinding
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:CloveRootModelLocator;
		private var _initialized:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveRootPluginProxyResponder()
		{
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function initialize(mediator:IProxyMediator):void
		{
			if(_initialized)
			{
				throw new Error(" cannot re-initialize "+this);
			}
			
			
			this._initialized = true;
			
			
			_model = CloveRootModelLocator.getInstance();
			
			new ProxyCall(CallClovePluginType.GET_CONTENT_CONTROLLER_FACTORY,mediator,null,this,this).dispatch();
		}
		
		
		/**
		 */
		
		public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallClovePluginType.GET_CONTENT_CONTROLLER_FACTORY: return  this.getContentControllerFactory(n.getData());
			}
		}
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			this.handleProxyResponse(n);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		protected function getContentControllerFactory(factory:ICloveContentControllerFactory):void
		{
			for each(var serviceName:String in factory.getAvailableContentControllers())
			{
				_model.availableServiceDelegates.addItem(new AvailableServiceDelegateData(serviceName,factory));
			}
		}
		
	}
}