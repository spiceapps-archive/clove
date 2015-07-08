package com.spice.clove.plugin.impl.content.data
{
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class CloveHashTableSetting extends Setting
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _list:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveHashTableSetting(name:String,type:int)
		{
			super(name,type);
			
			_list = [];
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function addValue(key:String,value:String):void
		{
			
			var obj:Object = {};
			obj[key] = value;
			_list.push(obj);	
		}
		
		/**
		 */
		
		
		public function getHashTable():Array
		{
			return _list;
		}
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			var n:int = input.readInt();
			
			for(var i:int = 0; i < n; i++)
			{
				var obj:Object = {};
				obj[input.readUTFBytes(input.readInt())] = input.readUTFBytes(input.readInt());
				_list.push(obj);
			}
			
			this.notifyChange();
		}
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(_list.length);
			
			for each(var item:Object in _list)
			{
				for(var i:String in item)
				{
					output.writeInt(i.length);
					output.writeUTFBytes(i);
					
					output.writeInt(item[i].length);
					output.writeUTFBytes(item[i]);
				}
			}
		}
	}
}