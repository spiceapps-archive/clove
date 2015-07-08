package com.spice.clove.plugin.control.cue
{
	import com.spice.clove.events.plugin.PluginControllerEvent;
	import com.spice.clove.model.CloveInternalProxyMediator;
	import com.spice.clove.plugin.control.ClovePluginController;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	import com.spice.clove.plugin.load.InstalledPluginInfo;
	import com.spice.clove.plugin.settings.IPluginSettingsFactory;
	import com.spice.clove.proxy.calls.CallCloveInternalType;
	import com.spice.display.controls.list.ImpatientCue;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import mx.collections.ArrayCollection;
	
	
	/*
	  loads the plugin into the app. NOTE: sometimes the plugin may throw an exception, so we have the cue as an impatient cue. after 4 seconds the cue will complete regardless
	  if the plugin has loaded or not 
	  @author craigcondon
	  
	 */	
	public class LoadPluginCue extends ImpatientCue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _plugin:InstalledPluginInfo;
		private var _loadedPlugins:ArrayCollection;
		private var _mediator:ClovePluginMediator;
		private var _controller:ClovePluginController;
		private var _factory:IPluginSettingsFactory;
		private var _pluginSettings:ISettingTable;
		private var _lip:IInstalledPluginFactoryInfo;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const MAX_WAIT_TIME:int = 1000;//four seconds
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function LoadPluginCue(plugin:InstalledPluginInfo,
									  lip:IInstalledPluginFactoryInfo,
									  mediator:ClovePluginMediator,
									  loadedPlugins:ArrayCollection,
									  settingsFactory:IPluginSettingsFactory)
		{
			super(-1);//we shouldn't ever do this since it can screw up initialization of plugins
			//that NEED to wait, such as the installer
			
			
			_plugin        = plugin;
			_lip 		   = lip;
			_mediator 	   = mediator;
			_loadedPlugins = loadedPlugins;
			_factory       = settingsFactory;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override protected function init2():void
		{
			
			
			try
			{
				this._plugin.loadPlugin();
				
				
				
				//get the plugin settings
				_pluginSettings = _factory.newSettings(this._plugin);
				
				 var clazz:Class = ProxyCallUtils.getResponse(CallCloveInternalType.GET_PLUGIN_CONTROLLER_CLASS,CloveInternalProxyMediator.getInstance())[0];
				 
				_controller = new clazz(this._plugin,this._pluginSettings);
				
				_controller.addEventListener(PluginControllerEvent.PLUGIN_INITILIZED,onPluginInitialized,false,0,true);
				
			
			
				//tell the controller to initialze the plugin
				_controller.initialize();
				
				
			//usually when an error is caught here, that means there was an Illigal overwrite of class X. 
			}catch(e:Error)
			{
				Logger.logError(e,LogType.FATAL);
				//complete the load so the application can initialize (not doing so will so a blank screen)
				this.complete();
			}
			
		}
		
		/*
		  if loaded successfully, we add the item to the loadedPlugins list, then complete
		 */		
		
		private function onPluginInitialized(event:PluginControllerEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onPluginInitialized);
			
			//add the plugin controller to the plugins
			this._loadedPlugins.addItem(_controller);
			
			
			
			
			//remove the loitered objects
			_controller    = undefined;
			_mediator      = undefined;
			_loadedPlugins = undefined;
			_plugin 	   = undefined;
			
			
			//complete the cue
			this.complete();
		}
		
	}
}