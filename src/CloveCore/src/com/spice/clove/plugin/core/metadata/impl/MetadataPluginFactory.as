package com.spice.clove.plugin.core.metadata.impl
{
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class MetadataPluginFactory extends ClovePluginFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function MetadataPluginFactory()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function newPlugin():IPlugin
		{
			return new MetadataPlugin(this);
		}
	}
}