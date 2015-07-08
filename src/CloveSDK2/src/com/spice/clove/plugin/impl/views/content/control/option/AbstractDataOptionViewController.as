package com.spice.clove.plugin.impl.views.content.control.option
{
	import com.spice.clove.plugin.core.calls.CallCloveDataOptionViewControllerType;
	import com.spice.clove.plugin.core.content.control.option.menu.ICloveDataMenuOption;
	import com.spice.clove.plugin.impl.views.menu.AbstractMenuItemViewController;
	import com.spice.clove.plugin.impl.views.menu.AbstractRegisteredMenuItemViewController;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.impl.proxy.ProxyCallObserver;
	import com.spice.vanilla.impl.proxy.ProxyResponseObserver;
	
	public class AbstractDataOptionViewController extends AbstractRegisteredMenuItemViewController
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractDataOptionViewController(mediator:IProxyMediator)
		{
			super(mediator);
			
			
			//we have a helper because we don't want to expose ALL of the proxy calls to the proxy mediator. That would be bad >.>
			this.addDisposable(new DataOptionRegisterHelper(mediator,this));
		}
		
	}
}