package com.spice.clove.plugin.impl.views.menu
{
	import com.spice.clove.plugin.core.calls.CallMenuOptionViewController;
	import com.spice.clove.plugin.core.calls.data.ShowMenuOptionViewData;
	import com.spice.clove.plugin.core.content.control.option.menu.ICloveDataMenuOption;
	import com.spice.clove.plugin.core.views.menu.IMenuOptionViewController;
	import com.spice.clove.plugin.impl.content.control.option.menu.CloveDataMenuOption;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	import com.spice.vanilla.impl.proxy.ProxyResponseObserver;
	
	/**
	 * controlMenuOptionViewControllergcondon
	 * 
	 */	
	
	public class AbstractMenuItemViewController extends ProxyOwner implements IMenuOptionViewController, IProxyResponseHandler, IProxyBinding
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 * the menu items we're using  
		 */		
		
		protected var _usedMenuItems:Vector.<ICloveDataMenuOption>;
		protected var _currentData:ShowMenuOptionViewData;
		
		/**
		 * the menu items we can use for the view controller. Note, these get pushed to the _usedMenuItems
		 * on showMenu(...)
		 */		
		
		protected var _availableMenuItems:Vector.<String>;
		
		
		/**
		 * menu items we're actually using
		 */
		
		protected var _allocatedMenuItems:Object;
		
		
		private var _initialized:Boolean;
		
		
		/**
		 */
		
		private var _children:Vector.<IMenuOptionViewController>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractMenuItemViewController()
		{
			_availableMenuItems = new Vector.<String>();
			_allocatedMenuItems = {};
			this._usedMenuItems = new Vector.<ICloveDataMenuOption>();
			this._children = new Vector.<IMenuOptionViewController>();
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
				case CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_FLOAT: return this.showMenu(c.getData());
				case CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SET_ITEMS: return this.setMenuItems(c.getData());
				case CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_REMOVE_ITEMS: return this.removeMenuItems();
				case CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_REMOVE_ITEMS: return this.removeMenuItems();
				case CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_IN_NATIVE_MENU: return this.showMenuUnder(c.getData());
				case CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_GET_ITEMS: return this.respond(c,this.getMenuItems(c.getData()));
			}
			
			super.answerProxyCall(c);
		}
		
		/**
		 */
		
		public function showMenuUnder(parent:* = null):void
		{
			
			//this.getMenuItems(null);
			
			
		}
		
		/**
		 * shows a menu item 
		 * @param data
		 * 
		 */		
		
		public function showMenu(data:ShowMenuOptionViewData):void
		{
			if(!_initialized)
			{
				this._initialized = true;
				this.setupAvailableMenuItems();
//				this.useAllMenuItems();
			}
			
			this.getMenuItems(data.getData());
			
			
			
			this.notifyChange(CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_FLOAT,data);
			this._currentData = data;
		}
		
		
		/**
		 */
		
		public function getMenuItems(data:*):Vector.<ICloveDataMenuOption>
		{  
			
			
			this._usedMenuItems = new Vector.<ICloveDataMenuOption>();
			
			
			this.setDataOptionsToUse(data);   
			
			
			
			for each(var child:IMenuOptionViewController in this._children)
			{
				this._usedMenuItems = ProxyCallUtils.getFirstResponse(CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_GET_ITEMS,child.getProxy(),data).concat(this._usedMenuItems);
			}
			
			
			return this._usedMenuItems;
		}
		
		/**
		 */
		
		public function setMenuItems(value:Vector.<ICloveDataMenuOption>):void
		{
			this._usedMenuItems = value;
		}
		
		
		
		/**
		 */
		
//		public function addAvailableMenuItem(value:ICloveDataMenuOption):void
//		{
//			this._availableMenuItems[value.getName()] = value;
//		}
		
		/**
		 */
		
//		public function addAvailableMenuItems(value:Array):void
//		{
//			for each(var menuItem:ICloveDataMenuOption in value)
//			{
//				this.addAvailableMenuItem(menuItem);
//			}
//		}
		
		/**
		 */
		
		public function addChildMenuItemViewController(value:AbstractMenuItemViewController):void
		{
			if(_children.indexOf(value) > -1 || !value)
				return;
			
			_children.push(value);
		}
		
		/**
		 */
		
		public function setAvailableMenuItems(value:Array):void
		{
			this._availableMenuItems = new Vector.<String>();
			
			for each(var menuItem:String in value)
			{
				this._availableMenuItems.push(menuItem);	
			}
		}
		
		/**
		 */
		
		public function useMenuItems(value:Array):void
		{
			for each(var name:String in value)
			{
				var menuItem:ICloveDataMenuOption = this.getMenuItem(name);//this._availableMenuItems[name];
				
				if(!menuItem)
					continue;
				
				this._usedMenuItems.push(menuItem);	
			}
		}
		
		
		/**
		 */
		
		public function useAllMenuItems():void
		{
			
			for each(var menuItem:String in this._availableMenuItems)
			{
				this._usedMenuItems.push(this.getMenuItem(menuItem));
			}
		}
		
		
		
		/**
		 */
		
		public function removeMenuItems():void
		{
			_usedMenuItems = undefined;
		}
		
		
		/**
		 */
		
		public function removeAvailableMenuItems():void
		{
			this._availableMenuItems = new Vector.<String>();
		}
		
		/**
		 */
		
		public function handleProxyResponse(n:INotification):void
		{
			//abstract
		}
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			this.handleProxyResponse(n);
		}
//		/**
//		 * hides the target menu item
//		 */
//		
//		public function hideMenu():void
//		{
//			
//		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function setDataOptionsToUse(data:Object):void
		{
			//abstract
		}
		
		/**
		 */
		
		protected function getMenuItem(name:String):ICloveDataMenuOption
		{
			switch(name)
			{
				case MenuItemType.SEPARATOR: return new CloveDataMenuOption(null,true);
				default:
					if(!this._allocatedMenuItems[name])
						this._allocatedMenuItems[name] = this.createMenuItem(name);
			}
			
			return this._allocatedMenuItems[name];
		}
		
		/**
		 */
		
		protected function addMenuItem(value:ICloveDataMenuOption):void
		{
			this._allocatedMenuItems[value.getName()] = value;
		}
		/**
		 */
		
		protected function createMenuItem(name:String):ICloveDataMenuOption
		{
			return new CloveDataMenuOption(new ProxyResponseObserver(name,this));//abstract
		}
		/**
		 */
		
		protected function setupAvailableMenuItems():void
		{
			//abstract
		}
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_FLOAT,
									CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SET_ITEMS,
									CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_REMOVE_ITEMS,
									CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_IN_NATIVE_MENU,
									CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_GET_ITEMS]);
		}
		
		
		
		
	}
}