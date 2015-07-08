package com.spice.clove.plugin.core.sceneSync.impl
{
	import com.spice.clove.plugin.control.ClovePluginController;
	import com.spice.clove.plugin.core.IClovePlugin;
	import com.spice.clove.plugin.core.calls.CallClovePluginControllerType;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.calls.data.SceneSyncData;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveService;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncablePluginType;
	import com.spice.clove.sceneSync.core.service.data.SyncData;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.plugin.IPluginController;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;

	public class SceneSyncHelper extends EventDispatcher
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var plugin:SceneSyncPlugin;
		public static const VERSION:int = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _downloadingSyncs:Dictionary;
		private var _service:CloveService;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncHelper(plugin:SceneSyncPlugin,service:CloveService)
		{
			this.plugin = plugin;
			
			_service = service;
			this._downloadingSyncs = new Dictionary(true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		
		public function readSceneFromServer(input:IDataInput,sceneId:int,type:String = "sceneSyncReadExternal"):void
		{
			
			
			input.readInt();//version
			var n:int = input.readInt();
			
			
			for(var i:int = 0; i < n; i++)
			{
				var j:int = input.readUnsignedInt();
				
				
				var uid:String = input.readUTFBytes(j);
				
				var controllers:Array = ProxyCallUtils.getResponse(CallClovePluginControllerType.GET_PLUGIN_CONTROLLER_BY_UID,this.plugin.getPluginMediator(),uid);
				
				
				var settings:ByteArray = new ByteArray();
				
				j = input.readInt();
				
				
				if(j) input.readBytes(settings,0,j);
				
				if(controllers.length == 0)
				{
					//plugin doesn't exist, notify.
					continue;
				} 
				
				var controller:IPluginController = controllers[0];
				
				var plugin:IPlugin = ProxyCallUtils.getResponse(CallClovePluginControllerType.GET_PLUGIN,controller.getProxy())[0];
				
				if(plugin == this)
					continue;
				
				
				try
				{
					ProxyCallUtils.quickCall(type,plugin.getProxy(),new SceneSyncData(sceneId,settings));
				}catch(e:Error)
				{
					Logger.logError(e);
				}
			}
		}
		
		/**
		 */
		
		public function packSceneSync(out:IDataOutput = null):IDataOutput
		{
			var plugins:Array = ProxyCallUtils.getResponse(CallClovePluginControllerType.GET_PLUGIN,this.plugin.getPluginMediator());
			
			
			var output:IDataOutput = out || new ByteArray();
			output.writeInt(VERSION);
			
			
			
			
			output.writeUnsignedInt(plugins.length);
			
			//write the plugin info
			for each(var plugin:IClovePlugin in plugins)
			{
				output.writeUnsignedInt(plugin.getUID().length);
				output.writeUTFBytes(plugin.getUID());
				
				
				var ba:ByteArray = new ByteArray();
				
				ProxyCallUtils.quickCall(CallSceneSyncablePluginType.SCENE_SYNC_WRITE_EXTERNAL,plugin.getProxy(),ba);
				
				ba.position = 0;
				output.writeInt(ba.length);
				output.writeBytes(ba);
				
			}
			
			 
			
			return output;
		}
		
		/**
		 */
		
		public function loadSync(sync:SyncData,readSyncType:String = 'sceneSyncReadExternal'):void
		{
			var stream:URLStream = this._service.useSync(sync);
			_downloadingSyncs[stream] = {sync:sync,type:readSyncType};
			stream.addEventListener(Event.COMPLETE,onSyncLoad);
		}
		
		
		/**
		 */
		
		private function onSyncLoad(event:Event):void
		{
			try
			{
			
				var ct:URLStream = URLStream(event.target);
				
				event.currentTarget.removeEventListener(event.type,onSyncLoad);
	//		
				var sync:SyncData = _downloadingSyncs[ct].sync;
				var type:String = _downloadingSyncs[ct].type;
				
				if(sync.compressed)
				{
					var ba:ByteArray = new ByteArray();
					ct.readBytes(ba);
					ba.position = 0;
					ba.uncompress();
					this.readSceneFromServer(ba,sync.scene.id,type);
				}else
				{
					this.readSceneFromServer(ct,sync.scene.id,type);
				}
				
			}catch(e:Error)
			{
				Logger.logError(e);
				this.dispatchEvent(new FaultEvent(FaultEvent.FAULT,false,true,new Fault("0",e.message,e.getStackTrace())));
			}
				
			
//			
		}
		
		
		
	}
}