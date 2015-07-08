package com.spice.clove.plugin.impl.views.content.control.option
{
	import com.spice.clove.plugin.core.calls.CallCloveDataOptionViewControllerType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyCallObserver;
	import com.spice.vanilla.impl.proxy.ProxyOwner;

	internal class DataOptionRegisterHelper implements IProxyResponder, IDisposable, IProxyResponseHandler, IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _target:AbstractDataOptionViewController;
		private var _availableCalls:Vector.<String>;
		private var _observer:ProxyCallObserver;
		private var _mediator:IProxyMediator;
		private var _call:ProxyCall;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DataOptionRegisterHelper(mediator:IProxyMediator,target:AbstractDataOptionViewController)
		{
			super();
			
			_target = target;
			_availableCalls = new Vector.<String>(1,true);
			_availableCalls[0] = CallCloveDataOptionViewControllerType.DATA_OPTION_CHILD_VIEW_CONTROLLERS;
			
			
			_mediator = mediator;
			
			
			_call = new ProxyCall(CallCloveDataOptionViewControllerType.DATA_OPTION_CHILD_VIEW_CONTROLLERS,mediator,null,this,this);
			_call.dispatch();
			
			//fetch the already existing data options
			
			mediator.addProxyCallObserver((_observer = new ProxyCallObserver(this)));
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
				case CallCloveDataOptionViewControllerType.DATA_OPTION_CHILD_VIEW_CONTROLLERS: return this._target.addChildMenuItemViewController(n.getData());
			}
		}
		
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			this.handleProxyResponse(n);
		}
		
		/**
		 */
		
		public function dispose():void
		{
			_mediator.removeProxyCallObserver(this._observer);	
			_call.dispose();
		}
		
		/**
		 */
		
		public function getAvailableCalls():Vector.<String>
		{
			return this._availableCalls;
		}
		/**
		 */
		
		public function answerProxyCall(c:IProxyCall):void
		{
			this.handleProxyResponse(c);
		}
		
	}
}