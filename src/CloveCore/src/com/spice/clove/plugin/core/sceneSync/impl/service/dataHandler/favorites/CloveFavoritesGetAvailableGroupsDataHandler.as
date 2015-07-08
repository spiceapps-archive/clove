package com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.favorites
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.data.FavoritesCategory;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveDataHandler;

	public class CloveFavoritesGetAvailableGroupsDataHandler extends CloveDataHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveFavoritesGetAvailableGroupsDataHandler()
		{
			super();
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
			var groups:Array = [];
			
			
			for each(var group:* in data.group)
			{
				groups.push(FavoritesCategory.fromXML(group));
			}
			
			return groups;
		}
	}
}