package com.spice.clove.plugin.control
{
	import com.spice.air.utils.storage.*;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.calls.CallDesktopPluginControllerType;
	import com.spice.clove.plugin.load.InstalledPluginInfo;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.vanilla.core.plugin.settings.IPluginSettings;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.desktop.settings.FileSettingTable;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.filesystem.File;

	public class AIRClovePluginController extends ClovePluginController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _settings:FileSettingTable;
		private var _settingsDir:File;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AIRClovePluginController(plugin:InstalledPluginInfo,settings:ISettingTable)
		{
			super(plugin,settings);
			
			_settings = FileSettingTable(settings);
			
			
			//listen for on application closing so we can notify the app
			NativeApplication.nativeApplication.addEventListener(Event.CLOSING,onApplicationClosing,false,0,true);
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
				case CallDesktopPluginControllerType.GET_SETTINGS_DIRECTORY:
					
					//create the new dir
					if(!this._settingsDir)
					{
						_settingsDir = new File(this._settings.directory.nativePath+"/misc/");
						
						if(!_settingsDir.exists) 
							_settingsDir.createDirectory();
					}
					//create another sub-directory for the settings so any custom files saved do not overwrite
					//any necessary files
					this.respond(call,this._settingsDir);
				return;
			}
			
			super.answerProxyCall(call);
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
			
			
			this.addAvailableCalls([CallDesktopPluginControllerType.GET_SETTINGS_DIRECTORY]);
		}
		
		
		/**
		 */
		
		
		override protected function setPluginSettings(value:IPluginSettings):void
		{
			this._settings.target = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		private function onApplicationClosing(event:Event):void
		{
			new ProxyCall(CallClovePluginType.APPLICATION_CLOSING,this.plugin.getProxy()).dispatch();
			
			if(_pluginSettingsObserver)
			{
				_pluginSettingsObserver.saveSettings();
			}
			
		}
		
	}
}