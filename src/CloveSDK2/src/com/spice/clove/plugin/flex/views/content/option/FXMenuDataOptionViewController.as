package com.spice.clove.plugin.flex.views.content.option
{
	import com.spice.clove.plugin.core.calls.CallCloveDataMenuOptionType;
	import com.spice.clove.plugin.core.calls.CallMenuOptionViewController;
	import com.spice.clove.plugin.core.content.control.option.menu.ICloveDataMenuOption;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.views.menu.IMenuOptionButtonViewController;
	import com.spice.clove.plugin.desktop.views.menu.AIRMenuViewController;
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.clove.plugin.impl.icons.utility.UtilityIcons;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.icon.ToolIcons;
	import com.spice.monkeyPatch.menu.Menu;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.display.DisplayObject;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.utils.Proxy;
	
	import mx.controls.Image;
	import mx.core.IDataRenderer;
	
	public class FXMenuDataOptionViewController extends CloveDataViewController implements IMenuOptionButtonViewController 
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _menu:NativeMenu;
		private var _currentData:Object;
		private var _icon:*;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FXMenuDataOptionViewController()
		{
			super(FlexDataOptionView);
			  
			_icon = UtilityIcons.ACTION_ICON;
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
				case CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_FLOAT: return this.notifyChange(c.getType(),c.getData());
			}
			
			super.answerProxyCall(c);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override protected function setupNewView(content:Object, view:IDataRenderer):void
		{
			
			super.setupNewView(content,view);
			
			FlexDataOptionView(view).source = _icon;
		}
		
		
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallMenuOptionViewController.MENU_OPTION_VIEW_CONTROLLER_SHOW_FLOAT]);
		}
		
		
		/**
		 */
		
//		override protected function setIcon(value:Object):void
//		{
//			super.setIcon(value);
//			
//			_icon = value;
//		}
		
		
	}
}