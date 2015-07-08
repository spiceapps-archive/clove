package com.spice.clove.plugin.core.sceneSync.impl.service.call.favorites
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveDataHandler;

	public class CreateNewFavoriteCategoryCall extends CloveServiceCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		[Setting]
		public var name:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CreateNewFavoriteCategoryCall(name:String)
		{
			this.name = name;
			
			super(CloveUrls.FAVORITES_ADD_GROUP_URL,new CloveDataHandler());
		}
	}
}