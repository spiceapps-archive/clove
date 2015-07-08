package com.spice.clove.web.plugin.root.content.control
{
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.content.control.ICloveContentControllerFactory;
	import com.spice.clove.plugin.core.root.control.RootContentControllerType;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;
	import com.spice.vanilla.core.plugin.IPlugin;
	
	public class WebRootContentControllerFactory extends CloveContentControllerFactory implements ICloveContentControllerFactory
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
		
		public function WebRootContentControllerFactory(plugin:ClovePlugin)
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
					return new WebRootContentController(name,_plugin);
					break;
			}
			
			return null;
		}
	}
}