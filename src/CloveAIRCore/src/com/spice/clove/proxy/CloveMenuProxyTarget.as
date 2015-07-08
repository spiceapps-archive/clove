
package com.spice.clove.proxy
{
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallAppMenuType;
	import com.spice.clove.plugin.core.calls.CallMenuOptionViewController;
	import com.spice.clove.plugin.core.calls.data.AddRootMenuItemData;
	import com.spice.clove.plugin.core.views.menu.IMenuOptionViewController;
	import com.spice.clove.plugin.desktop.views.menu.AIRMenuViewController;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;
	import mx.core.Application;

	public class CloveMenuProxyTarget extends ProxyOwner
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _menu:NativeMenu;
		private var _menuItemViewControllers:Dictionary;
		private var _initialized:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveMenuProxyTarget()
		{
			this.getProxyController().setProxyMediator(ClovePluginMediator.getInstance());
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallAppMenuType.REGISTER_APP_ROOT_MENU_ITEM: return this.registerRootMenuItem(c.getData());
				case CallAppMenuType.APP_ROOT_MENU_INITIALIZE: return this.initialize();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			
			this.addAvailableCalls([CallAppMenuType.REGISTER_APP_ROOT_MENU_ITEM,
									CallAppMenuType.APP_ROOT_MENU_INITIALIZE]);
		}
		
		
		
		public function registerRootMenuItem(value:AddRootMenuItemData):void
		{
			
			if(!_menu)
			{
				_menu = new NativeMenu();
				this._menuItemViewControllers = new Dictionary();
			}
			
			var menu:NativeMenuItem;
			
			
			if(value.getMenuOptionViewController() is NativeMenuItem)
			{
				menu = value.getMenuOptionViewController();
			}
			else
			{
				menu = new NativeMenuItem(value.getName());
				this._menuItemViewControllers[menu] = value.getMenuOptionViewController();
				this.setMenuItems(menu);
			}
			
			
			menu.addEventListener(Event.ACTIVATE,onNativeMenuItemSelect);
			menu.addEventListener(Event.DISPLAYING,onNativeMenuItemSelect);
			menu.addEventListener(Event.SELECT,onNativeMenuItemSelect);
			
			
			
			_menu.addItem(menu);
			
			
			if(this._initialized)
			{
				(NativeApplication.supportsMenu ? Application.application.nativeApplication : Application.application.nativeWindow).menu = this._menu;
			}
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onNativeMenuItemSelect(event:Event):void
		{
			
			this.setMenuItems(event.currentTarget as NativeMenuItem);
		}
		
		
		/**
		 */
		
		private function setMenuItems(target:NativeMenuItem):void
		{
			
			
			var controller:IMenuOptionViewController = this._menuItemViewControllers[target];
			
			if(!controller)
				return;
			
			ProxyCallUtils.quickCall(CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_IN_NATIVE_MENU,controller.getProxy(),target);
		}
		
		/**
		 */
		
		private function initialize():void
		{
			if(this._initialized)
			{
				return;
			}
			
			this._initialized = true;
			
			
			
			var nm:* = NativeApplication.supportsMenu ? Application.application.nativeApplication : Application.application.nativeWindow;
			
			
			//error on windows
			/*Application.application.nativeWindow.menu = new NativeMenu();
			if(Application.application.nativeApplication.menu)
			{
			Application.application.nativeApplication.menu.removeAllItems();
			}*/
			
			//FIXME: bad code design ~ bandaid. we initialize the classes at the same time so that they can all
			//reference one another ex: Twitpic and Twitter
			//initialize the plugins
			
			
			var men:NativeMenu = new NativeMenu();
			
			if(Capabilities.os.indexOf("Mac") > -1 && false)
			{
				
				var mnu:NativeMenu = nm.menu.getItemAt(0).submenu;
				
				var hideApp:NativeMenuItem = mnu.removeItemAt(2);
				var hideOthers:NativeMenuItem = mnu.removeItemAt(3);
				
				
				var nmu2:NativeMenuItem = this._menu.items[0];
				nmu2.submenu.setItemIndex(hideApp,2);
				nmu2.submenu.setItemIndex(hideOthers,3);
			}
			
//			for each(var menu:NativeMenuItem in this._menu.submenu.items)
//			{
//				men.addItem(menu);
//			}
			
			
			nm.menu = this._menu;
		}
		
	}
}
