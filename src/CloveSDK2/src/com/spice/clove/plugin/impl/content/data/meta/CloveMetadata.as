package com.spice.clove.plugin.impl.content.data.meta
{
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadata;

	public class CloveMetadata implements ICloveMetadata
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		private var _data:String;
		private var _label:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveMetadata(name:String,
									  label:String,
									  data:String)
		{
			this._name = name;
			this._data = data;
			this._label = label;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getType():String
		{
			return this._name;
		}
		
		/**
		 */
		
		public function getData():String
		{
			return this._data;
		}
		
		
		
		/**
		 */
		
		public function getLabel():String
		{
			return this._label;
		}
		
	}
}