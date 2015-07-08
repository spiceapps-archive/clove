package com.spice.clove.plugin.impl.views.content.filter
{
	public class FilterableData implements IFilterableData
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		private var _icon:*;
		private var _data:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FilterableData(name:String,icon:*,data:Object = null)
		{
			this._data = data;
			this._name = name;
			this._icon = icon;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
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
		
		public function getIcon():*
		{
			return this._icon;
		}
		
		/**
		 */
		
		public function getData():*
		{
			return this._data;
		}
	}
}