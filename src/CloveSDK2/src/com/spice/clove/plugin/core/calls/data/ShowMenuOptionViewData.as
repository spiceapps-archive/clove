package com.spice.clove.plugin.core.calls.data
{
	import flash.display.Stage;
	
	/**
	 * passed when showing the menu option 
	 * @author craigcondon
	 * 
	 */	
	
	public class ShowMenuOptionViewData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _stage:Stage;
		private var _x:Number;
		private var _y:Number;
		private var _data:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ShowMenuOptionViewData(stage:Stage,x:Number,y:Number,data:Object = null)
		{
			this._stage = stage;
			this._x = x;
			this._y = y;
			this._data = data;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getStage():Stage
		{
			return this._stage;
		}
		
		/**
		 */
		
		public function getX():Number
		{
			return this._x;
		}
		
		/**
		 */
		
		public function getY():Number
		{
			return this._y;
		}
		
		/**
		 */
		
		public function getData():Object
		{
			return this._data;
		}
	}
}