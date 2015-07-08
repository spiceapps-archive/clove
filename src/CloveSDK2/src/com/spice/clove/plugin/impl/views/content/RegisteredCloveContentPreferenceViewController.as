package com.spice.clove.plugin.impl.views.content
{
	import com.spice.clove.plugin.core.calls.CallCloveContentPreferenceControlType;
	import com.spice.clove.plugin.core.calls.CallCloveSearchControllerType;
	import com.spice.clove.plugin.core.calls.CallCloveSearchPreferenceViewController;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.views.content.ICloveContentPreferenceViewController;
	import com.spice.clove.plugin.core.views.install.IClovePluginInstallerViewController;
	import com.spice.clove.plugin.impl.views.RegisteredViewController;
	import com.spice.clove.plugin.impl.views.content.filter.RegisteredFilterViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	public class RegisteredCloveContentPreferenceViewController extends RegisteredViewController implements ICloveContentPreferenceViewController, 
																		   IProxyResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _contentController:ICloveContentController;
		private var _filterViewCOntroller:RegisteredFilterViewController;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RegisteredCloveContentPreferenceViewController(name:String,
																	   contentController:ICloveContentController,
																	   filterViewController:RegisteredFilterViewController,
																	   mediator:IProxy)
		{
			_contentController = contentController;
			_filterViewCOntroller = filterViewController;
			super(name,mediator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getTarget():ICloveContentController
		{
			return this._contentController;
		}
		
		/**
		 */
		
		public function setTarget(value:ICloveContentController):void
		{
			this._contentController = value;
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setTargetViewController(view:IProxyOwner):void
		{
			
			var target:ICloveContentPreferenceViewController = ICloveContentPreferenceViewController(view);
			
			if(this._filterViewCOntroller)
			{
				ProxyCallUtils.quickCall(CallCloveSearchPreferenceViewController.SET_FILTER_LIST_VIEW_CONTROLLER,view.getProxy(),this._filterViewCOntroller);
			}
			target.setTarget(this._contentController);
			
//			ProxyCallUtils.quickCall(CallCloveContentPreferenceControlType.SET_TARGET,view.getProxy(),_contentController);
		}
		
	}
}