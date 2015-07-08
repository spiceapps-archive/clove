package com.spice.clove.core.storage
{
	import com.spice.clove.core.factory.ClovePluginSettingsFactory;
	import com.spice.clove.model.CloveInternalProxyMediator;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	import com.spice.clove.plugin.load.PluginInstallationManager;
	import com.spice.clove.plugin.settings.IPluginSettingsFactory;
	import com.spice.clove.proxy.calls.CallCloveInternalType;
	import com.spice.model.Singleton;
	import com.spice.utils.storage.ChildSettings;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.ISettings;
	import com.spice.utils.storage.SharedObjectSettings;
	import com.spice.utils.storage.TempSettings;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import mx.utils.Base64Encoder;
	
	
	
	
	/*
	  all of the settings stored by Clove 
	  @author craigcondon
	  
	 */	
	
	[Bindable] 
	public class CloveSettings extends Singleton
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const ALERT_SETTINGS:String		 = "alertSettings";
        public static const NOTIFICATION_SETTINGS:String = "notificationSettings";
        
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _pluginManager:PluginInstallationManager;
		private var _tempSettings:Object;
		private var _mainUISettings:MainUISettings;
		
		//UI settings can be variable across windows
		
		private var _settings:INotifiableSettings;
		private var _uiSettings:Dictionary;
		private var _core:ApplicationSettings;
		private var _name:String;
		private var _initialized:Boolean;
		private static var _instance:CloveSettings;
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		
        public var modelSettings:ChildSettings;
        
        
        private static var _check:Boolean;
        
        [Setting]
        public var uid:String;
        
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CloveSettings(name:String,
									  settings:INotifiableSettings = null,
									  settingsFactory:IPluginSettingsFactory = null)
		{
			this._name = name;
			
			_settings		    = settings ? settings : new SharedObjectSettings(name);
//			this._pluginManager = new PluginInstallationManager(new ChildSettings(this._settings,"pluginManager"),settingsFactory ? settingsFactory : new ClovePluginSettingsFactory(this._settings));
			this._pluginManager = new PluginInstallationManager(new ChildSettings(this._settings,"pluginManager"),settingsFactory);
			
			this.uid = this.uid == null ? this.getUID() : this.uid;
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		public function get initialized():Boolean
		{
			return this._initialized;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        
		
		
		/*
		  returns temp setting for runtime
		 */
		
		public function getTemporarySettings(id:String):ISettings
		{
			return new TempSettings(_tempSettings,id);
		}
		
		
		/*
		 */
		
		public static function getInstance(name:String = "Clove"):CloveSettings
		{
			
			if(!_instance)
			{
				_instance = ProxyCallUtils.getFirstResponse(CallCloveInternalType.GET_CLOVE_SETTINGS,CloveInternalProxyMediator.getInstance());
			}
			
			if(!_instance.initialized)
			{
				_instance.initialize();
			}
			return _instance;
		}
		
	
			
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
       
        
        /*
		 */
		
		[Bindable] 
		public function get core():ApplicationSettings
		{
			return _core;
		}
		
        /*
		 */
		
		public function get pluginManager():PluginInstallationManager
		{
			return this._pluginManager;
		}
		
		
		
		/*
		 */
		
		public function get mainUISettings():MainUISettings
		{
			return this._mainUISettings;
		}
		
		
		/*
		  since scolumns can be popped out of their window, and their properties
		  can be changed, we set the UI props to the CURRENT WINDOW
		 */
		
		public function getUiSettings(displayObject:DisplayObject):UISettings
		{	
			
			
			return _uiSettings[displayObject.root];
		}
		
		/*
		  percaution used for windows so that only registered roots can use the UI
		 */
		
		public function registerUIManager(root:DisplayObject,name:String):void
		{
			_uiSettings[root.root] = new UISettings(this._settings,name);
		}
		
		/*
		 */
		
		public function saveFavorites(data:Object):void
		{
			this._settings.saveSetting("favorites",data);
		}
		
		/*
		 */
		
		public function getFavorites():Object
		{
			return this._settings.getSetting("favorites");	
		}
		
		/*
		 */
		
		public function minimizeColumn(data:Array):void
		{
			this._settings.saveSetting("minimizedColumns",data);
		}
		
		/*
		 */
		
		public function getMinimzedColumns():Array
		{
			return this._settings.getSetting("minimizedColumns") as Array;
		}
		
		/*
		 */
		 
		public function setPopupWindows(windows:Object):void
		{
			this._settings.saveSetting("popupWindows",windows);
		}
		/*
		 */
		
		public function getPopupWindows():Object
		{
			return this._settings.getSetting("popupWindows") as Object;
		}
		
		/*
		 */
		public function uninstallPlugin(id:String):void
		{	
			this._pluginManager.uninstall(id);
		}
		
		
		/*
		 */
		
		public function uninstallFactory(installed:IInstalledPluginFactoryInfo):void
		{
			this._pluginManager.uninstallFactory(installed);
		}
		
		
		/*
		 */
		
		public function initialize():void
		{
			this._initialized = true;
			
			_uiSettings = new Dictionary(true);
			
			this.modelSettings = new ChildSettings(_settings,"modelSettings");
			
			_core = new ApplicationSettings(this._settings);
			_tempSettings = new Object();
			
			_mainUISettings = new MainUISettings(this._settings);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		
		
		/*
		  UID given to the user computer
		 */
		 
		private function getUID():String
		{
			//FIXME: this UID should be taken from the MySQL database
			var uid:String = new Date().getTime().toString()+Math.random()*9999999999;
			
			var b64:Base64Encoder = new Base64Encoder();
			b64.encode(uid);
			
			
			return b64.drain();
		}
		
		
	}
}