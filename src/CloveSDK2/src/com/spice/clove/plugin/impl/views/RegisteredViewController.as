package com.spice.clove.plugin.impl.views
{
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	
	/**
	 * makes a call for a registered view controller 
	 * @author craigcondon
	 * 
	 */
	
	public class RegisteredViewController  implements IProxyOwner, IProxyResponseHandler, IProxyResponder
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		protected var _target:IProxyOwner;
		protected var _name:String;
		private var _mediator:IProxy;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RegisteredViewController(name:String,mediator:IProxy,data:Object = null)
		{
			_name = name;
			_mediator = mediator;
			
			new ProxyCall(name,mediator,data,this).dispatch().dispose();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAvailableCalls():Vector.<String>
		{
			return this._target.getProxy().getAvailableCalls();
		}
		
		/**
		 */
		
		public function answerProxyCall(call:IProxyCall):void
		{
			this._target.getProxy().call(call);
		}
		
		/**
		 */
		
		public function getProxy():IProxy
		{
			return _target.getProxy();
		}
		
		/**
		 */
		
		public function getProxyMediator():IProxy
		{
			return this._mediator;
		}
		
		/**
		 */
		
		public function handleProxyResponse(n:INotification):void
		{
			if(n.getType() == _name)
			{
				_target = n.getData();
				this.setTargetViewController(_target);
				return;
			}
			
			
			throw new Error("unexpected return type "+n.getType());
		}
		
		/**
		 */
		
		public function getTargetViewController():IProxyOwner
		{
			return this._target;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function setTargetViewController(view:IProxyOwner):void
		{
			
		}
	}
}