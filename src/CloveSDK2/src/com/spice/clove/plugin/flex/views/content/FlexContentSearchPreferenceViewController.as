package com.spice.clove.plugin.flex.views.content
{
	import com.spice.clove.plugin.core.calls.CallCloveSearchControllerType;
	import com.spice.clove.plugin.core.calls.CallCloveSearchPreferenceViewController;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.ICloveContentControllerFactory;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import mx.controls.Alert;

	public class FlexContentSearchPreferenceViewController extends FlexContentPreferenceViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _filterListViewController:ICloveDataViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FlexContentSearchPreferenceViewController(target:ICloveContentController)
		{
			super(target,FlexSearchContentPreferenceView);
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
				case CallCloveSearchPreferenceViewController.GET_FILTER_VIEW_CONTROLLER: return this.respond(c,this._filterListViewController);
				case CallCloveSearchPreferenceViewController.SET_FILTER_LIST_VIEW_CONTROLLER: return this.setFilterListViewController(c.getData());
			}
			
			super.answerProxyCall(c);
		}
		
		
		/**
		 */
		
		public function setFilterListViewController(value:ICloveDataViewController):void
		{
			this._filterListViewController = value;
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
			
			this.addAvailableCalls([CallCloveSearchPreferenceViewController.GET_FILTER_VIEW_CONTROLLER,
				CallCloveSearchPreferenceViewController.SET_FILTER_LIST_VIEW_CONTROLLER]);
		}
	}
}