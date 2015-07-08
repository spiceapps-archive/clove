package com.spice.clove.web.plugin.root
{
	import com.spice.vanilla.flash.singleton.Singleton;

	public class WebRotModelLocator extends Singleton
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function WebRotModelLocator()
		{
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public static function getInstance():WebRotModelLocator
		{
			return Singleton.getInstance(WebRotModelLocator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		public var plugin:WebRootPlugin;
	}
}