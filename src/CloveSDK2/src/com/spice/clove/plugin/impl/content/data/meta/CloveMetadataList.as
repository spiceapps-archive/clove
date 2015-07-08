package com.spice.clove.plugin.impl.content.data.meta
{
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadata;
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadataList;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class CloveMetadataList extends Setting implements ICloveMetadataList
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _metadata:Vector.<ICloveMetadata>;
		private var _filterSearch:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveMetadataList(name:String,type:int)
		{
			super(name,type);
			
			this._metadata = new Vector.<ICloveMetadata>();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		
		public function getMetadata(name:String):Vector.<ICloveMetadata>
		{
			this._filterSearch = name;
			
			return this._metadata.filter(this.findMetadata,this);
		}
		
		/**
		 */
		
		public function addMetadata(value:ICloveMetadata):ICloveMetadata
		{
			this._metadata.push(value);
			return value;
		}
		
		/**
		 */
		
		public function getAllMetadata():Vector.<ICloveMetadata>
		{
			return this._metadata;
		}
		
		/**
		 */
		
		
		public function hasMetadata(name:String):Boolean
		{
			for each(var metadata:ICloveMetadata in this._metadata)
			{
				if(metadata.getType() == name)
					return true;
			}
			
			return false;
		}
		
		
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{
			var n:int = this._metadata.length;
			
			
			//the metadata length shouldn't be huge (2 bytes max)
			output.writeShort(n);
			
			for each(var meta:ICloveMetadata in this._metadata)
			{
				
				//the name SHOULD be short, so we can write UTF, which writes a string as a short value
				output.writeUTF(meta.getType());
				
				output.writeUTF(meta.getLabel());
				
				//the data could be big, so we need to make room for it (4 bytes)
				output.writeUnsignedInt(meta.getData().length);
				output.writeUTFBytes(meta.getData());
			}
		}
		
		/**  
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			var n:int = input.readShort();
			
			for(var i:int = 0; i < n; i++)
			{
				this.addMetadata(new CloveMetadata(input.readUTF(),
												   input.readUTF(),
												   input.readUTFBytes(input.readUnsignedInt())));
			}
			
			this.notifyChange();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function findMetadata(item:ICloveMetadata,
									  index:int,
									  vector:Vector.<ICloveMetadata>):Boolean
		{
			return item.getType() == this._filterSearch;
		}
		
	}
}