package com.spice.clove.plugin.core.installer
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallClovePluginInstallerType;
	import com.spice.clove.plugin.core.installer.settings.CloveInstallerPluginSettings;
	import com.spice.clove.plugin.core.installer.views.install.ServiceInstallationController;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.install.IAvailableService;
	import com.spice.core.calls.CallQueueType;
	import com.spice.utils.SystemUtil;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	
	public class CloveStartupInstallerPlugin extends CloveInstallerPlugin 
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _settings:CloveInstallerPluginSettings;
		private var _installationBinding:ProxyCall;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveStartupInstallerPlugin(factory:CloveInstallerPluginFactory)
		{
			super(factory);
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		
		/**
		 */
		
		override protected function install():void
		{
			//nw.
			
			ProxyCallUtils.quickCall(CallAppCommandType.GET_DEFAULT_PLUGINS,this.getPluginMediator(),null,this);
			
			
//			var nw:NativeWindow = NativeApplication.nativeApplication.openedWindows[0];
//			nw.visible = false;
//			Application.application.visible = false;
			
		}
		
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
//			NativeApplication.nativeApplication.openedWindows[0].visible = true;
//			Application.application.visible = true;
		}
		
		
		
		
	}
}