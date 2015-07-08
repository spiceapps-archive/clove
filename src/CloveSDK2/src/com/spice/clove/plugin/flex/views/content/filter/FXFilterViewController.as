package com.spice.clove.plugin.flex.views.content.filter
{
	import com.spice.clove.plugin.core.calls.CallFilterListViewControllerType;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.clove.plugin.impl.views.content.filter.IFilterViewController;
	import com.spice.clove.plugin.impl.views.content.filter.IFilterableData;
	import com.spice.vanilla.core.proxy.IProxyCall;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;

	public class FXFilterViewController extends CloveDataViewController implements IFilterViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _filterList:FilterPopup;
		private var _filter:String;
		private var _dataProvider:ArrayCollection;
		private var _filteredDataProvider:ArrayCollection;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FXFilterViewController()
		{
			super( FilterPopup);
			this._dataProvider = new ArrayCollection();
			this._filteredDataProvider = new ArrayCollection();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		
		
		public function open(position:Rectangle):void
		{
			if(!_filterList)
			{
				_filterList = FilterPopup.displayAtPosition(position);
				this._filterList.dataProvider = _filteredDataProvider;
				_filterList.addEventListener(Event.COMPLETE,onComplete,false,0,true);
			}
		}
		
		public function close():void
		{
			if(this._filterList)
			{
				this._filterList.close();
			}
			this._filterList = null;
		}
		
		public function setFocus():void
		{
			this._filterList.setFocus();
		}
		
		public function getFilteredList():Array
		{
			return this._filteredDataProvider.source;
		}
		
		public function useItemAt(index:int):void
		{
			this.notifyChange(CallFilterListViewControllerType.FILTERED_ITEM_SELECTED,this._filteredDataProvider.getItemAt(index));
			this.close();
		}
		
		public function setFilterableList(value:Array):void
		{
			this._dataProvider = new ArrayCollection();
			
			for each(var data:IFilterableData in value)
			{
				_dataProvider.addItem(data);	
			}
			
			
			_filteredDataProvider.source = this._dataProvider.source;
			
		}
		
		public function getFilter():String
		{
			return this._filter;
		}
		
		public function setFilter(value:String):void
		{
			this._filter = value;
			
			
			if(this._dataProvider)
			{
				this._filteredDataProvider.source = this._dataProvider.source.filter(this.filterList);
			}
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function filterList(item:IFilterableData,index:int,stack:Array = null):Boolean
		{  
			return item.getName().toLowerCase().indexOf(_filter) > -1;
		}
		
		/**
		 */
		
		private function onComplete(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onComplete);
			
			this.notifyChange(CallFilterListViewControllerType.FILTERED_ITEM_SELECTED,this._filterList.selectedItem);
			this.close();
		}
		
	}
}