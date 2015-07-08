package com.spice.clove.model
{
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.proxy.mediator.ProxyMediator;
	

	public class CloveInternalProxyMediator extends ProxyMediator
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveInternalProxyMediator()
		{
			Singleton.enforce(this);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public static function getInstance():CloveInternalProxyMediator
		{
			return Singleton.getInstance(CloveInternalProxyMediator);
		}
	}
}