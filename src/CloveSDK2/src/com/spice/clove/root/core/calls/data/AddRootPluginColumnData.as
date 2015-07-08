package com.spice.clove.root.core.calls.data
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;

	public class AddRootPluginColumnData
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _children:Vector.<AddRootPluginColumnData>;
		private var _controller:ICloveContentController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AddRootPluginColumnData(controller:ICloveContentController = null)
		{
			_controller = controller;
			_children = new Vector.<AddRootPluginColumnData>();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getController():ICloveContentController
		{
			return this._controller;
		}
		
		/**
		 */
		
		public function getChildren():Vector.<AddRootPluginColumnData>
		{
			return _children;
		}
	}
}