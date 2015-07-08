package com.spice.clove.analytics.core.calls.data
{
	import mx.utils.ObjectUtil;

	public class RecordMetricData
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		private var _content:String;
		private var _count:uint;
		private var _metadata:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RecordMetricData(name:String,content:String,count:uint = 1,metadata:Object = null)
		{
			this._name = name;
			this._content = content;
			this._count = count;
			this._metadata = metadata || {};
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getName():String
		{
			return this._name;
		}
		
		/**
		 */
		
		public function getContent():String
		{
			return this._content;
		}
		
		/**
		 */
		
		public function getCount():uint
		{
			return this._count;
		}
		
		/**
		 */
		
		public function getMetadata():Object
		{
			return this._metadata;
		}
		
		/**
		 */
		
		public function getTags():Array
		{
			return [];//this._metadata;
		}
		
		
		/**
		 */
		
		public function toObject(stickyMetadata:Array = null):Object
		{
			var metadata:Object = {};
			
			for(var key:String in this._metadata)
			{
				metadata[key] = this._metadata[key];
			}
			
			var metaByStack:Array = [];
			
			
			//we need to push the metadata so it's [{key:value},{key:value}] instead of {key:value,key:value}
			//we do it HERE incase there are any duplicates
			for(key in metadata)
			{
				var ind:Object = {};
				ind[key] = metadata[key];
				metaByStack.push(ind);
			}
			
			
			metaByStack = (stickyMetadata || []).concat(metaByStack);
			
			var data:Object = {};
			data.type = this._name;
			data.content = this._content;
			data.count = this._count;
			data.metadata = metaByStack;
			
			return data;
		}
	}
}