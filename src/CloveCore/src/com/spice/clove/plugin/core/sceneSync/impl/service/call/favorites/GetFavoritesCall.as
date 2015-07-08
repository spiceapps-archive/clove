package com.spice.clove.plugin.core.sceneSync.impl.service.call.favorites
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveService;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.favorites.CLoveGetFavoritesDataHandler;

	public class GetFavoritesCall extends CloveServiceCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		[Setting]
		public var groupName:String;
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function GetFavoritesCall(groupName:String)
		{
			this.groupName = groupName;
			
			super(CloveUrls.FAVORITES_SHOW_URL,new CLoveGetFavoritesDataHandler());
		}
	}
}