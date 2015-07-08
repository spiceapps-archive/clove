package com.spice.clove.plugin.core.root.desktop.content.control
{
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.ICloveContentControllerFactory;
	import com.spice.clove.plugin.core.root.impl.content.control.RootContentControllerType;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;
	import com.spice.vanilla.core.plugin.IPlugin;

	public class RootContentControllerFactory extends CloveContentControllerFactory implements ICloveContentControllerFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:ClovePlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RootContentControllerFactory(plugin:ClovePlugin)
		{
			var vect:Vector.<String> = new Vector.<String>(1,true);
			vect[0] = RootContentControllerType.ROOT_CONTENT_CONTROLLER;
			super(vect);
			
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
				
				case RootContentControllerType.ROOT_CONTENT_CONTROLLER:
					return new RootContentController(name,_plugin);
				break;
			}
			
			return null;
		}
	}
}