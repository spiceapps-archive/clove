package com.spice.clove.plugin.impl.views.install
{
	import com.spice.clove.plugin.core.calls.CallClovePluginInstallerViewControllerType;
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.install.IClovePluginInstallerViewController;
	import com.spice.clove.plugin.impl.views.RegisteredViewController;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	public class RegisteredPluginInstallerViewController extends RegisteredViewController implements IProxyResponder, IClovePluginInstallerViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _pluginInstaller:IClovePluginInstaller;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RegisteredPluginInstallerViewController(name:String,
																mediator:IProxy,
																pluginInstaller:IClovePluginInstaller,
																callData:Object = null)
		{
			super(name,mediator,callData);
			
			_pluginInstaller = pluginInstaller;
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
			IClovePluginInstallerViewController(this._target).setView(target);
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
			super.setTargetViewController(view);
			
			ProxyCallUtils.quickCall(CallClovePluginInstallerViewControllerType.SET_PLUGIN_INSTALLER,view.getProxy(),this._pluginInstaller);
		}
	}
}