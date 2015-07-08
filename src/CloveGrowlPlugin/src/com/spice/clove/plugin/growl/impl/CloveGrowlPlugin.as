package com.spice.clove.plugin.growl.impl
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallClovePluginControllerType;
	import com.spice.clove.plugin.core.calls.CallDesktopPluginControllerType;
	import com.spice.clove.plugin.core.calls.data.ToasterNotificationData;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.utils.EmbedUtil;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyCallObserver;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.NativeProcessExitEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class CloveGrowlPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		public static const MAX_NOTIFICATIONS:Number = 5;
		private var _settingsDir:File;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveGrowlPlugin(factory:ClovePluginFactory)
		{
			super("Growl Plugin","com.spice.clove.growl",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallAppCommandType.DATA_PROCESSED:
					try
					{
						this.notifyGrowl(n.getData());
					}catch(e:Error)
					{
						Logger.logError(e);
					} //for now, don't bug me about errors when debugging
				return;
				
				
					
			}
			
			super.notifyProxyBinding(n);
		}
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallAppCommandType.DISPATCH_TOASTER_NOTIFICATION:
					try  
					{
						this.sendToasterNotification(call.getData());
					}catch(e:Error)
					{
						Logger.logError(e);
					}
				return;
			}
			
			super.answerProxyCall(call);
		}
		
		
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				
				case CallDesktopPluginControllerType.GET_SETTINGS_DIRECTORY:
					this._settingsDir = n.getData();
				return;
			}
			
			super.handleProxyResponse(n);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			
			
			new ProxyCall(CallDesktopPluginControllerType.GET_SETTINGS_DIRECTORY,this.getPluginController().getProxy(),null,this).dispatch().dispose();
			
			
			new ProxyCall(CallAppCommandType.DATA_PROCESSED,this.getPluginMediator(),null,null,this).dispatch();
			
			
			this.finishInitialization();
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallAppCommandType.DISPATCH_TOASTER_NOTIFICATION]);
		}
		
		
		private var _inQueue:Array;
		private var _i:int;
		private var _process:NativeProcess;
		private var _processInfo:NativeProcessStartupInfo;
		private var _processArgs:Vector.<String>;
		/**
		 */
		
		protected function notifyGrowl(data:Array):void
		{
			if(_inQueue)
				return;
			
			_inQueue = data;
			
			
			
			
			 this.setupGrowl();
			
			_i = 0;
			
			var cd:ICloveData = _inQueue[_i];
			this.showGrowlNotification(cd.getTitle(),cd.getMessage());
			
			
			
		}
		
		
		
		/**
		 */
		protected function sendToasterNotification(value:ToasterNotificationData):void
		{
			var tmp:File;
			
			if(value.icon && value.icon is Class)
			{
				tmp = new File(this._settingsDir.nativePath+"/toasterIcon.png");
				
				var fs:FileStream = new FileStream();
				fs.open(tmp,FileMode.WRITE);
				fs.writeBytes(EmbedUtil.toImageByteArray(value.icon));
				fs.close();
				
				
			}
			
			this.setupGrowl();
			
			this.showGrowlNotification(value.title,value.message,tmp ? tmp.nativePath : null);
			
		}
		
		
		
		/**
		 */
		
		private function setupGrowl():void
		{
			
			if(!_processInfo)
			{
				var file:File = File.applicationStorageDirectory.resolvePath("growlnotify");
				
			
				_processInfo = new NativeProcessStartupInfo();
				_processArgs = new Vector.<String>();
				_processInfo.executable = file;
				_processInfo.arguments = _processArgs;
				_process = new NativeProcess();
				_process.addEventListener(NativeProcessExitEvent.EXIT,onExit);
			}
		}
		
		
		
		
		/**
		 */
		
		private function showGrowlNotification(title:String,message:String,iconPath:* = null):void
		{
				
			//_processArgs[0] = "-n";
			//_processArgs[1] = "Clove";
			//_processArgs[2] = "-p";
			//_processArgs[3] = "0";
			_processArgs[0] = "-t";
			_processArgs[1] = title;
			_processArgs[2] = "-m";
			_processArgs[3] = message;
			
			if(iconPath)
			{
				_processArgs[4] = "--image";
				_processArgs[5] = iconPath;
			}
			else
			{
				
				_processArgs[4] = "-a";
				_processArgs[5] = "Clove";
			}
			
			
			_process.start(_processInfo);
		}
		
		
		/**
		 */
		
		private function onExit(event:NativeProcessExitEvent):void
		{
			
			_i++;
			
			if(!_inQueue || _i > _inQueue.length || _i > MAX_NOTIFICATIONS)
			{
				_inQueue = null;
				return;
			}
			
			if(_i == MAX_NOTIFICATIONS)
			{
				showGrowlNotification("Clove",(_inQueue.length-_i)+" more items");
				_inQueue = null;
				return;
			}
			
			if(_i < _inQueue.length)
			{
				var cd:ICloveData = _inQueue[_i];
				this.showGrowlNotification(cd.getTitle(),cd.getMessage());
				return;
			}
			
			_inQueue = null;
		}
		
	}
}