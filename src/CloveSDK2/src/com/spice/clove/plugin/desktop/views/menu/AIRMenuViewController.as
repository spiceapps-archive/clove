package com.spice.clove.plugin.desktop.views.menu
{
	import com.spice.clove.plugin.core.calls.data.ShowMenuOptionViewData;
	import com.spice.clove.plugin.core.content.control.option.menu.ICloveDataMenuOption;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.views.menu.AbstractMenuItemViewController;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;

	public class AIRMenuViewController extends AbstractMenuItemViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _menu:NativeMenu;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AIRMenuViewController()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function showMenu(data:ShowMenuOptionViewData):void
		{
			super.showMenu(data);
			
			
			this.showMenuUnder(data);
		}
		
		/**
		 */
		
		override public function showMenuUnder(data:* = null):void
		{
			super.showMenuUnder(data);
			
			
			if(!_menu)
			{
				_menu = new NativeMenu();
			}
			
			if(!_usedMenuItems)
				return;
			
			_menu.removeAllItems();
			
			for each(var menuItem:ICloveDataMenuOption in this._usedMenuItems)
			{
				this.setupMenuItem(menuItem,this._menu);
				
			}  
			
			if(data is ShowMenuOptionViewData)
				_menu.display(data.getStage(),data.getX(),data.getY());
			else
				data.submenu = _menu;
			
		}
		
		/**
		 */
		
		private function setupMenuItem(menuItem:ICloveDataMenuOption,parent:NativeMenu):void
		{
			var name:String = menuItem.getName();//ProxyCallUtils.getResponse( CallCloveDataMenuOptionType.GET_NAME,menuItem.getProxy())[0];
			var isSep:Boolean = menuItem.isSeparator();//ProxyCallUtils.getResponse(CallCloveDataMenuOptionType.IS_SEPARATOR,menuItem.getProxy())[0];
			var checked:Boolean = menuItem.checked();
			
			var me:NativeMenuItem = new NativeMenuItem(name,isSep);
			me.checked = checked;
			me.data = menuItem;
			me.enabled = menuItem.enabled();
			me.addEventListener(Event.SELECT,onMenuItemSelect,false,0,true);
			
			if(menuItem.getSubMenuItems().length > 0)
			{
				me.submenu = new NativeMenu();
			}
			
			for each(var child:ICloveDataMenuOption in menuItem.getSubMenuItems())
			{
				this.setupMenuItem(child,me.submenu);
			}
			parent.addItem(me);
		}
		
		/**
		 */
		
		private function onMenuDeactivate(event:Event):void
		{
			trace("G");
		}
		/**
		 */
		
		private function onMenuItemSelect(event:Event):void
		{
			var nmi:NativeMenuItem = NativeMenuItem(event.currentTarget);
			
			var data:ICloveDataMenuOption = event.target.data;
			  
			
			//notify the meu option we've clicked the menu item
			ProxyCallUtils.quickCall(data.getName(),data.getProxy(),_currentData ? _currentData.getData() : null);
			
			
			
		}
	}
}