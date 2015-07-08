package com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.favorites
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.data.FavoriteItem;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveDataHandler;

	public class CLoveGetFavoritesDataHandler extends CloveDataHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CLoveGetFavoritesDataHandler()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getData(data:*):Object
		{
			var favs:Array = [];
			for each(var data:* in data.favorite)
			{
				favs.push(FavoriteItem.fromXML(data));	
			}
			
			return favs;
		}
	}
}