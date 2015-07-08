package com.spice.clove.plugin.core.root.desktop.history
{
	import com.spice.air.collections.SQList;
	import com.spice.air.utils.sql.manage.*;
	import com.spice.air.utils.sql.manage.decorators.*;
	import com.spice.air.utils.sql.manage.stmt.SQLiteExprStmt;
	import com.spice.clove.events.ColumnHistoryEvent;
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.column.column_internal;
	import com.spice.clove.plugin.content.data.CloveDesktopData;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.root.desktop.CloveDesktopRootPlugin;
	import com.spice.clove.plugin.core.root.impl.history.ConcreteColumnHistory;
	import com.spice.clove.plugin.impl.content.control.ContentSaveType;
	import com.spice.clove.plugin.impl.content.data.CloveMetadataType;
	import com.spice.vanilla.core.notifications.Notification;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import flash.utils.ByteArray;
	
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	use namespace column_internal;

	public class ColumnSQLHistory extends ConcreteColumnHistory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _list:SQList;
		private var _plugin:CloveDesktopRootPlugin;
		private var _histController:CloveDataHistoryController;
		
		
		private var _daoController:DAOController;
		private var _sqliteController:ConcreteSQLiteTableController;
		private var _fillingOlder:Boolean;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ColumnSQLHistory(target:CloveColumn,plugin:CloveDesktopRootPlugin,data:ByteArray = null)
		{
			
			_plugin = plugin;
			
			
			
			_daoController = new DAOController(CloveDesktopData,"column_history");
			
			_sqliteController = new ConcreteSQLiteTableController();
			_sqliteController.open(_daoController,plugin.databaseFile);
			_histController = _plugin.getDeletedDataController();
			
			_sqliteController.setSelectOrderBy("datePosted",false);
			
			super(target,plugin,data);
			
			
			this._janitor.addDisposable(this._daoController);
			this._janitor.addDisposable(this._sqliteController);
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function removeAllItems(removeDeleted:Boolean = false):void
		{
			this.target.getNumUnread().setData(0);
			
			//children go first
			for each(var target:CloveColumn in Object(this.target.children).source)
			{
				target.history.removeAllItems();
				
			}
			
			this._sqliteController.removeAll(this.target.parent == null);
			
			if(this.target.parent == null || removeDeleted) 
			{
				this._plugin.getDeletedDataController().truncateTrash();
			}
			
			
		}
		
		
		
		
		/**
		 */
		
		override public function addHistory(items:Array,fillType:int = ContentSaveType.FILL_NEW,isOlder:Boolean = false):void
		{
			_fillingOlder = isOlder;
			
			var ir:ICloveDataRenderer = this._target.itemRenderer;
			
			if(!ir)
			{
				throw new Error("cannot add history without an item renderer");
			}
			
			var usable:Array = [];
			
			
			for each(var item:* in items)
			{
				
				//unique content ONLY pertains to the columns they're running in
				var id:String = this._target.itemRenderer.getUID(item)+this.id;
				
				
				if(!_histController.registerIfDoesNotExist(id))
					continue;
				
				//if(exists)
				//continue
				
				var data:CloveDesktopData = new CloveDesktopData();
				
				
				if(!ir.setCloveData(item,data))
				{
					data.dispose();
					data = null;
					continue;
				}
				
				data.columnid = this.id;  
				data.columnDataUID = id;
				
				usable.push(data);
			}
			
			data = null;
			
			if(usable.length > 0)
			{
				this._target.addNumUnread(usable.length);
				this._sqliteController.insert(usable);//.addEventListener(QueueManagerEvent.CUE_COMPLETE,onInsertResult);
				
				
				//notify any global listeners of the new data
				this._plugin.getPluginMediator().notifyBoundObservers(new Notification(CallAppCommandType.DATA_PROCESSED,usable));
			}
			
			usable = null;
			
		}
		
		
		/**
		 */
		
		public function update(items:Array):void
		{
			
			this._sqliteController.update(items);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function init2():void
		{
			_list = new SQList(this._sqliteController);
			_list.everyNewItem = linkCloveData;
			
			this._janitor.addEventListener(this._sqliteController,CollectionEvent.COLLECTION_CHANGE,this.onSQLChange,false,0,true);
			
			this.setList(_list);
			
			super.init2();
			
		}
		/**
		 */
		
		override protected function setOrderBy(value:Object):void
		{
			this._sqliteController.setSelectOrderBy(value.key,value.asc);
		}

		/**
		 */
		
		override protected function  onChildrenChange(event:CollectionEvent=null):void
		{
			super.onChildrenChange(event);
			
			
			if(event)
			{
				switch(event.kind)
				{
					case CollectionEventKind.ADD:
					case CollectionEventKind.REMOVE:
						this.refreshWhereStmt();
				}
			}
			else
			{
				this.refreshWhereStmt();
				
			}
			
			
			if(!event || event.kind != CollectionEventKind.UPDATE)
			this.dispatchEvent(new CollectionEvent(ColumnHistoryEvent.HISTORY_CHANGE,true,true,CollectionEventKind.RESET));
			
		}
		
		
		/**
		 */
		
		override protected function onChildrenHistoryChange(event:CollectionEvent):void
		{
			super.onChildrenHistoryChange(event);
			
			
			if(!_list)
				return;
			
			
			
			this._sqliteController.reset();
			
			//there is a funky bug within Clove that doesn't allow the smoothList to listen to remove events
			if(event.kind == CollectionEventKind.REMOVE)
			{
				this._list.update();
			}
			else
			{
				this._list.reset();
			}
			
//			this._list.update();
			
			
			this._list.dispatchEvent(this.cloneCollectionEvent(CollectionEvent.COLLECTION_CHANGE,event));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function linkCloveData(data:CloveDesktopData):void
		{
			data.setColumn(ClovePluginColumn(this._plugin.getHistoryController(data.columnid).target));
			data.setColumnHistory(this);//for updating, and deleting
		}
		
		/**
		 */
		
		private function onSQLChange(event:CollectionEvent):void
		{
			
			if(event.kind == CollectionEventKind.ADD)
			{
				if(this._fillingOlder)
				{
					event.location = int.MAX_VALUE;
				}
				
			}
			
			
			
			this.bubbleUpHistoryChange(event);
		}
		
		
		/**
		 */
		
		private function refreshWhereStmt():void
		{
			var where:SQLiteExprStmt = new SQLiteExprStmt();
			where.ignoreChange();
			
			this.constructStmt(where,this.target);
			where.listenForChange();
			
			
			this._daoController.where.copyFrom(where);
			
			
			
			Logger.log("Refreshing WHERE stmt "/*+this._daoController.where*/,this);
		}
		
		
		
		/**
		 */
		
		private function constructStmt(exp:SQLiteExprStmt,cur:CloveColumn):SQLiteExprStmt
		{
			
			if(cur.history)
				exp = exp.equals("columnid",cur.history.id).or();
			
			
			
			for each(var child:CloveColumn in Object(cur.children).source)
			{
				exp = this.constructStmt(exp,child);
			}
			
			return exp;
		}
		
	}
}