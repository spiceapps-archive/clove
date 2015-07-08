package com.spice.clove.bing.impl.content.control
{
	import com.spice.clove.bing.impl.BingPlugin;
	import com.spice.clove.bing.impl.content.control.search.BingSearchContentController;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;

	public class BingContentControllerFactory extends CloveContentControllerFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:BingPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BingContentControllerFactory(plugin:BingPlugin)
		{
			var avail:Vector.<String> = new Vector.<String>();
			avail.push(BingContentControllerType.SEARCH);
			
			super(avail);
			
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
				case BingContentControllerType.SEARCH: return new BingSearchContentController(name,this._plugin);
			}
			
			return super.getNewContentController(name);
		}
	}
}