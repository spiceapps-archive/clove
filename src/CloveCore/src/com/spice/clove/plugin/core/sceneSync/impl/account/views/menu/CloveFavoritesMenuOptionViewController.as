package com.spice.clove.plugin.core.sceneSync.impl.account.views.menu
{
	import com.spice.clove.plugin.core.content.control.option.menu.ICloveDataMenuOption;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPlugin;
	import com.spice.clove.plugin.core.sceneSync.impl.account.SceneSyncAccount;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveService;
	import com.spice.clove.plugin.impl.content.control.option.menu.CloveDataMenuOption;
	import com.spice.clove.plugin.impl.views.menu.AbstractMenuItemViewController;
	import com.spice.vanilla.core.observer.INotification;

	public class CloveFavoritesMenuOptionViewController extends AbstractMenuItemViewController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const BOOKMARK:String = "Bookmark";
		
		
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
		
		public function CloveFavoritesMenuOptionViewController(plugin:SceneSyncPlugin)
		{
			_plugin = plugin;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			
			var t:String = n.getType();
			
			
			if(t == BOOKMARK)
			{
				this.addBookmark(n.getData());
			}
			else
			if(this._plugin.getSceneSyncAccount())
			{
				
				var serv:CloveService = this._plugin.getSceneSyncAccount().getService();
				
				for each(var favCat:String in serv.getLoadedAvailableCategories())
				{
					if(favCat == t)
					{
						var data:ICloveData = n.getData();
						
						
						
						//add the favorite!
						serv.addFavorite(favCat,"",data);
						
						return;
						
						
					}
				}
			}
			
			
			super.handleProxyResponse(n);
		}
		
		/**
		 */
		
		public function addBookmark(value:ICloveData):void
		{
			Logger.log("Bookmarking "+value.getTitle());
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setDataOptionsToUse(data:Object):void
		{
			super.setDataOptionsToUse(data);
			
			
			var menuItem:CloveDataMenuOption = CloveDataMenuOption(this.getMenuItem(BOOKMARK));
			
			menuItem.removeSubMenuItems();
			
			
			var acc:SceneSyncAccount = this._plugin.getSceneSyncAccount();
			
			if(acc)
			{
				var ac:Vector.<String> = acc.getService().getLoadedAvailableCategories();
				
				for each(var service:String in ac)
				{
					menuItem.getSubMenuItems().push(this.getMenuItem(service));
				}
			}
			
			
			
			
			this.useMenuItems([BOOKMARK]);
		}
		
		
	}
}