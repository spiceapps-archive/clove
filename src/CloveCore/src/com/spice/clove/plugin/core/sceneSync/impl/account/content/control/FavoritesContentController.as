package com.spice.clove.plugin.core.sceneSync.impl.account.content.control
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPlugin;
	import com.spice.clove.plugin.core.sceneSync.impl.account.SceneSyncAccount;
	import com.spice.clove.plugin.core.sceneSync.impl.account.content.control.render.FavoritesDataRenderer;
	import com.spice.clove.plugin.core.sceneSync.impl.service.events.CloveServiceEvent;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.account.content.control.AccountContentController;
	import com.spice.clove.service.impl.account.content.control.search.AccountSearchBasedContentController;

	public class FavoritesContentController extends AccountSearchBasedContentController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		public var test:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FavoritesContentController(factoryName,plugin:SceneSyncPlugin)
		{
			super(factoryName,plugin,new FavoritesDataRenderer(this,plugin.getPluginMediator()));
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function loadNewer2(data:ICloveData=null):void
		{
			
			var acc:SceneSyncAccount = SceneSyncAccount(this.getAccountOrMake());
			
			acc.getService().getFavorites(this.getSearchTerm().getData()).addEventListener(CloveServiceEvent.RESULT,onGetFavorites);
		}
		
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			this.fillColumn([]);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function initialize(value:AbstractServiceAccount):void
		{
			super.initialize(value);
			
			
			
			var sync:SceneSyncAccount = SceneSyncAccount(value);
			
			//YUCK for now. We should really only be listening for change on the category this controller
			//is listening on
			sync.getService().addEventListener(CloveServiceEvent.ADDED_FAVORITE,onAddedFavorite,false,0);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onGetFavorites(event:CloveServiceEvent):void
		{
			if(!event.success)
			{
				this.showErrorMessage(event.message);
				return;
			}
			var data:Array = event.data;
			
			
			
			this.fillColumn(data);
			
		}
		
		/**
		 */
		
		private function onAddedFavorite(event:CloveServiceEvent):void
		{
			
			this.loadNewer();
		}
		
	}
}