package com.spice.clove.model
{
	import com.spice.clove.plugin.compiled.CompiledPlugin;
	
	import flash.utils.ByteArray;
	
	
	[Bindable] 
	public class PackModel
	{
		public var percentDone:Number;
		public var file:CompiledPlugin;
		
		
		
		public var rebundledAIR:ByteArray;
	}
}