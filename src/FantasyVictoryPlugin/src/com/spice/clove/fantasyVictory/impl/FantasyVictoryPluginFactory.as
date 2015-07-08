package com.spice.clove.fantasyVictory.impl
{
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class FantasyVictoryPluginFactory extends ClovePluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FantasyVictoryPluginFactory()
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
			return new FantasyVictoryPlugin(this);
		}
	}
}