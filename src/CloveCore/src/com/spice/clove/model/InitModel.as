package com.spice.clove.model
{
	import com.spice.commands.init.IInitModel;
	
	
	[Bindable]
	public class InitModel implements IInitModel
	{
			
		public var started:Boolean;//when the init command is executed
		public var initialized:Boolean;//true when all the plugins are loaded in and the splash page is gone
		public var currentMessage:String;
		
		

	}
}