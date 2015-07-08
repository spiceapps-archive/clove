package com.spice.clove.plugin.column.pref
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	[DefaultProperty("formItems")]
	
	public class ColumnPreferences extends EventDispatcher implements IColumnPreferences
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _data:Object;
		private var _formItems:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ColumnPreferences()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		[Bindable(event="formItemsChange")]
		public function get formItems():Array
		{
			return this._formItems;
		}
		
		/**
		 */
		
		public function set formItems(value:Array):void
		{
			this._formItems = value;
			
			this.dispatchEvent(new Event("formItemsChange"));
		}
		
		/**
		 */
		
		[Bindable(event="dataChange")]
		public function get data():Object
		{
			return this._data;
		}
		
		/**
		 */
		
		public function set data(value:Object):void
		{
			this._data = value;
			
			this.dispatchEvent(new Event("dataChange"));
		}
		
	}
}