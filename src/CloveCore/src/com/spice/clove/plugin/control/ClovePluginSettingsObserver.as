package com.spice.clove.plugin.control
{
	import com.spice.utils.externalizable.XMLExternalizer;
	import com.spice.utils.storage.ISettings;
	import com.spice.vanilla.core.notifications.SettingChangeNotification;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.observer.IObserver;
	import com.spice.vanilla.core.plugin.settings.IPluginSettings;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.ByteArraySetting;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.core.Application;

	public class ClovePluginSettingsObserver implements IObserver, IDisposable
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _cloveSettings:ISettingTable;
		private var _pluginSettings:IPluginSettings;
		private var _settingBytes:ByteArraySetting;
		private var _notificationsOfInterest:Vector.<String>;
		
		private var _saveTimeout:int;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ClovePluginSettingsObserver(settings:IPluginSettings,cloveSettings:ISettingTable)
		{
			
			_pluginSettings = settings;
			_cloveSettings = cloveSettings;
			
			
			_settingBytes = ByteArraySetting(_cloveSettings.getNewSetting(BasicSettingType.BYTE_ARRAY,"settings"));
			this._settingBytes.clearOnReadWrite = true;
			
			if(_settingBytes.getData())
			{
				_pluginSettings.readExternal(_settingBytes.getData());
				_settingBytes.getData().clear();//clear from memory
			}
			
			this._notificationsOfInterest = new Vector.<String>;
			this._notificationsOfInterest[0] = SettingChangeNotification.CHANGE;
			
			settings.addObserver(this);
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getNotificationsOfInterest():Vector.<String>
		{
			return this._notificationsOfInterest;
		}
		
		/**
		 */
		
		public function dispose():void
		{
			this._pluginSettings.removeObserver(this);
		}
		
		/**
		 */
		
		public function notifyObserver(n:INotification):void
		{
			
			flash.utils.clearTimeout(_saveTimeout);
			_saveTimeout = flash.utils.setTimeout(saveSettings,7000);
			
		}
		
		
		/**
		 */
		
		private function onClosing(event:*):void
		{
			event.currentTarget.removeEventListener(event.type,onClosing);
			this.saveSettings();
		}
		
		/**
		 */
		
		public function saveSettings():void
		{
			this._saveTimeout = -1;
			
			
			var bytes:ByteArray = new ByteArray();
			_pluginSettings.writeExternal(bytes);
			this._settingBytes.setData(bytes);
			bytes = null;
			
			
			
		}
	}
}