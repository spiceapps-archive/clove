package com.spice.clove.web.plugin.root
{
	import com.spice.clove.plugin.core.root.factory.CloveRootPluginFactory;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class WebRootPluginFactory extends ClovePluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function WebRootPluginFactory()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function newPlugin():IPlugin
		{
			return new WebRootPlugin(this);
		}
	}
}