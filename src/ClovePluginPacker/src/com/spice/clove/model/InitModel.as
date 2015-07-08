package com.spice.clove.model
{
	import com.spice.commands.init.IInitModel;
	
	
	[Bindable] 
	public class InitModel implements IInitModel
	{
		public var initialized:Boolean;
		public var started:Boolean;

	}
}