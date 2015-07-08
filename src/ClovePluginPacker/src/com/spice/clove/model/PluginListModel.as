package com.spice.clove.model
{
	import com.spice.clove.plugin.compiled.CompiledPlugin;
	
	import mx.collections.ArrayList;
	
	
	[Bindable] 
	public class PluginListModel
	{
		public var userPlugins:ArrayList;
		public var currentPlugin:CompiledPlugin;

	}
}