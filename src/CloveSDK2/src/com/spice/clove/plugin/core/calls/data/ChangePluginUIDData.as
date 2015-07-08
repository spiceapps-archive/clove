package com.spice.clove.plugin.core.calls.data
{
	public class ChangePluginUIDData
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _oldUID:String;
		private var _newUID:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ChangePluginUIDData(oldUID:String,newUID:String)
		{
			_oldUID = oldUID;
			_newUID = newUID;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getOldUID():String
		{
			return _oldUID;
		}
		
		/**
		 */
		
		public function getNewUID():String
		{
			return _newUID;
		}
	}
}