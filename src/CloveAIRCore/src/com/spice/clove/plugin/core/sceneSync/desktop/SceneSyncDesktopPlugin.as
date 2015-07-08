package com.spice.clove.plugin.core.sceneSync.desktop
{
	import com.spice.air.utils.FileUtil;
	import com.spice.clove.plugin.core.calls.CallDesktopPluginControllerType;
	import com.spice.clove.plugin.core.sceneSync.flex.FXSceneSyncPlugin;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.ObjectEncoding;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class SceneSyncDesktopPlugin extends FXSceneSyncPlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		private var _historyDirectory:File;
		private var _currentBackupDate:Date;
		private var _currentBackups:Array;
		
		public static const NUM_BACKUPS_TO_KEEP:int = 50;
		public static const NUM_CURRENT_BACKUPS_TO_KEEP:int = 10;
		public static const BACKUP_TIMEOUT:int = 1000*60*5;//5 minutes after ready
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncDesktopPlugin(factory:SceneSyncDesktopPluginFactory)
		{
			super(factory);
			this._currentBackups = [];
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				
				case CallDesktopPluginControllerType.GET_SETTINGS_DIRECTORY:
					
					this._historyDirectory = FileUtil.resolvePath(n.getData(),File.separator+"backup"+File.separator);
					
					return;
					
			}
			super.handleProxyResponse(n);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		
		private var _backupTimeout:int;
		
		/**
		 */
		
		override public function readyToSendNewData():void
		{
			super.readyToSendNewData();
			
			flash.utils.clearTimeout(this._backupTimeout);
			_backupTimeout = flash.utils.setTimeout(backupCurrentScene,BACKUP_TIMEOUT)
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		
		
		/**
		/**
		 */
		
		override protected function readLatestBackup():Boolean
		{
			
			if(!this._currentBackupDate)
				this._currentBackupDate = new Date();
			
			var files:Array = this.getCurrentSceneSyncBackupDirectory().getDirectoryListing().sort(sortBackupsByDateNewestFirst);
			
			
			Logger.log("loading backup length="+files.length,this);
			
			for each(var backup:File in files)
			{
				
				if(backup.name == ".DS_Store")
					continue;
				
				Logger.log("current backup time ="+backup.creationDate,this);
				
				//delete any backups that aren't working. The first backup is the item
				//that's been loaded up on startup
				if(backup.creationDate.time >= this._currentBackupDate.time)
				{
					
					Logger.log("deleting backup time = "+backup.creationDate,this);
					backup.deleteFile();
				}
				else
				{
					
					Logger.log("loading backup  ="+backup.creationDate,this);
					this._currentBackupDate = backup.creationDate;
					
					var stream:FileStream = new FileStream();
					
					stream.open(backup,FileMode.READ);
					
					
					try
					{
						this._helper.readSceneFromServer(stream,this.getCurrentScene().id);
					}catch(e:Error)
					{
						backup.deleteFile();//delete the backup if it doesn't work
						Logger.logError(e);
						continue;
					}
					
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 */
		
		private function sortBackupsByDateNewestFirst(a:File,b:File):int
		{
			return a.creationDate.time == b.creationDate.time ? 0 : (a.creationDate.time < b.creationDate.time ? 1 : -1);
		}
		
		/**
		 */
		
		protected function getCurrentSceneSyncBackupDirectory():File
		{
			
			
			var currentScene:String = this.getAccounts().length > 0 ? this.getSceneSyncAccount().getCurrentScene().id.toString() : this.getCurrentScene().id.toString();
			
			
			return FileUtil.resolvePath(this._historyDirectory,currentScene);
		}
		
		
		/**
		 */
		
		
		/**
		 */
		
		
		/**
		 */
		
		override protected function  initialize():void
		{
			
			ProxyCallUtils.quickCall(CallDesktopPluginControllerType.GET_SETTINGS_DIRECTORY,this.getPluginController().getProxy(),null,this)
			
			
			super.initialize();
		}
		
		private var _backedUp:Boolean;
		/**
		 */
		
		override protected function applicationClosing():void
		{
			super.applicationClosing();
			
			if(_backedUp)
				return;
			
			
			this._backedUp = true;
			
			
			//on close, backup the current scene
			this.backupCurrentScene();
			this.removeOldBackups();
		}
		
		
		
		
		/**
		 */
		
		protected function backupCurrentScene():void
		{
			
			//if the apps been open for a LONG time, then we need to remove any current backups
			this.removeCurrentBackups();
			
			var backupName:String = new Date().time+".cloveBackup";
			
			var file:File = new File(this.getCurrentSceneSyncBackupDirectory().nativePath+File.separator+backupName)
			
			var stream:FileStream = new FileStream();
			stream.open(file,FileMode.WRITE);    
			this._helper.packSceneSync(stream);
			
			stream.close();
			this._currentBackupDate = file.creationDate;
			
			this._currentBackups.unshift(file);
		}
		
		
		/**
		 */
		
		protected function removeCurrentBackups():void
		{
			this.removeBackups(this._currentBackups,NUM_CURRENT_BACKUPS_TO_KEEP);
		}
		
		
		/**
		 */
		
		protected function removeOldBackups():void
		{
			//set the current backup date
			
			var files:Array = FileUtil.getAllDirectoryListings(this._historyDirectory).sort(this.sortBackupsByDateNewestFirst);
			
			
			this.removeBackups(files,NUM_BACKUPS_TO_KEEP);
		}
		
		
		/**
		 */
		
		protected function removeBackups(files:Array,n:int):void
		{
			//delete everything but the last 5 backups
			for(var i:int = files.length-1; i > n; i--)
			{
				var file:File = files.pop();
				
				Logger.log("deleting file creation date="+file.creationDate,this);
				//delete the old file
				file.deleteFile();
			}
		}
		
	}
}