package com.spice.clove.plugin.core.installer.views.install
{
	import com.spice.clove.plugin.core.installer.CloveInstallerPlugin;
	import com.spice.clove.plugin.core.installer.views.install.services.ServiceInstallationManager;
	import com.spice.core.calls.CallQueueType;
	import com.spice.impl.queue.Queue;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	
	import mx.collections.ArrayCollection;
	

	public class ServiceInstallationController extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const HELLO_VIEW:int 		       = 0;
		public static const SELECT_PLUGINS_VIEW:int    = 1;
		public static const INSTALL_PLUGINS_VIEW:int   = 2;
		public static const INSTALL_ADDITIONAL_VIEW:int = 3;
		
		[Bindable] 
		public var installationStep:int;
		
		[Bindable] 
		public var title:String;
		
		public var completed:Boolean;
		
		public var additionalViews:ArrayCollection = new ArrayCollection();
		
		public var skipHello:Boolean;
		public var showOnlyHello:Boolean;
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _manager:ServiceInstallationManager;
		private var _view:InstallCloveWindow;
		private var _plugin:CloveInstallerPlugin;
		private var _installationBind:ProxyCall;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		
		public function ServiceInstallationController(plugin:CloveInstallerPlugin)
		{
			_plugin = plugin;
		}  
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get plugin():CloveInstallerPlugin
		{
			return this._plugin;
		}
		
		/**
		 */
		
		public function get manager():ServiceInstallationManager
		{
			return this._manager;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function openInstaller(availablePlugins:ArrayCollection,skipHello:Boolean = false,showOnlyHello:Boolean = false):InstallCloveWindow
		{
			_view = new InstallCloveWindow();
			    
			
			
			if(!_manager)
			{
				_manager = new ServiceInstallationManager();
				_manager.addEventListener(Event.COMPLETE,onComplete,false,0,true);
			}
			
			this.skipHello = skipHello;
			this.showOnlyHello = showOnlyHello;
			
			_manager.init(availablePlugins);
			
			this.installationStep = skipHello ? SELECT_PLUGINS_VIEW : HELLO_VIEW;
			
			_view.onlyPlugins = skipHello;
			_view.controller = this;
			_view.open();
			
			return _view;
		}
		
		
		/**
		 */
		
		public function selectPlugins():void
		{
			if(_manager.availableVisiblePlugins.length > 0)
			{
				this.installationStep = SELECT_PLUGINS_VIEW;
			}
			else
			if(!this.skipHello && this.additionalViews.length > 0)
			{
				this.installationStep = INSTALL_ADDITIONAL_VIEW;
			}
			else
			{
				this.complete();
			}
		}
		
		/*
		 */
		
		public function complete():void
		{
			this.completed = true;
			
			_manager.install();
			
			if(_view)
				_view.close();
		}
		
		/**
		 */
		
		private function onComplete(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onComplete);
			
			this.dispatchEvent(event.clone());
		}
	}
}