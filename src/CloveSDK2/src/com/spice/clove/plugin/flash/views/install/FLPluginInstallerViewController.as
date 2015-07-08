package com.spice.clove.plugin.flash.views.install
{
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.install.IClovePluginInstallerViewController;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import flash.display.DisplayObject;
	
	import mx.core.IDataRenderer;

	public class FLPluginInstallerViewController extends ProxyOwner implements IClovePluginInstallerViewController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _pool:ObjectPoolManager;
		private var _viewClass:Class;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FLPluginInstallerViewController(viewClass:Class)
		{
			_viewClass = viewClass;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setView(target:ICloveViewTarget):void
		{
			if(!_pool)
			{
				_pool = ObjectPoolManager.getInstance();
			}
			
			
			var view:DisplayObject = _pool.getObject(_viewClass);
			
			if(view is IDataRenderer)
			{
				IDataRenderer(view).data = this;
			}
			
			
			target.setView(view);
			
			
		}
	}
}