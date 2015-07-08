package com.spice.clove.plugin.core.root.impl.sync
{
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.column_internal;
	import com.spice.clove.plugin.core.calls.data.SceneSyncData;
	import com.spice.clove.plugin.core.root.impl.CloveRootPlugin;
	import com.spice.clove.plugin.core.root.impl.models.CloveRootModelLocator;
	import com.spice.clove.plugin.core.root.impl.settings.CloveRootPluginSettings;
	import com.spice.clove.plugin.core.root.impl.settings.ColumnSetting;
	import com.spice.impl.utils.AsyncUtil;
	import com.spice.vanilla.impl.settings.list.StringListSetting;
	import com.spice.vanilla.impl.settings.list.StringTreeListSetting;
	
	import flash.utils.setTimeout;
	
	use namespace column_internal;
	
	public class ColumnSynchronizer
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _cols:Object;
		private var _plugin:CloveRootPlugin;
		private var _syncDeleted:StringListSetting;
		private var _async:AsyncUtil;
		private var _currentSceneData:SceneSyncData;
		
		
		private var _model:CloveRootModelLocator = CloveRootModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ColumnSynchronizer(plugin:CloveRootPlugin)
		{
			_plugin = plugin;
			_cols = {};
			_async = AsyncUtil.getTimer(ColumnSynchronizer,100);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function merge(input:SceneSyncData):void
		{
			
			this._cols = {};
			
			
			_currentSceneData = input;
			
			var settings:CloveRootPluginSettings = new CloveRootPluginSettings();
			settings.readExternal(input.getData());
			_syncDeleted = settings.getTrashedColumnUIDs();
			
			var root:ColumnSetting = settings.getColumnSetting();
			var realRoot:ClovePluginColumn = this._plugin.getRootColumn();
			
			
			
			//			root.setHistoryController(realRoot.historyController);
			
			//the stack of columns to delete from the subscriptions. these are columns that have
			//NOT been changed by the user. We know if the columns ha
			var colsToRemove:Vector.<CloveColumn> = new Vector.<CloveColumn>();
			
			if(realRoot)
				//set the current columns so we synchronize columns in the right place
				this.setCurrentCols(realRoot);
			
			
			//filter out the columns we don't want to synchronize
			this.removeUnusedSyncGroups(root);
			
			if(!realRoot)
				return;
			
			
			
			
			
			//find columns to remove so we can promt the user.
			this.findColumnsToRemove(realRoot,colsToRemove);
			
			
			//synchronize deleted
			this.removeTrashedColumns(colsToRemove);
			
			colsToRemove = new Vector.<CloveColumn>();
			
			
			
			//synchronize deleted. make this
			this.removeTrashedColumns(colsToRemove,false);
			
			
			
			
			
			
			
			
			
			
			//			_model.rootContentController.viewController.target = null;
			
			
			
			//merge the current root column with the subscribed
			this.mergeNewColumns(root,realRoot);
			
			
		}
		
		
		
		
		
		/**
		 */
		
		public function split(input:SceneSyncData):void
		{
			var settings:CloveRootPluginSettings = new CloveRootPluginSettings();
			settings.readExternal(input.getData());
			var root:ColumnSetting = settings.getColumnSetting();
			var realRoot:ClovePluginColumn = this._plugin.getRootColumn();
			this._cols = {};
			this.setCurrentCols(realRoot);
			this.splitColumn(root);
		}
		
		
		/**
		 */
		
		private function splitColumn(target:ColumnSetting):void
		{
			
			for each(var child:ColumnSetting in target.getChildren())
			{
				this.splitColumn(child);
			}
			
			var counter:CloveColumn = this._cols[target.getUID()];
			
			
			if(counter && counter.children.length == 0)
			{
				counter.removeFromParent();
			}
			
			
			//remove the deleted history so the user can re-subscribe to the feed
			_plugin.removeDeletedColumnHistory(target.getUID());
		}
		
		/**
		 */
		
		private function removeUnusedSyncGroups(root:ColumnSetting):void
		{
			var toRemove:Vector.<ColumnSetting> = new Vector.<ColumnSetting>();
			
			for each(var cur:ColumnSetting in root.getChildren())
			{
				
				
				this._plugin.getRootPluginSettings().addAvailableGroup(this._currentSceneData.getSceneId(),this.buildGroupTree(cur));
				
				var list:StringTreeListSetting = this._plugin.getRootPluginSettings().getUsedSceneGroupList(this._currentSceneData.getSceneId().toString());
				
				
				
				//if the item is NOT checked, then put it in the do-not-sync list ;)
				if(!list.hasTreeList(cur.getTitle()))
				{
					this.splitColumn(cur);
					toRemove.push(cur);
				}
			}
			
			for each(cur in toRemove)
			{
				cur.removeFromParent();
			}
		}
		
		
		/**
		 */
		
		private function buildGroupTree(cur:ColumnSetting):StringTreeListSetting
		{
			var list:StringTreeListSetting = new StringTreeListSetting(cur.getTitle());
			
			for each(var child:ColumnSetting in cur.getChildren())
			{
				list.setTreeList(buildGroupTree(child));
			}
			
			return list;
		}
		
		/**
		 */
		
		private function findColumnsToRemove(cur:CloveColumn,stack:Vector.<CloveColumn>):void
		{
			for each(var child:CloveColumn in Object(cur.children).source)
			{
				this.findColumnsToRemove(child,stack);
			}
			
			
			if(this._syncDeleted.hasString(cur.getUID()))
			{
				stack.push(cur);
				return;
			}
			
			
		}
		
		/**
		 */
		
		private function removeTrashedColumns(cur:Vector.<CloveColumn>,safe:Boolean = true):void
		{
			for each(var col:CloveColumn in cur)
			{
				if(col.children.length == 0 || !safe)
					col.removeFromParent();
			}
			//			else
			//				
			//			//if the column is a holder column, or a group and it doesn't have any children, then remove it.
			//			if((cur.type == RootPluginSettingType.HOLDER_COLUMN || cur.type == RootPluginSettingType.GROUP_COLUMN) && cur.children.length == 0)
			//			{
			//				cur.removeFromParent();
			//			}
		}
		
		/**
		 */
		
		private function mergeNewColumns(target:ColumnSetting,counter:CloveColumn = null):Boolean
		{
			
			
			for(var i:int = 0; i < target.getChildren().length; i++)
			{
				var child:ColumnSetting = target.getChildren()[i];
				
				var c:CloveColumn = _cols[child.getUID()];
				
				if(mergeNewColumns(child,c))
				{
					i--;
				}
				
				
				//				if(counter)
				//				{
				//					counter.children.addItem(child);
				//					i--;
				//				}
				
			}
			
			
			
			
			if(counter)
			{
				
				target.removeFromParent();
				
				////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				//DO NOT do this! it would be OKAY if this were before executing, but 
				//by reseting the controller each time, we're dumping the trash, and since scene sync
				//comes AFTER loading columns, everything would show up blank. to synchronize controller
				//changes, have the CONTROLLER dispatch a resetUID event
				//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				
				//				if(counter is ClovePluginColumn && counter.parent)
				//				{
				//					ClovePluginColumn(counter).controller = ClovePluginColumn(target).controller;
				//				}
				
				while(target.getChildren().length > 0)
				{
					var child:ColumnSetting = target.getChildren().pop();
					
					//if the column being added to the users list is deleted, then skip it.
					//this allows the user to essentially synchronize with content they're interested in, and delete
					//the stuff they don't like
					if(this._plugin.hasDeletedColumn(child.getUID()))
						continue;
					
					var initChild:CloveColumn = child.initialize();
					
					//for new children, we want FRESH history settings, otherwise this could conflict with 
					//the already existing columns
					initChild.setHistorySettings(null);
//					this.addChild(counter,ClovePluginColumn(child));
					_async.callLater(addChild,counter,initChild);
				}
				
				return true;
			}
			return false;
		}
		
		/**
		 */
		
		private function addChild(counter:CloveColumn,child:ClovePluginColumn):void
		{
			counter.children.addItem(child);	
			
			//load the new data ONLY
			
//			flash.utils.setTimeout(child.loadNewerContent,3000);
		}
		
		
		/**
		 */
		
		private function setCurrentCols(cur:CloveColumn):void
		{
			
			_cols[cur.getUID()] = cur;
			
			for each(var c:CloveColumn in Object(cur.children).source)
			{
				setCurrentCols(c);
			}
			
		}
	}
}