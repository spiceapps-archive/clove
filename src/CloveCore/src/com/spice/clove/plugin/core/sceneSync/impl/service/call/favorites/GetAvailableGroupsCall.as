package com.spice.clove.plugin.core.sceneSync.impl.service.call.favorites
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.favorites.CloveFavoritesGetAvailableGroupsDataHandler;

	public class GetAvailableGroupsCall extends CloveServiceCall
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetAvailableGroupsCall()
		{
			super(CloveUrls.FAVORITES_SHOW_AVAILABLE_GROUPS_URL,new CloveFavoritesGetAvailableGroupsDataHandler());
		}
	}
}