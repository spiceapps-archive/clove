package com.spice.clove.plugin.impl.views.menu
{
	import com.spice.clove.plugin.core.calls.CallMenuOptionViewController;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.calls.data.ShowMenuOptionViewData;
	import com.spice.clove.plugin.core.views.menu.IMenuOptionViewController;
	import com.spice.clove.plugin.impl.content.control.option.menu.CloveDataMenuOption;
	import com.spice.clove.plugin.impl.views.RegisteredViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	
	/**
	 * a wrapper for registered menu item view controllers 
	 * @author craigcondon
	 * 
	 */	
	public class AbstractRegisteredMenuItemViewController extends AbstractMenuItemViewController implements IMenuOptionViewController, IProxyBinding, IProxyResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _mediator:IProxy;
		private var _showingFromTarget:Boolean;
		private var _target:IMenuOptionViewController;
		private var _parent:*;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractRegisteredMenuItemViewController(mediator:IProxy)
		{
			
			_mediator = mediator;
			
			
			ProxyCallUtils.quickCall(CallRegisteredViewType.GET_NEW_REGISTERED_MENU_VIEW_CONTROLLER,mediator,null,this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getProxyMediator():IProxy
		{
			return _mediator;
		}
		
		/**
		 */
		
		override public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_FLOAT: 
					
					if(_showingFromTarget)
						return;
					
					_showingFromTarget = true;
					this.showMenu(n.getData());
					_showingFromTarget = false;
					
					return;
					
				case CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_IN_NATIVE_MENU:
					if(_showingFromTarget)
						return;
					
					this._showingFromTarget = true;
					this.showMenuUnder(n.getData());
					this._showingFromTarget = false;
					
					return;
			}
			
			super.handleProxyResponse(n);
		}
		
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			if(n.getType() == CallRegisteredViewType.GET_NEW_REGISTERED_MENU_VIEW_CONTROLLER)
			{
				return this.setTargetViewController(n.getData());
			}
			
			super.handleProxyResponse(n);
		}
		
		
		/**
		 */
		
		final override public function showMenu(data:ShowMenuOptionViewData):void
		{
			super.showMenu(data);
			
			
			ProxyCallUtils.quickCall(CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SET_ITEMS,this._target.getProxy(),this._usedMenuItems);
			
			
			//if the call hasn't been made from the target, then tell the target to show
			if(!_showingFromTarget)
			{
				ProxyCallUtils.quickCall(CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_FLOAT,this._target.getProxy(),data);
			}
		}
		
		/**
		 */
		
		final override public function showMenuUnder(parent:*=null):void
		{
			super.showMenuUnder(parent);
			
			if(!this._target)
				return;
			
			
			ProxyCallUtils.quickCall(CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SET_ITEMS,this._target.getProxy(),this._usedMenuItems);
			
			if(parent)
			{
				this._parent = parent;
			}
			
			if(_parent)
			{
				ProxyCallUtils.quickCall(CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_IN_NATIVE_MENU,this._target.getProxy(),_parent);
			}
		}
		
		/**
		 */
		
		public function setEnabled(name:String,value:Boolean):void
		{
			var me:CloveDataMenuOption = this._allocatedMenuItems[name];
			
			if(!me) return;
			
			me.setEnabled(value);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		protected function setTargetViewController(view:IMenuOptionViewController):void
		{
			
			_target = IMenuOptionViewController(view);
			
			this.addDisposable(new ProxyBind(_target.getProxy(),this,[CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_FLOAT,CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_IN_NATIVE_MENU]));
			
		}
		
		
		
	}
}