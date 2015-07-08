package com.spice.clove.models
{
	import com.spice.clove.core.CloveAIRSettings;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.model.Singleton;

	public class CloveAIRModelLocator extends Singleton
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function CloveAIRModelLocator()
		{
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public static function getInstance():CloveAIRModelLocator
		{
			return Singleton.getInstance(CloveAIRModelLocator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var mainModel:CloveModelLocator = CloveModelLocator.getInstance();
		public var menuModel:MenuModel   = new MenuModel();	
//		public var messageModel:MessageModel = new MessageModel();
		public var applicationSettings:CloveAIRSettings = CloveAIRSettings.getInstance();
		
	}
}