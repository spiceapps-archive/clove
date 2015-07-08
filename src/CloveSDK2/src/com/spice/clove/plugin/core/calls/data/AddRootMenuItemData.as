package com.spice.clove.plugin.core.calls.data
{
	import com.spice.clove.plugin.core.views.menu.IMenuOptionViewController;

	public class AddRootMenuItemData
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		private var _menu:*;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AddRootMenuItemData(name:String,menu:*)
		{
			this._name = name;
			this._menu = menu;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getName():String
		{
			return this._name;
		}
		
		/**
		 */
		
		public function getMenuOptionViewController():*
		{
			return this._menu;
		}
	}
}