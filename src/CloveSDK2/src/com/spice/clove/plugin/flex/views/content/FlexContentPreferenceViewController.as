package com.spice.clove.plugin.flex.views.content
{
	import com.spice.clove.plugin.core.calls.CallCloveContentPreferenceControlType;
	import com.spice.clove.plugin.core.calls.CallCloveSearchControllerType;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.views.content.ICloveContentPreferenceViewController;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import mx.containers.FormItem;
	import mx.controls.Alert;

	public class FlexContentPreferenceViewController extends ProxyOwner implements ICloveContentPreferenceViewController, IProxyResponder
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _view:FlexContentPreferenceView;
		private var _target:ICloveContentController;
		private var _pool:ObjectPoolManager;
		private var _viewClass:Class;
		private var _availableCalls:Vector.<String>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FlexContentPreferenceViewController(target:ICloveContentController,viewClass:Class)
		{
			_target = target;
			_viewClass = viewClass;
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
				case CallCloveContentPreferenceControlType.GET_PREFERENCE_ITEM_VIEWS: return this.respond(c,this.getFormItemViews());
				case CallCloveContentPreferenceControlType.REMOVE_PREFERENCE_VIEW: return this.removeFormItemViews();
				case CallCloveContentPreferenceControlType.GET_TARGET: return this.respond(c,this.getTarget());
				case CallCloveContentPreferenceControlType.SET_TARGET: return this.setTarget(c.getData());
			}
			
		}
		
		/**
		 */
		
		public function getTarget():ICloveContentController
		{
			return this._target;
		}
		
		/**
		 */
		
		public function setTarget(value:ICloveContentController):void
		{
			this._target = value;
			
			
			this.notifyChange(CallCloveContentPreferenceControlType.GET_TARGET,value);
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
			
			this.addAvailableCalls([CallCloveContentPreferenceControlType.REMOVE_PREFERENCE_VIEW,
									CallCloveContentPreferenceControlType.GET_PREFERENCE_ITEM_VIEWS,
									CallCloveContentPreferenceControlType.SET_TARGET,
									CallCloveContentPreferenceControlType.GET_TARGET]);
		}
		
		/**
		 */
		
		final protected function getFormItemViews():Vector.<FormItem>
		{
			if(!_view)
			{
				_view = this.initializeView();
				
			}
			_view.data = this;
			
			return _view.formItems;
		}
		
		/**
		 */
		
		protected function removeFormItemViews():void
		{
			if(!_view)
				return;
			
			
			getObjectPool().addObject(this._view);
			
			
			this._view = null;
		}
		
		/**
		 */
		
		protected function getObjectPool():ObjectPoolManager
		{
			if(!_pool)
			{
				_pool = ObjectPoolManager.getInstance();
			}
			
			return _pool;
		}
		
		/**
		 * initialize the views here.  
		 * @return 
		 * 
		 */		
		
		protected function initializeView():FlexContentPreferenceView
		{
			return getObjectPool().getObject(_viewClass);
		}
	}
}