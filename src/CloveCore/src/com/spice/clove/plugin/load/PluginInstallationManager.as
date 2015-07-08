package com.spice.clove.plugin.load
{
	import com.spice.clove.plugin.control.ClovePluginController;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.control.cue.LoadFactoryCue;
	import com.spice.clove.plugin.control.cue.LoadPluginCue;
	import com.spice.clove.plugin.core.calls.CallClovePluginControllerType;
	import com.spice.clove.plugin.settings.IPluginSettingsFactory;
	import com.spice.commands.init.InitCommand;
	import com.spice.events.QueueManagerEvent;
	import com.spice.utils.queue.QueueManager;
	import com.spice.utils.queue.cue.ICue;
	import com.spice.utils.queue.global.GlobalQueueManager;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.persistent.SettingManager;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.handle.CallbackProxyResponseHandler;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	
	/*
	  CORE class not available within the plugin SDK since it may change in the future.  
	  @author craigcondon
	  
	 */	
	 
	[Event(name="pluginsInitialized",type="com.spice.clove.events.plugin.PluginManagerEvent")]
	
	public class PluginInstallationManager extends EventDispatcher 
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		
		/*
		  theplugin manager settings 
		 */		
		 
		private var _settings:Settings;
		
		/*
		  the plugins loaded and are being used 
		 */		
		 
		private var _loadedPlugins:ArrayCollection = new ArrayCollection();
		
		
		
		/*
		  TRUE if loadded = called 
		 */		
		private var _loaded:Boolean;
		
		
		/*
		  connection between plugins
		 */		
		 
		private var _mediator:ClovePluginMediator;
		
		
		/*
		 */
		
		private var _settingsFactory:IPluginSettingsFactory;
		
		
		/*
		 */
		
		private var _loadQueue:QueueManager = GlobalQueueManager.getInstance().getQueueManager(InitCommand.INIT_QUEUE);
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function PluginInstallationManager(settings:INotifiableSettings,settingsFactory:IPluginSettingsFactory)
		{
			
			_settings = new Settings();
			
			_mediator =  ClovePluginMediator.getInstance();
			
			new SettingManager(settings,_settings);
			
			
			_settingsFactory = settingsFactory;
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		
		/*
		 */
		
		public function get settingsFactory():IPluginSettingsFactory
		{
			return this._settingsFactory;
		}
		
		/*
		  the plugin savailable for installation
		 */		
		
		public function get availablePlugins():ArrayCollection
		{
			if(!_settings.availablePlugins)
				_settings.availablePlugins = new ArrayCollection();
			
			return _settings.availablePlugins;
		}
		
		/*
		  the plugins installed
		 */		
		
		public function get installedPlugins():ArrayCollection
		{
			if(!_settings.installedPlugins)
				_settings.installedPlugins = new ArrayCollection();
			
			return _settings.installedPlugins;
		}
		
		/*
		  the plugins loaded and are beingused
		 */		
		
		public function get loadedPlugins():ArrayCollection
		{
			return _loadedPlugins;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/*
		  adds a plugin to the available list, installed, and loads is
		 */        
		
		public function installPluginFactory(info:IInstalledPluginFactoryInfo,loadedPlugin:IPlugin = null):void
		{
			var found:Boolean;
			
			for each(var ap:IInstalledPluginFactoryInfo in this.availablePlugins.source)
			{
				if(ap.factoryClass == info.factoryClass)
					found = true;
			}
			
			if(!found)
				this.availablePlugins.addItem(info);
			
			
			this.addUsedPlugin(new InstalledPluginInfo(info.factoryClass,loadedPlugin));
		}
		
		/*
		 */
		
		public function addUsedPlugin(plugin:InstalledPluginInfo):void
		{
			for each(var ap:InstalledPluginInfo in this.installedPlugins.source)
			{
				if(ap.factoryClass == plugin.factoryClass)
					return;
			}
			
			this.installedPlugins.addItem(plugin);

			this.loadPlugin(plugin).init();
		}
		
		public function loadCorePlugin(info:InternalInstalledPluginFactoryInfo):ICue
		{
			var inf:InstalledPluginInfo = new InstalledPluginInfo(info.factoryClass);
			inf.installedPluginFactoryInfo = info;
			return this.loadPlugin(inf);
			
		}
		
		/*
		 */
		
		private function loadPlugin(plugin:InstalledPluginInfo):ICue
		{	
			
			for each(var fact:IInstalledPluginFactoryInfo in this.availablePlugins.source)
			{
				if(plugin.factoryClass == fact.factoryClass)
				{
					plugin.installedPluginFactoryInfo = fact;
					break;
				}
			}
			
			
			return new LoadPluginCue(plugin,fact,_mediator,_loadedPlugins,_settingsFactory);
			
		}
		
		
		/*
		 */
		
		public function uninstall(uid:String):void
		{
			new ProxyCall(CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_UID,ClovePluginMediator.getInstance(),uid,new CallbackProxyResponseHandler(uninstallPlugin,uid)).dispatch();
		}
		
		private function uninstallPlugin(n:INotification,uid:String):void
		{
			var plugin:ClovePluginController = n.getData();
			
			
			var index:int = this.loadedPlugins.getItemIndex(plugin);
			
			this.loadedPlugins.removeItemAt(index);
			
			var i:int = 0;
			
			for each(var plug:InstalledPluginInfo in this.installedPlugins.source)
			{
				if(plug.factoryClass == uid)
				{
					this.installedPlugins.removeItemAt(i);
					break;
				}
				
				i++;
			}
			
			
			plugin.uninstall();
		}
		
		
		/*
		 */
		
		public function uninstallFactory(factory:IInstalledPluginFactoryInfo):void
		{
			
			factory.uninstall();
			
			//remove the factory
			var linIndex:int = this.availablePlugins.getItemIndex(factory);
			this.availablePlugins.removeItemAt(linIndex);
			
			//find all associated plugins
			
			var plugin:ClovePluginController;
			
			
			for(var i:int = 0; i < this._loadedPlugins.length; i++)
			{
				plugin = ClovePluginController(this._loadedPlugins.getItemAt(i));
				
				if(factory.loadedPluginFactory is plugin.pluginFactoryClass)
				{
					this.uninstall(plugin.uid);
					
					i--;
				}
			}
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /*
		 */
		
		public function loadPlugins():void
		{
			//some items may be waiting for a complete event before continueing, so send it
			if(_loaded)
			{
				return;
			}
			
			_loaded = true;
			
			for each(var fact:IInstalledPluginFactoryInfo in this.availablePlugins.source)
			{
				this._loadQueue.addCue(new LoadFactoryCue(fact));
			}
			
			for each(var plug:InstalledPluginInfo in this.installedPlugins.source)
			{
				
				
				this._loadQueue.addCue(this.loadPlugin(plug));
				
				
				
			}
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
		
        
        /*
		 */
		
		private function onCueComplete(event:QueueManagerEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onCueComplete);
			
		}
		
		
		/**
		 */
		
		private function getPluginCount(factory:String):Number
		{
			var count:int;
			for each(var plugin:InstalledPluginInfo in this.installedPlugins.source)
			{
				if(plugin.factoryClass == factory)
				{
					count++;
				}
			}
			
			return count;
		}
		

	}
}
	import mx.collections.ArrayCollection;
	

	class Settings
	{
		[Bindable] 
		[Setting]
		public var availablePlugins:ArrayCollection = new ArrayCollection();
		
		
		[Bindable] 
		[Setting]
		public var installedPlugins:ArrayCollection = new ArrayCollection();
	}