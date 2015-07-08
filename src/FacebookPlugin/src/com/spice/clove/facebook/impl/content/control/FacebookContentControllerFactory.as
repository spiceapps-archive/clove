package com.spice.clove.facebook.impl.content.control
{
	import com.spice.clove.facebook.impl.FacebookPlugin;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;

	public class FacebookContentControllerFactory extends CloveContentControllerFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:FacebookPlugin;
		private var _public:Vector.<String>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookContentControllerFactory(plugin:FacebookPlugin)
		{
			_public = new Vector.<String>(1,true);
			var available:Vector.<String> = new Vector.<String>(1,true);
			available[0] = _public[0] = FacebookContentControllerType.FAN_PAGE;
			super(available);
			
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
				case FacebookContentControllerType.FAN_PAGE: return new FacebookFanPageContentController(name,_plugin);
			}
			
			return super.getNewContentController(name);
		}
		
		
		/**
		 */
		
		public function getPublicContentControllers():Vector.<String>
		{
			return _public;
		}
	}
}