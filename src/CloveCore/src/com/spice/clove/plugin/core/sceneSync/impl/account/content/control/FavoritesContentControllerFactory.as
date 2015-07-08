package com.spice.clove.plugin.core.sceneSync.impl.account.content.control
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;

	public class FavoritesContentControllerFactory extends CloveContentControllerFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:SceneSyncPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FavoritesContentControllerFactory(plugin:SceneSyncPlugin)
		{
			var vail:Vector.<String> = new Vector.<String>();
			vail.push(FavoritesContentControllerType.FAVORITES);
			
			_plugin = plugin;
			
			super(vail);
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
				case FavoritesContentControllerType.FAVORITES: return new FavoritesContentController(name,_plugin);
			}
			
			return super.getNewContentController(name);
		}
	}
}