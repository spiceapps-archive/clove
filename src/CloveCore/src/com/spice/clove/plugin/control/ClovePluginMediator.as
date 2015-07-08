package com.spice.clove.plugin.control
{
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.proxy.mediator.ProxyMediator;

	public class ClovePluginMediator extends ProxyMediator
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ClovePluginMediator()
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
		
		public static function getInstance():ClovePluginMediator
		{
			return Singleton.getInstance(ClovePluginMediator);
		}
	}
}