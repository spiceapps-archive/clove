package com.spice.clove.plugin.impl.content.control
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.ICloveContentControllerFactory;
	
	
	/**
	 * 
	 * @author craigcondon
	 * 
	 */	
	
	public class CloveContentControllerFactory  implements ICloveContentControllerFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _availableServiceDelegates:Vector.<String>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveContentControllerFactory(availableServiceDelegates:Vector.<String> = null)
		{
			_availableServiceDelegates = availableServiceDelegates ? availableServiceDelegates : new Vector.<String>();
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAvailableContentControllers():Vector.<String>
		{
			return this._availableServiceDelegates;
		}
		
		/**
		 */
		
		public function getNewContentController(name:String):ICloveContentController
		{
			return null;//abstract
		}
		
		
	}
}