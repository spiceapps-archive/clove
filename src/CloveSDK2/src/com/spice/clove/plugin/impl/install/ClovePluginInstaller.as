package com.spice.clove.plugin.impl.install
{
	import com.spice.clove.plugin.core.calls.CallClovePluginInstallerType;
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.core.views.ICloveViewController;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.clove.plugin.impl.views.install.RegisteredPluginInstallerViewController;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import flash.display.DisplayObject;

	public class ClovePluginInstaller extends ProxyOwner implements IClovePluginInstaller
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _installerView:DisplayObject;
		private var _viewController:ICloveViewController;
		private var _plugin:IPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ClovePluginInstaller(plugin:IPlugin,viewController:ICloveViewController)
		{
			super();  
			
			_viewController = viewController;
			_plugin = plugin;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallClovePluginInstallerType.GET_ICON:return this.respond(call,this.getIcon());
				case CallClovePluginInstallerType.IS_FINISHED:return this.respond(call,this.isFinished());
				case CallClovePluginInstallerType.GET_INSTALLER_VIEW_CONTROLLER: return this.respond(call,_viewController);
			}
		}
		
		/**
		 */
		
		public function initialize():void
		{
			
		}
		
		
		/**
		 */
		
		public function getPlugin():IPlugin
		{
			return _plugin;
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
			
			this.addAvailableCalls([CallClovePluginInstallerType.PLUGIN_INSTALLED,
									CallClovePluginInstallerType.GET_ICON,
									CallClovePluginInstallerType.IS_FINISHED,
									CallClovePluginInstallerType.GET_INSTALLER_VIEW_CONTROLLER]);
			
		}
		
		
		/**
		 */
		
		protected function isFinished():Boolean
		{
			//throw an alert here is we're not ready
			return true;
		}
		
		/**
		 */
		
		protected function getIcon():*
		{
			return null;
		}
		
		/**
		 */
		
		protected function pluginInstalled(plugin:IPlugin):void
		{
			//abstract
		}
		
		
		/**
		 */
		
		/*final protected function getInstallerView():DisplayObject
		{
			if(!_installerView)
			{
				_installerView = createInstallerView();
			}
			return _installerView;
		}*/
		
		
		/**
		 * tell the installer we're ready to move on to the next item
		 */
		
		protected function notifyCompletion():void
		{
			this.notifyChange(CallClovePluginInstallerType.IS_FINISHED,true);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
			
	}
}