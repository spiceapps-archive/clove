package com.spice.clove.plugin.core.calls.data
{
	import flash.utils.IDataInput;

	public class SceneSyncData
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _data:IDataInput;
		private var _id:int;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncData(id:int,data:IDataInput)
		{
			this._id = id;
			this._data = data;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getSceneId():int
		{
			return this._id;
		}
		
		/**
		 */
		
		public function getData():IDataInput
		{
			return this._data;
		}
	}
}