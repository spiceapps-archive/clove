package com.spice.clove.plugin.impl.views.content.filter
{
	import com.spice.clove.plugin.core.calls.CallFilterListViewControllerType;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import flash.geom.Rectangle;

	public class RegisteredFilterViewController extends ProxyOwner implements ICloveDataViewController, 
																			  IFilterViewController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _viewController:RegisteredCloveDataViewController;
		private var _list:Vector.<IFilterableData>;
		private var _filterStr:String;
		private var _target:IFilterViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RegisteredFilterViewController(mediator:IProxy,list:Array = null)
		{
			this._viewController = new RegisteredCloveDataViewController(CallRegisteredViewType.GET_REGISTERED_DEFAULT_FILTER_VIEW_CONTROLLER,mediator);
			this._viewController.getProxy().bindObserver(new CallbackObserver(CallFilterListViewControllerType.FILTERED_ITEM_SELECTED,onFilterItemSelected));
			
			_target = IFilterViewController(this._viewController.getTargetViewController());
			
			this.setFilterableList(list || []);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setContentView(content:Object,viewTarget:ICloveViewTarget):void
		{
			this._viewController.setContentView(content,viewTarget);
		}
		
		
		
		public function open(position:Rectangle):void
		{
			this._target.open(position);
			
			this.notifyChange(CallFilterListViewControllerType.SHOW_FILTER_LIST_VIEW);
		}
				
		public function close():void
		{
			this._target.close();	
		}
		
		public function setFocus():void
		{
			this._target.setFocus();
		}
		
		/**
		 */
		
		public function useItemAt(index:int):void
		{
			this._target.useItemAt(index);
		}
		
		/**
		 */
		
		public function getFilteredList():Array
		{
			return this._target.getFilteredList();
		}
		
		public function setFilterableList(value:Array):void
		{
			this._target.setFilterableList(value);
		}
		
		public function getFilter():String
		{
			return this._target.getFilter();
		}
		
		public function setFilter(value:String):void
		{
			this._target.setFilter(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		private function onFilterItemSelected(n:INotification):void
		{
			this.notifyChange(n.getType(),n.getData());
		}
		
		
		
	}
}