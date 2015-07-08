package com.spice.vanilla.desktop.settings
{
	import com.spice.vanilla.core.notifications.SettingChangeNotification;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.observer.IObserver;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.observer.Notifier;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class FileSettingTable extends Notifier implements ISettingTable, IObserver
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 * name of the settings 
		 */		
		private var _name:String;
		  
		/**
		 * directory of the settings 
		 */		
		private var _directory:String;
		
		/**
		 * extension of the file settings 
		 */		
		private var _extension:String;
		
		
		/**
		 * timeout for saving the file so we don't write a bunch of times in one thread
		 */		
		private var _saveInterval:int;
		
		/**
		 * the write stream 
		 */		
		
		private var _stream:FileStream;
		
		
		/**
		 */
		
		private var _target:ISettingTable;
		
		/**
		 */
		
		private var _noi:Vector.<String>;
		
		/**
		 * the file handle 
		 */		
		
		private var _file:File;
		
		
		private static const SAVE_DELAY:int = 500;//1 second after change is made
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FileSettingTable(name:String,
										 directory:String,
										 extension:String = ".vls")
		{
			_name 	   = name;
			_directory = directory;
			_extension = extension;
			
			this._noi = new Vector.<String>(1,true);
			this._noi[0] = SettingChangeNotification.CHANGE;
			
			
			_file = resolvePath(File.applicationStorageDirectory,_directory);
			_file = _file.resolvePath(name+_extension);
			
			_stream = new FileStream();
			
			
			
			NativeApplication.nativeApplication.addEventListener(Event.EXITING,onApplicationExiting);
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get target():ISettingTable
		{
			return this._target;
		}
		
		/**
		 */
		
		public function set target(value:ISettingTable):void
		{
			if(this._target)
			{
				this._target.removeObserver(this);
			}
			
			
			this._target = value;
			
			if(_file.exists)
			{
				var fs:FileStream = new FileStream();
				fs.open(_file,FileMode.READ);
				
				
				this.readExternal(fs);
				
				fs.close();
			}
			
			
			value.addObserver(this);
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
			return this._noi;
		}
		
		/**
		 */
		
		public function getAvailableSettings():Vector.<int>
		{
			return this._target.getAvailableSettings();
		}
		
		/**
		 */
		
		public function getNewSetting(type:int,name:String):ISetting
		{
			return this._target.getNewSetting(type,name);
		}
		
		/**
		 */
		
		public function getSetting(name:String):ISetting
		{
			return this._target.getSetting(name);
		}
		
		/**
		 */
		
		public function removeAllSettings():Boolean
		{
			return this._target.removeAllSettings();
		}
		
		/**
		 */
		
		public function removeSetting(name:String):ISetting
		{
			return this._target.removeSetting(name);
		}
		
		/**
		 */
		
		public function readExternal(input:IDataInput):void
		{
			this._target.readExternal(input);
		}
		
		/**
		 */
		
		public function writeExternal(output:IDataOutput):void
		{
			this._target.writeExternal(output);
		}
		/**
		 */
		
		public function get directory():File
		{
			return this._file.parent;
		}
		/**
		 */
		
		public function notifyObserver(n:INotification):void
		{
			
			this.saveData();
			
			this.notifyObservers(n);
		}
		
		/**
		 */
		
		private function onApplicationExiting(event:Event):void
		{
			this.waitForSave();
		}
		
		/**
		 */
		
		private function saveData():void
		{
			
			//to avoid needless processing, we save the app a few seconds after
			//data has been saved	
			flash.utils.clearTimeout(this._saveInterval);
			
			this._saveInterval = flash.utils.setTimeout(waitForSave,SAVE_DELAY);
			
			  
			
			
		}
		
		/**
		 */
		
		private function waitForSave():void
		{
			
			_stream.open(_file,FileMode.WRITE);
			this.writeExternal(_stream);
			_stream.close();
			
			
			
			
			
		}
		
		
		/**
		 */
		
		public static function resolvePath(dir:File,path:String):File
		{  
			
			//for some reason, windows adds a line break to the app setting data, so remove them
			path = path.split("\n").join("").split("\r").join("");
			
			var dirs:Array = path.split(/[\\\/]+/);
			
			var cdir:File = dir;
			
			
			for(var i:int = 0; i < dirs.length; i++)
			{
				cdir = cdir.resolvePath(dirs[i]);
				
				if(i == dirs.length -1 && cdir.name.indexOf(".") > -1)
				{
					break;
				}
				
				
				if(!cdir.exists)
				{
					try
					{
						cdir.createDirectory();
					}catch(e:Error)
					{
					}
				}
			}
			
			return cdir;
			
			
		}
		
	}
}