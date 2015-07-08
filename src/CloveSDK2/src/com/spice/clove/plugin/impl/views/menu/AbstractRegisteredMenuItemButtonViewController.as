package com.spice.clove.plugin.impl.views.menu
{
	import com.spice.clove.plugin.core.calls.CallMenuOptionViewController;
	import com.spice.clove.plugin.core.views.menu.IMenuOptionButtonViewController;
	import com.spice.clove.plugin.core.views.menu.IMenuOptionViewController;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.views.RegisteredViewController;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	import com.spice.vanilla.impl.proxy.ProxyPassThrough;
	
	
	
	public class AbstractRegisteredMenuItemButtonViewController extends RegisteredCloveDataViewController implements IMenuOptionButtonViewController, IProxyBinding
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _menuItem:AbstractRegisteredMenuItemViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractRegisteredMenuItemButtonViewController(name:String,
																	   mediator:IProxyMediator,
																	   target:AbstractRegisteredMenuItemViewController)
		{
			_menuItem = target;
			
			super(name,mediator);
			
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
			ProxyCallUtils.quickCall(n.getType(),_menuItem.getProxy(),n.getData());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		override protected function setTargetViewController(view:IProxyOwner):void
		{
			
			new ProxyBind(view.getProxy(),this,[CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_FLOAT]);
		}
		
		
	}
}