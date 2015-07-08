package com.spice.clove.plugin.core.sceneSync.impl.service.settings
{
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.clove.sceneSync.core.service.data.ScreenData;
	import com.spice.clove.sceneSync.core.service.data.SyncData;
	import com.spice.clove.sceneSync.core.service.settings.CloveServiceSettingType;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.persistent.SettingManager;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	import com.spice.vanilla.impl.settings.child.ChildSettingTable;
	import com.spice.vanilla.impl.settings.list.StringListSetting;
	
	import flash.display.Scene;
	import flash.display.Screen;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	import org.papervision3d.scenes.Scene3D;
	
	[Bindable]	
	public class CloveServiceSettings extends SettingTable
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _screen:ScreenData;
		private var _currentScene:SceneData;
		private var _syncs:SyncListSetting;
		private var _username:StringSetting;
		private var _password:StringSetting;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		public function CloveServiceSettings(username:String = null,password:String = null)
		{
			super(CloveServiceSettingsFactory.getInstance());
			
			this._screen 	   = this.getNewSetting(CloveServiceSettingType.SCREEN_DATA,"screen") as  ScreenData;
			this._currentScene = this.getNewSetting(CloveServiceSettingType.SCENE_DATA,"currentScene") as SceneData;
			this._syncs 	   = this.getNewSetting(CloveServiceSettingType.SYNC_LIST,"syncs") as SyncListSetting;
			this._username     = this.getNewSetting(BasicSettingType.STRING,"username") as StringSetting;
			this._password     = this.getNewSetting(BasicSettingType.STRING,"password") as StringSetting;
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getUsername():StringSetting
		{
			return this._username;
		}
		
		/**
		 */
		
		public function getPassword():StringSetting
		{
			return this._password;
		}
		/**
		 */
		
		public function getSyncList():SyncListSetting
		{
			return this._syncs;
		}
		
		/**
		 */
		
		public function getScreen():ScreenData
		{
			return this._screen;
		}
		
		/**
		 */
		
		public function setScreen(value:ScreenData):void
		{
			var ba:ByteArray = new ByteArray();
			value.writeExternal(ba);
			ba.position= 0;
			
			this._screen.readExternal(ba);
			ba.clear();
			ba = null;
		}
		
		/**
		 */
		
		public function getCurrentScene():SceneData
		{
			return this._currentScene;
		}  
		
		/**
		 */
		
		public function setCurrentScene(value:SceneData):void
		{
			
			var ba:ByteArray = new ByteArray();
			value.writeExternal(ba);
			ba.position = 0;
			this._currentScene.readExternal(ba);
			ba.clear();
			ba = null;
		}
		/**
		 */
		  
//		public function getCurrentScene():ScreenDataSetting
//		{
//			return this._screen;
//		}
		/*
		*/
		
		public function setCredentials(username:String,password:String):void
		{
			this._username.setData(username);
			this._password.setData(password);
		}
		
		
	}
}