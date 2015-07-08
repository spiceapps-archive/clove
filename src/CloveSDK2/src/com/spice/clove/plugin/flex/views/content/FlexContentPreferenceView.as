package com.spice.clove.plugin.flex.views.content
{
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.core.IDataRenderer;
	
	[DefaultProperty("formItems")]
	
	public class FlexContentPreferenceView extends EventDispatcher implements IDataRenderer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _data:Object;
		private var _formItems:Vector.<FormItem>;
		private var _children:Array = [];
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
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
		
		
		/**
		 */
		
		[Bindable(event="formItemsChange")]
		public function get formItems():Vector.<FormItem>
		{
			return this._formItems;	
		}
		
		
		/**
		 */
		
		public function set formItems(value:Vector.<FormItem>):void
		{
			this._formItems = value;
			
			this.dispatchEvent(new Event("formItemsChange"));
		}
		
		/**
		 */
		
		public function get children():Array
		{
			return this._children;
		}
		
		/**
		 */
		
		public function set children(value:Array):void
		{
			this._children = value;
			
			this._formItems = new Vector.<FormItem>(value.length,true);
			
			for(var i:int = 0; i < value.length; i++)
			{
				this._formItems[i] = value[i];
			}
			
			this.dispatchEvent(new Event("formItemsChange"));
			//this.dispatchEvent(new Event("childrenChange"));
		}
		
		/**
		 */
		
	}
}