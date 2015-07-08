package com.spice.clove.plugin.core.sceneSync.impl
{
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	public class SceneSyncBackupHelper
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:SceneSyncPlugin;
		private var _fr:FileReference;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncBackupHelper(plugin:SceneSyncPlugin)
		{
			this._plugin = plugin;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function openBackup():void
		{
			
			this._fr = new FileReference();
			this._fr.addEventListener(Event.COMPLETE,onFRComplete);
			this._fr.addEventListener(Event.SELECT,onFRSelect);
//			this._fr.addEventListener(Event.OPEN,onFROpen);
			this._fr.browse([new FileFilter("Clove Backup","*.cloveBackup")]);
		}
		
		/**
		 */
		
		public function saveBackup():void
		{
			var ba:ByteArray = new ByteArray();
			this._plugin.getSyncHelper().packSceneSync(ba);
			
			
			this._fr = new FileReference();
			this._fr.save(ba,new Date().toDateString()+".cloveBackup");
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		private function onFRSelect(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onFRComplete);
			
			this._fr.load();
		}
		
		/**
		 */
		
		private function onFRComplete(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onFRComplete);
			
			this._plugin.getSyncHelper().readSceneFromServer(this._fr.data,this._plugin.getCurrentScene().id);
			
			
			this._plugin.readyToSendNewData();
		}
	}
}