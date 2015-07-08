package com.spice.clove.plugin.core.root.desktop.history
{
	import com.spice.air.utils.sql.manage.ConcreteSQLiteTableController;
	import com.spice.air.utils.sql.manage.DAOController;
	import com.spice.air.utils.sql.manage.SQLiteStatementType;
	import com.spice.air.utils.sql.manage.stmt.SQLiteCreateTriggerStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteDeleteStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteExprStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteInsertStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteSelectStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteUpdateStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteWhereStmt;
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.content.data.CloveDesktopData;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.root.desktop.CloveDesktopRootPlugin;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBindingObserver;

	/**
	 * checks the history if an item exists 
	 * @author craigcondon
	 * 
	 */	
	
	public class CloveDataHistoryController implements IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
//		private var _selectDeletedStmt:SQLiteSelectStmt;
//		private var _selectHistStmt:SQLiteSelectStmt;
//		private var _deleteAllStmt:SQLiteDeleteStmt;
//		private var _truncateTrashStmt:SQLiteDeleteStmt;
		private var _deleteHistStmt:SQLiteDeleteStmt;
		private var _selectAllUIDsStmt:SQLiteSelectStmt;
//		private var _updateStmt:SQLiteUpdateStmt
		
//		private var _deletedHistDAO:DAOController;
		private var _columnDataDAO:DAOController;
		
//		private var _deleteController:ConcreteSQLiteTableController;
		private var _columnHistController:ConcreteSQLiteTableController;
		
		private var _allHistory:Object;
//		private var _allDeletedHistory:Object;
//		private var _usedDeletedHistory:Object;
		
		private var _plugin:CloveDesktopRootPlugin;
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveDataHistoryController(plugin:CloveDesktopRootPlugin)
		{
//			_deletedHistDAO = new DAOController(['columnDataUID','clearedDate','lastAccessed'],'deleted_column_data_history');
			_columnDataDAO  = new DAOController(CloveDesktopData,"column_history");	
			
			
//			_deleteController = new ConcreteSQLiteTableController();
			_columnHistController = new ConcreteSQLiteTableController();
			
//			_deleteController.open(_deletedHistDAO,plugin.databaseFile);
			_columnHistController.open(_columnDataDAO,plugin.databaseFile);
			
			_selectAllUIDsStmt = SQLiteSelectStmt(_columnDataDAO.getStatement(SQLiteStatementType.SELECT_ALL).clone());
			
			
//			
//			
//			var insertStmt:SQLiteInsertStmt = new SQLiteInsertStmt("deleted_column_data_history");
//			insertStmt.insert("columnDataUID","OLD.columnDataUID");
//			insertStmt.insert("clearedDate","date('now')");
//			insertStmt.insert("lastAccessed","date('now')");
//			
//			
//			var trigger:SQLiteCreateTriggerStmt = new SQLiteCreateTriggerStmt("register_deleted_data_trigger","column_history");
//			trigger.forEachRow.statements.addItem(insertStmt);
//			
//			_deletedHistDAO.registerStatement("createDeleteTrigger",trigger);
//			try
//			{
//				trigger.target.execute();
//			
//			
//			}catch(e:Error)
//			{
//				Logger.logError(e);
//			}
//			
//			_usedDeletedHistory = {};
//			
//			_selectDeletedStmt = SQLiteSelectStmt(_deletedHistDAO.getStatement(SQLiteStatementType.SELECT_ALL));
//			_deleteAllStmt     = SQLiteDeleteStmt(_deletedHistDAO.getStatement(SQLiteStatementType.DELETE_ALL).clone());
			_deleteHistStmt     = SQLiteDeleteStmt(_columnDataDAO.getStatement(SQLiteStatementType.DELETE_ALL));
//			this._deleteHistStmt.target.sqlConnection = this._columnHistController.readConnection;
//			_deleteAllStmt.target.sqlConnection = _selectDeletedStmt.target.sqlConnection;
//			this._deleteAllStmt.where.lessThan("lastAccessed","datetime('now','-1 day')");
//			
//			_truncateTrashStmt = SQLiteDeleteStmt(this._deleteAllStmt.clone());
//			_truncateTrashStmt.target.sqlConnection = this._selectDeletedStmt.target.sqlConnection;
//			_truncateTrashStmt.where = new SQLiteWhereStmt();
//			
//			_updateStmt 	   = new SQLiteUpdateStmt(_deletedHistDAO.table);
//			_updateStmt.setValue("lastAccessed","date('now')");
//			
//			_deletedHistDAO.registerStatement(SQLiteStatementType.UPDATE_ITEM,_updateStmt);
//			
//			_selectHistStmt    = SQLiteSelectStmt(_columnDataDAO.getStatement(SQLiteStatementType.SELECT_ALL));
//			
//			_selectDeletedStmt.selectKeys(["columnDataUID"]);
//			_selectHistStmt.selectKeys(["columnDataUID"]);
//			_selectDeletedStmt.target.itemClass = _selectHistStmt.target.itemClass = null;
			
			
			
			_plugin = plugin;
			
			//listen for on close
			plugin.getProxyController().addProxyCallObserver(new ProxyBindingObserver(CallClovePluginType.APPLICATION_CLOSING,this));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function truncateTrash():void
		{
//			_truncateTrashStmt.target.execute();
//			this._allDeletedHistory  = {};
//			this._usedDeletedHistory = {};
			this._allHistory 		 = {};
		}
		/**
		 */
		
		public function registerIfDoesNotExist(uid:String):Boolean
		{
			if(!_allHistory)
			{
				this.getAllHistory();
			}
			
			if(_allHistory[uid])
			{
				return false;
			}
			
//			if(_allDeletedHistory[uid])
//			{
//				_usedDeletedHistory[uid] = 1;
//				return false;
//			}
			
			this._allHistory[uid] = 1;
			
			return true;
		}
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			try
			{
				switch(n.getType())
				{
					case CallClovePluginType.APPLICATION_CLOSING: return this.applicationClosing();
				}
			}catch(e:*)
			{
				Logger.logError(e);
			}
		}
//		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		private function getAllHistory():void
		{
			this._allHistory = {};
//			this._allDeletedHistory = {};
//			var allHist:Array = _deleteController.selectAll();
//			
//			for each(var item:Object in allHist)
//			{
//				this._allDeletedHistory[item.columnDataUID] = 1;
//			}
//			
			var allHist:Array = this._columnHistController.selectAll();
			
			for each(var item:Object in allHist)
			{
				this._allHistory[item.columnDataUID] = 1;
			}
		}
		
		/**
		 */
		
		private function applicationClosing():void
		{	
			
//			//cleanup the database after use 
//			var cur:SQLiteExprStmt = _updateStmt.where;
//			
//			var useUpdate:Boolean;
//			
//			for(var i:String in this._usedDeletedHistory)
//			{
//				cur = cur.equals('columnDataUID',i).or();
//				useUpdate = true;
//			}
//			
//			//update all used history items so we know NOT to delete them
//			if(useUpdate)
//			{
//				_updateStmt.target.execute();
//			}
//			
//			
//			//delete all unused data
//			this._deleteAllStmt.target.execute();
//			
//			
//			//now delete all columns that don't exist
//			this.findColumnsToOmmit(this._plugin.getRootColumn(),this._deleteHistStmt.where);
//			
//			this._deleteHistStmt.target.execute();
			
			this._columnHistController.readConnection.compact();
//			this._deleteAllStmt.target.sqlConnection.compact();
		}
		
		
		/**
		 */
		
//		private function findColumnsToOmmit(target:CloveColumn,stmt:SQLiteExprStmt):SQLiteExprStmt
//		{
//			stmt = stmt.notEquals("columnID",target.id).and();
//			
//			for each(var child:CloveColumn in Object(target.children).source)
//			{
//				stmt = this.findColumnsToOmmit(child,stmt);
//			}
//			
//			return stmt;
//		}
	}
}