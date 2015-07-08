package com.spice.clove.plugin.core.installer
{
	import com.spice.clove.installer.core.calls.CallCloveInstallerType;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallClovePluginInstallerType;
	import com.spice.clove.plugin.core.installer.settings.CloveInstallerPluginSettings;
	import com.spice.clove.plugin.core.installer.views.install.InstallCloveWindow;
	import com.spice.clove.plugin.core.installer.views.install.ServiceInstallationController;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.install.IAvailableService;
	import com.spice.core.calls.CallQueueType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class CloveInstallerPlugin extends ClovePlugin 
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
		
		public function CloveInstallerPlugin(factory:CloveInstallerPluginFactory)
		{
			super("Installer","com.spice.clove.plugin.core.installer",(_settings = new CloveInstallerPluginSettings()),factory);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		
		public function getPluginSettings():CloveInstallerPluginSettings
		{
			return this._settings;
		}
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallClovePluginInstallerType.OPEN_PLUGIN_INSTALLER_WITH_AVAILABLE: return this.openPluginInstaller(call.getData());
			}
			super.answerProxyCall(call);
		}
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallAppCommandType.GET_DEFAULT_PLUGINS: return this.startupInstaller(n.getData());
			}
			
			super.handleProxyResponse(n);
		}
		
		
		/**
		 */
		
		public function openPluginInstaller(plugins:Vector.<IAvailableService>):void
		{
			var plugs:ArrayCollection = new ArrayCollection();
			
			for each(var plugin:IAvailableService in plugins)
			{
				plugs.addItem(plugin);
			}
			
			this.startupInstaller(plugs,true);  
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override protected function installed():void
		{
			this.finishInitialization();
			
			
			if(this._settings.getShowHelloScreenOnStartup().getData())
			{
				var controller:ServiceInstallationController = new ServiceInstallationController(this);
				controller.openInstaller(new ArrayCollection(),false,true);
			}
		}
		
		/**
		 */
		
		override protected function  install():void
		{
			this.finishInitialization();
			
		}
		
		
		
		
		/**
		 */
		
		protected function startupInstaller(plugins:ArrayCollection,skipHello:Boolean = false):void
		{
				var controller:ServiceInstallationController = new ServiceInstallationController(this);
				controller.additionalViews.source = ProxyCallUtils.getResponse(CallCloveInstallerType.GET_INSTALLATION_VIEW,this.getPluginMediator());
				controller.addEventListener(Event.COMPLETE,onInstallationComplete);
				
				var window:InstallCloveWindow = controller.openInstaller(plugins,skipHello);
				
				if(!skipHello)
				{
					window.addEventListener(Event.CLOSING,onInstallerClosing);
				}
				
				
				
				
		}
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallClovePluginInstallerType.OPEN_PLUGIN_INSTALLER_WITH_AVAILABLE]);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onInstallerClosing(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onInstallerClosing);
			
			if(!InstallCloveWindow(event.currentTarget).controller.completed)
			{
				this.startupInstaller(InstallCloveWindow(event.currentTarget).controller.manager.availableVisiblePlugins);
			}
		}
		/**
		 */
		
		
		private function onInstallationComplete(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onInstallationComplete);
			
			
			
			
			if(!this.initialized())
			{
				this.finishInitialization();
			}
		}
	}
}