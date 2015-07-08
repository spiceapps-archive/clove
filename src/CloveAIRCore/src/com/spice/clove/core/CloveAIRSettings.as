package com.spice.clove.core
{
	import com.spice.air.utils.storage.AIRSettings;
	import com.spice.air.utils.storage.cache.FileCache;
	import com.spice.clove.core.factory.CloveSettingsFactory;
	import com.spice.clove.core.storage.CloveSettings;
	import com.spice.clove.plugin.load.PluginInstallationManager;
	import com.spice.utils.storage.persistent.SettingManager;
	
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	
	import mx.utils.Base64Encoder;
	
	
	
	
	/*
	  all of the settings stored by Clove 
	  @author craigcondon
	  
	 */	
	public class CloveAIRSettings extends CloveSettings
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
		private var _cache:FileCache;
		
		//UI settings can be variable across windows
		
		private var _settings:AIRSettings;
		private var _uiSettings:Dictionary;
		private var _dirMgr:DirSettings;
		private var _name:String;
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		
		private static var _check:Boolean;
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		
		public function CloveAIRSettings(name:String = "Clove")
		{
			
			
			this._name = name;
			
			
			
			
			try
			{
				var mgr:AIRSettings = new AIRSettings("DirMgr");
			
				this._dirMgr = new DirSettings(mgr);
				
				
				
				
				new SettingManager(mgr,this);
				
				
				Logger.log("Loading up storage from "+this.storagePath,this);
				
				
				super(name,new AIRSettings(name,this.storagePath),new CloveSettingsFactory());
				
			}catch(e:Error)
			{
				Logger.logError(e);
			}
			
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		
		
		
		/*
		 */
		
		public static function getInstance(name:String = "Clove"):CloveAIRSettings
		{
			return CloveAIRSettings(CloveSettings.getInstance(name));
		}
		
		
		/*
		 */
		
		public function setNewSettingsDir():void
		{
			var dir:String = this.storagePath == File.separator+"Library"+File.separator ? File.separator+"Library2"+File.separator : File.separator+"Library"+File.separator;
			
			Logger.log("Resetting dir to "+dir,this);
			
			
			//deleted the next time the app loads
			this._dirMgr.deleteDir = this.storagePath;
			
			
			//set the new directory
			this.storagePath = dir;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		
		
		/*
		 */
		
		public function get fullStoragePath():String
		{
			return File.applicationStorageDirectory.nativePath+storagePath;
		}
		
		
		/*
		 */
		
		public function set storagePath(value:String):void
		{
			this._dirMgr.appStorageDir = value;
		}
		/*
		 */
		
		public function get storagePath():String
		{
			return this._dirMgr.appStorageDir;
		}
		
		/*
		 */
		
		public function get fullPluginSettingsPath():String
		{
			return File.applicationStorageDirectory.nativePath + this.pluginSettingsPath;
		}
		
		/*
		 */
		
		public function get fullPluginAssetsPath():String
		{
			return File.applicationStorageDirectory.nativePath + this.pluginAssetsPath;
		}
		
		/*
		 */
		
		public function get pluginSettingsPath():String
		{
			return this.storagePath + File.separator+"PluginSupport"+File.separator+"settings"+File.separator;
		}
		
		/*
		 */
		
		public function get pluginAssetsPath():String
		{
			return this.storagePath + File.separator+"PluginSupport"+File.separator+"assets"+File.separator;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function initialize():void
		{
			super.initialize();
			
			
			
			//there are two directories that can be used, and sometimes it's used for synchronizing data
			//or restarting theapplication. the delete dir is the old settings used, which should be deleted
			//so we don't consume too much space
			if(this._dirMgr.deleteDir)
			{
				try
				{
					var f:File = new File(File.applicationStorageDirectory.nativePath+this._dirMgr.deleteDir);
					f.deleteDirectory(true);
					this._dirMgr.deleteDir = null;
				}catch(e:Error)
				{
					Logger.logError(e);
				}
				
			}
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