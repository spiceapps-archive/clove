package com.spice.clove.fantasyVictory.impl.content.control
{
	import com.spice.clove.fantasyVictory.impl.FantasyVictoryPlugin;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;

	public class FantasyVictoryContentControllerFactory extends CloveContentControllerFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:FantasyVictoryPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		  
		/**
		 */
		
		public function FantasyVictoryContentControllerFactory(plugin:FantasyVictoryPlugin)
		{
			var available:Vector.<String> = new Vector.<String>();
			available.push(FantasyVictoryContentControllerType.QBS);
			available.push(FantasyVictoryContentControllerType.RBS);
			available.push(FantasyVictoryContentControllerType.WRS);
			
			super(available);
			
			this._plugin = plugin;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getNewContentController(name:String):ICloveContentController
		{
			switch(name)
			{
				case FantasyVictoryContentControllerType.QBS:
				case FantasyVictoryContentControllerType.RBS:
				case FantasyVictoryContentControllerType.WRS:
					return new FantasyVictoryContentController(name,_plugin);
			}
			
			return super.getNewContentController(name);
		}
	}
}