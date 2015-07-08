package com.spice.clove.plugin.core.sceneSync.impl.views.menu
{
	import com.spice.clove.plugin.core.content.control.option.menu.ICloveDataMenuOption;
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPlugin;
	import com.spice.clove.plugin.core.sceneSync.impl.account.SceneSyncAccount;
	import com.spice.clove.plugin.core.sceneSync.impl.service.events.CloveServiceEvent;
	import com.spice.clove.plugin.impl.content.control.option.menu.CloveDataMenuOption;
	import com.spice.clove.plugin.impl.views.menu.AbstractMenuItemViewController;
	import com.spice.clove.plugin.impl.views.menu.AbstractRegisteredMenuItemViewController;
	import com.spice.clove.plugin.impl.views.menu.MenuItemType;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncPluginType;
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.monkeyPatch.menu.Menu;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;

	public class SceneSyncMenuViewController extends AbstractRegisteredMenuItemViewController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const MANAGE_SCENES:String = "Manage Scenes";
		public static const ALL_SCENES:String = "All Scenes";
		public static const NEW_SCENE:String = "New Scene";
		public static const SYNCHRONIZE:String = "Synchronize";
		public static const EXPORT_BACKUP:String = "Export Backup";
		public static const OPEN_BACKUP:String = "Open Backup";
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _scenes:Array;
		private var _plugin:SceneSyncPlugin;
		private var _account:SceneSyncAccount;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncMenuViewController(plugin:SceneSyncPlugin)
		{
			super(plugin.getPluginMediator());
			
			this._plugin = plugin;
			
			this.update([]);
			
		}
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAccount():SceneSyncAccount
		{
			if(!this._account)
			{  
				this._account = SceneSyncAccount(this._plugin.getAccountOrMake());
			}
			
			return this._account;
		}
		
		
		/**
		 */
		
		public function exportBackup():void
		{
			this._plugin.getBackupHelper().saveBackup();
		}
		
		/**
		 */
		
		public function openBackup():void
		{	
			this._plugin.getBackupHelper().openBackup();
		}
		
		/**
		 */
		
		public function setAccount(value:SceneSyncAccount):void
		{
			
			this._account = value;
			
			this.update([]);
			
		}
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			if(n.getType() == SYNCHRONIZE)
			{
				
				//if the account exists, then send a sync to the server. no need to check if a new sync under
				//the account exists because that happens ONLY when the application opens. 
				if(this._account)
				{
					this._account.sendToServerIfChange();
					
				}
				  
				//check for the subscriptions
				this._plugin.getLatestSubscriptionSyncs(true);
			}
			if(n.getType() == EXPORT_BACKUP)
			{
				this.exportBackup();
				return;
			}
			else
			if(n.getType() == OPEN_BACKUP)
			{
				this.openBackup();
				return;
			}
			
			if(!this._account)
			{
				this.update([]);
				return super.handleProxyResponse(n);
			}
			
			if(n.getType() == NEW_SCENE)
			{
				
				ProxyCallUtils.quickCall(CallSceneSyncPluginType.OPEN_CREATE_NEW_SCENE_VIEW,this.getAccount().getPlugin().getProxy());
				return;
			}
			else
			if(n.getType() == MANAGE_SCENES)
			{
				ProxyCallUtils.quickCall(CallSceneSyncPluginType.OPEN_SCENE_SYNC_PREFERENCE_VIEW,SceneSyncPlugin(this.getAccount().getPlugin()).getPluginMediator());
				return;
			}
			
			
			else
			if(this._account)
			{
				
				for each(var scene:SceneData in this._scenes)
				{
					CloveDataMenuOption(this.getMenuItem(scene.getName())).setChecked(false);
				}
				
				
				for each(var scene:SceneData in this._scenes)
				{
					if(n.getType() == scene.getName())
					{
						this._account.setCurrentScene(scene);
						CloveDataMenuOption(this.getMenuItem(scene.getName())).setChecked(true);
						this.showMenuUnder();
						return;
					}
				}
				
			}
			
			super.handleProxyResponse(n);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function update(data:Array):void
		{
			
			this._scenes = data;
			this._usedMenuItems = new Vector.<ICloveDataMenuOption>();
			this.setDataOptionsToUse(null);
			this.showMenuUnder();
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
			
			var itemsToUse:Array = [];
			
			
			
			itemsToUse.push(MANAGE_SCENES);
			
			if(this._account)
			{
				itemsToUse.push(NEW_SCENE,MenuItemType.SEPARATOR);
			}
			
			itemsToUse.push(SYNCHRONIZE);
			
			
			//start backup
			itemsToUse.push(MenuItemType.SEPARATOR,EXPORT_BACKUP,OPEN_BACKUP);
			
			
			//create the separator so the user knows the "New Scene" menu item is not a scene they own
			if(this._scenes && this._scenes.length > 0)
			{
				itemsToUse.push(MenuItemType.SEPARATOR);
			}
			
			
			for each(var scene:SceneData in this._scenes)
			{
				
				var menuItem:CloveDataMenuOption = CloveDataMenuOption(this.getMenuItem(scene.getName()));
				
				itemsToUse.push(scene.getName());
				
				//allScenes.getSubMenuItems().push(menuItem);

				if(scene.id == this._account.getService().settings.getCurrentScene().id)
				{
					CloveDataMenuOption(menuItem).setChecked(true);
				}
				else
				{
					CloveDataMenuOption(menuItem).setChecked(false);
				}
			}
			
			
			
			
			this.useMenuItems(itemsToUse);
		}
		
	}
}