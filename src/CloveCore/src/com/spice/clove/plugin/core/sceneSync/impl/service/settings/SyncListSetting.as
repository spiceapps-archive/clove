package com.spice.clove.plugin.core.sceneSync.impl.service.settings
{
	import com.spice.clove.sceneSync.core.service.data.SyncData;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class SyncListSetting extends Setting
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _data:Vector.<SyncData>;
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const VERSION:int = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SyncListSetting(name:String,type:int)
		{
			super(name,type);
			
			_data = new Vector.<SyncData>();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getData():Vector.<SyncData>
		{
			return _data;
		}
		
		/**
		*/
		
		public function useSync(newSync:SyncData):SyncData
		{
			var n:int = this._data.length;
			
			for(var i:int = 0; i < n; i++)
			{
				if(this._data[i].scene.id == newSync.scene.id)
				{
					this._data[i] = newSync;
					this.notifyChange();
					return newSync;
				}
			}
			
			_data.push(newSync);
			
			this.notifyChange();
			
			return newSync;
		}
		
		/**
		 */
		
		public function getSync(sceneID:Number):SyncData
		{
			for each(var sync:SyncData in this._data)
			{
				if(sync.scene.id == sceneID)
				{
					return sync;
				}
			}
			
			return null;
		}
		
		
		
		/**
		 */
		
		public function setData(value:Vector.<SyncData>):void
		{
			this._data = value;
			
			this.notifyChange(this._data);
		}
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(VERSION);
			
			
			var n:Number = this._data.length;
			
			output.writeUnsignedInt(n);
			
			for each(var sync:SyncData in this._data)
			{
				sync.writeExternal(output);
				
			}
			
			/*public var id:Number;
			public var createdAt:Date;
			public var screen:ScreenData;
			public var scene:SceneData;
			public var data:XMLList;*/
		}
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			input.readInt();
			
			var n:int = input.readUnsignedInt();
			
			this._data = new Vector.<SyncData>(n);
			
			for(var i:int = 0; i < n; i++)
			{
				var data:SyncData = new SyncData();
				data.readExternal(input);
				
				this._data[i] = data;
			}
			
			this.notifyChange();
		}
	}
}