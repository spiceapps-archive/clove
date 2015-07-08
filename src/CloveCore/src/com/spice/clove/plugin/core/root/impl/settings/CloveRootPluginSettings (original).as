package com.spice.clove.plugin.core.root.impl.settings
{
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.core.calls.data.SceneSyncData;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.ByteArraySetting;
	import com.spice.vanilla.impl.settings.basic.UIntSetting;
	import com.spice.vanilla.impl.settings.list.StringListSetting;
	import com.spice.vanilla.impl.settings.list.StringTreeListSetting;
	
	import flash.utils.ByteArray;
	
	
	public class CloveRootPluginSettings extends ClovePluginSettings
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _uid:UIntSetting;
		private var _trash:StringListSetting;
		private var _recentSceneData:SceneSyncSubscriptionList;
		
		private var _usedGroups:StringTreeListSetting;
		private var _availableGroups:StringTreeListSetting;
		
		public static const MAX_TRASH_HISTORY:Number = 1000;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveRootPluginSettings()
		{
			super(RootPluginSettingsFactory.getInstance());
			
			this._uid   = UIntSetting(this.getNewSetting(BasicSettingType.UINT,"colUID"));
			this._trash = StringListSetting(this.getNewSetting(RootPluginSettingType.STRING_LIST,"columnTrash"));
			this._recentSceneData = SceneSyncSubscriptionList(this.getNewSetting(RootPluginSettingType.SCENE_SYNC_SUBSCRIPTION_LIST,"subscriptionData"));
			
			this._usedGroups 	  = StringTreeListSetting(this.getNewSetting(RootPluginSettingType.STRING_TREE_LIST,"sceneSyncUsedGroups"));
			this._availableGroups = StringTreeListSetting(this.getNewSetting(RootPluginSettingType.STRING_TREE_LIST,"sceneSyncAvailableGroups"));
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setRecentSceneData(value:SceneSyncData):void
		{
			this._usedGroups.removeTreeList(value.getSceneId().toString());
			this._recentSceneData.setSubscriptionSyncData(value.getSceneId(),ByteArray(value.getData()));
		}
		
		/**
		 */
		
		public function getRecentSceneData(id:int):ByteArray
		{
			return this._recentSceneData.getSubscriptionSyncData(id);
		}
		/**
		 */
		
//		public function getFilteredSceneGroupNames(sceneId:int):StringListSetting
//		{
//			return this.getNewSetting(RootPluginSettingType.STRING_TREE_LIST,"sceneSyncSubscriptionFilters_"+sceneId) as StringListSetting;
//		}
		
		/**
		 */
		
		
		/**
		 */
		
//		public function getAvailableSceneGroups(sceneId:int):StringListSetting
//		{
//			return this.getNewSetting(RootPluginSettingType.STRING_TREE_LIST,"sceneSyncAvailableGroups_"+sceneId) as StringListSetting;
//		}
		
		/**
		 */
		
		public function addUsedSceneGroup(id:int,value:StringTreeListSetting):void
		{
			this.getUsedSceneGroupList(id.toString()).setTreeList(value);
//			this.getFilteredSceneGroupNames(id).addString(value);
		}
		
		
		/**
		 */
		
		public function removeUsedSceneGroup(id:String,name:String):void
		{
			var list:StringTreeListSetting = this._usedGroups.getTreeList(id);
			
			if(list)
			{
				list.removeTreeList(name);
			}
		}
		
		/**
		 */
		
		public function getUsedSceneGroupAsArray(filter:String):Array
		{
			return this._usedGroups.getChildren(filter);
		}
		
		/**
		 */
		
		public function getAvailableSceneGroupAsArray(id:int,filter:String = null):Array
		{
			if(id > -1)
			{
				
				return this.getAvailableSceneGroupList(id.toString()).getChildren(filter);
				
			}
			
			
			var c:Array = [];
			
			
			var children:Array = this._availableGroups.getChildren();
			
			for each(var child:StringTreeListSetting in children)
			{
				c = c.concat(child.getChildren(filter));	
			}
			
			return c;
			
		}
		
		/**
		 */
		
		public function getUsedSceneGroupList(id:String = null):StringTreeListSetting
		{
			
			if(!id)
			{
				return this._usedGroups;
			}
			
			if(!this._usedGroups.hasTreeList(id,false))
			{
				this._usedGroups.setTreeList(new StringTreeListSetting(id));
			}
			
			return this._usedGroups.getTreeList(id);
		}
		
		/**
		 */
		
		
		
		/**
		 */
		
		public function getAvailableSceneGroupList(id:String = null):StringTreeListSetting
		{
			if(!id)
			{
				return this._availableGroups;
			}
			
			if(!this._availableGroups.hasTreeList(id,false))
			{
				this._availableGroups.setTreeList(new StringTreeListSetting(id));
			}
			
			return this._availableGroups.getTreeList(id);
		}
		
		
		/**
		 */
		
		public function addAvailableGroup(id:int,value:StringTreeListSetting):void
		{
			this.getAvailableSceneGroupList(id.toString()).setTreeList(value);
		}
		/**
		 */
		
//		public function filteredGroupsToArray(id:int):Array
//		{
//			
//			//if the id is -1, then what's being asked for is ALL of the available subscription views
//			if(id == -1)
//			{
//				return this.getAllStringListsToArray("sceneSyncSubscriptionFilters_");
//			}
//			
//			return this.getFilteredSceneGroupNames(id).toArray();
//		}
		
		
		/**
		 */
		
//		public function availableGroupsToArray(id:int):Array
//		{
//			
//			if(id == -1)
//			{
//				return this.getAllStringListsToArray("sceneSyncAvailableGroups_");
//			}
//			
//			return this.getAvailableSceneGroups(id).toArray();
//		}
		
		/**
		 */
		
//		public function removeFilteredSceneGroupName(id:int,value:String):void
//		{
//			this.getFilteredSceneGroupNames(id).removeString(value);
//		}
		
		/**
		 */
		
//		public function hasFilteredGroup(id:int,value:String):Boolean
//		{
//			return this.getFilteredSceneGroupNames(id).hasString(value);
//		}
		
		
		/**
		 */
		
//		public function addAvailableFilterableGroup(id:int,value:String):void
//		{
//			this.getAvailableSceneGroups(id).addString(value);
//		}
		
		/**
		 */
		
		public function hasRootColumn():Boolean
		{
			return this.hasSetting("rootColumn");
		}
		/**
		 */
		
		public function saveColumn(value:ClovePluginColumn):void
		{
			ColumnSetting(this.getNewSetting(RootPluginSettingType.PLUGIN_COLUMN,"rootColumn")).setData(value);
		}
		
		/**
		 */
		
		public function readColumn():ClovePluginColumn
		{
			
			var col:CloveColumn = ColumnSetting(this.getNewSetting(RootPluginSettingType.PLUGIN_COLUMN,"rootColumn")).getData();
			
			
			if(!col)
			{
				if(hasSetting("root"))
				{
					
					var root:ByteArraySetting = this.getSetting("root") as ByteArraySetting;
					
					var cs:ColumnSetting = ColumnSetting(this.getSettingFactory().getNewSetting(RootPluginSettingType.PLUGIN_COLUMN,null));
					
					var data:ByteArray = new ByteArray();
					root.getData().readBytes(data);
					
					data.position = 0;
					cs.readExternal(data);
					return ClovePluginColumn(cs.getData());
				}
			}
			
			//dump from memory
			//do NOT remove this, because if the app crashes, it's not saved. maybe 
//			this.removeSetting("rootColumn");
			
			return ClovePluginColumn(col);
		}
		
		/**
		 */
		
		public function addTrashedColumnUID(uid:String):void
		{
			
			//keep the history for a bit so we can tell subscribed scenes to remove particular feeds 
			if(_trash.getData().length > MAX_TRASH_HISTORY)
			{
				_trash.getData().shift();
			}
			
			this._trash.addString(uid);
		}
		
		/**
		 */
		
		public function getTrashedColumnUIDs():StringListSetting
		{
			return this._trash;
		}
		
		/**
		 */
		
		public function getIncrementalUID():int
		{
			_uid.setData(_uid.getData()+1);
			return _uid.getData();
		}
		
		
		
		
		
	}
}