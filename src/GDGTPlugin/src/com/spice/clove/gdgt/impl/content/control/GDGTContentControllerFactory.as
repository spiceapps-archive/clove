package com.spice.clove.gdgt.impl.content.control
{
	import com.spice.clove.gdgt.impl.GDGTPlugin;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;

	public class GDGTContentControllerFactory extends CloveContentControllerFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:GDGTPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GDGTContentControllerFactory(plugin:GDGTPlugin)
		{
			var serv:Vector.<String> = new Vector.<String>();
			serv.push(GDGTContentControllerType.NEWS);
			super(serv);
			
			_plugin = plugin;
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
				case GDGTContentControllerType.NEWS: return new GDGTContentController(name,_plugin);
			}
			
			return super.getNewContentController(name);
		}
		
	}
}