package com.spice.clove.plugin.growl.impl
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.content.data.CloveData;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.NativeProcessExitEvent;
	import flash.filesystem.File;

	public class CloveGrowlPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		public static const MAX_NOTIFICATIONS:Number = 5;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveGrowlPlugin(factory:ClovePluginFactory)
		{
			super("Growl Plugin",new ClovePluginSettings(new BasicSettingFactory()),factory);
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
						trace(e.getStackTrace());
					} //for now, don't bug me about errors when debugging
				break;
			}
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
			
			new ProxyCall(CallAppCommandType.DATA_PROCESSED,this.getPluginMediator(),null,null,this).dispatch();
			
			
			this.finishInitialization();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
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
			
			
			var file:File = File.applicationStorageDirectory.resolvePath("growlnotify");
			
			
			trace(file.nativePath);
			
			 
			if(!_processInfo)
			{
				_processInfo = new NativeProcessStartupInfo();
				 _processArgs = new Vector.<String>();
				_processInfo.executable = file;
				_processInfo.arguments = _processArgs;
				_process = new NativeProcess();
				_process.addEventListener(NativeProcessExitEvent.EXIT,onExit);
			}
			
			_i = 0;
			
			var cd:CloveData = _inQueue[_i];
			this.showGrowlNotification("",cd.title,cd.message);
			
			
			
		}
		
		
		/**
		 */
		
		private function showGrowlNotification(iconPath:*,title:String,message:String):void
		{
				
			_processArgs[0] = "-n";
			_processArgs[1] = "Clove";
			_processArgs[2] = "-p";
			_processArgs[3] = "0";
			_processArgs[4] = "-t";
			_processArgs[5] = title;
			_processArgs[6] = "-m";
			_processArgs[7] = message;
			_processArgs[8] = "-a";
			_processArgs[9] = "Clove";
			
			
			_process.start(_processInfo);
		}
		
		
		/**
		 */
		
		private function onExit(event:NativeProcessExitEvent):void
		{
			
			_i++;
			
			if(_i > _inQueue.length || _i > MAX_NOTIFICATIONS)
			{
				_inQueue = null;
				return;
			}
			
			if(_i == MAX_NOTIFICATIONS)
			{
				showGrowlNotification("","Clove",(_inQueue.length-_i)+" more items");
				_inQueue = null;
				return;
			}
			
			if(_i < _inQueue.length)
			{
				var cd:CloveData = _inQueue[_i];
				this.showGrowlNotification("",cd.title,cd.message);
				return;
			}
			
			_inQueue = null;
		}
		
	}
}