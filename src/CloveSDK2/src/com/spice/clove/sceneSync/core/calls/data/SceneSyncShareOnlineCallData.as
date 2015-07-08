package com.spice.clove.sceneSync.core.calls.data
{
	import com.spice.clove.plugin.core.column.ICloveColumn;

	public class SceneSyncShareOnlineCallData
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _columnRoute:Vector.<int>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncShareOnlineCallData(columnRoute:Vector.<int>)
		{
			this._columnRoute = columnRoute;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getColumnRoute():Vector.<int>
		{
			return this._columnRoute;
		}
		
	}
}