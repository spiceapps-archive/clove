package com.spice.clove.plugin.core.root.impl.data
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.ICloveContentControllerFactory;
	
	public class AvailableServiceDelegateData
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		private var _factory:ICloveContentControllerFactory;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AvailableServiceDelegateData(name:String,factory:ICloveContentControllerFactory)
		{
			_name = name;
			_factory = factory;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get name():String
		{
			return _name;
		}
		
		/**
		 */
		
		public function get factory():ICloveContentControllerFactory
		{
			return this._factory;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getNewServiceDelegate():ICloveContentController
		{
			return this.factory.getNewContentController(this.name);
		}
	}
}