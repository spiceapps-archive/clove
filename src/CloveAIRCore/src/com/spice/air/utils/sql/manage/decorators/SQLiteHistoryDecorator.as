package com.spice.air.utils.sql.manage.decorators
{
	import com.spice.air.utils.sql.manage.ConcreteSQLiteTableController;
	import com.spice.air.utils.sql.manage.DAOController;
	import com.spice.air.utils.sql.manage.ISQLiteTableController;
	import com.spice.air.utils.sql.manage.SQLiteStatementType;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.utils.setTimeout;

	public class SQLiteHistoryDecorator extends SQLiteDecorator
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _checkKey:String;
		private var _deletedItems:Object;
		private var _history:DAOController;
		private var _historyController:ConcreteSQLiteTableController;
		
		
		public static const DUMP_HIST_TIME:Number = 30000;//30 secs
		
		
		public static const ORG_SELECT_UIDS:String = "orgSelectUIDs";
		public static const SELECT_UIDS:String = "selectUIDs";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteHistoryDecorator(target:ISQLiteTableController,
											   checkKey:String,
											   ommitColumns:Array = null)
		{
			super(target);
			
			/*ommitColumns = ommitColumns ? ommitColumns : [];
			
			_checkKey = checkKey;
			_deletedItems;
			
			
			var cols:Array = [];
			
			for each(var col:String in target.dao.columns)
			{
				if(ommitColumns.indexOf(col) > -1)
					continue;
				
				cols.push(col);
			}
			
			var stmtCols:Array = cols.concat();
			
			cols.push("deleteDate");
			cols.push("lastAccessed");
			
			
			//the history controller for the deleted items
			_history = new DAOController(cols,target.dao.table+"_history");
			_historyController = new ConcreteSQLiteTableController(_history,target.sqlConnection);
			
			
			
			//the insert cols
			var cols2:String = _history.builder.implode(_history.columns,"`$1`",",",["dbid"]);
			var vals:String = _history.builder.implode(stmtCols,"OLD.$1",",",["dbid"]);
			
			
			var build:SQLiteStatementBuilder = new SQLiteStatementBuilder(_history);
			
			
			//the insert statement to execute when an item has been deleted
			build.registerStatement("insertDeleted","INSERT INTO `"+_history.table+"` ("+cols2+") VALUES("+vals+",datetime('now'),date('now'))");
			
			
			//create the delete trigger that will listen for when items are trashed
			var trigger:SQLiteTrigger = new SQLiteTrigger(dao.table+"_add_to_deleted","DELETE","AFTER");
			trigger.createTrigger(this.target,build);
			
			_builder = new SQLiteStatementBuilder(_history);*/
			
			//var stmt:String = 
			///_builder.registerStatement(
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function insert(items:Array):Cue
		{
			var useable:Array = [];
			
			if(!this._deletedItems)
			{
				this.selectAll();
			}
			
			
			//if the inserted item has been trashed, then don't re-add it.
			for each(var item:Object in items)
			{
				if(_deletedItems[item[_checkKey]])
					continue;
				
				useable.push(item);
			}
			
			if(useable.length > 0)
				return super.insert(useable);
			
			return null;
		}
		
		/**
		 */
		
		public function hasItem(uid:Boolean):Boolean
		{
			return this._deletedItems[uid];
		}
		
		
		/**
		 */
		
		override public function remove(items:Array, limit:Number=0):Cue
		{
			if(_deletedItems)
			{
				for each(var item:Object in items)
				{
					_deletedItems[item[_checkKey]] = 1;
				}
			}
			return super.remove(items);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function selectAllHist():void
		{
			
			//dump the history hafter a certain time
			flash.utils.setTimeout(dumpHist,DUMP_HIST_TIME);
			
			//grab the deleted
			//target.dao.builder.select().
			var allHistory:Array = this._historyController.selectAll().concat(this.target.selectAll());
			
			
			this._deletedItems = {};
			
			for each(var item:Object in allHistory)
			{
				this._deletedItems[item[this._checkKey]] = 1;
			}
		}
		
		/**
		 */
		
		private function dumpHist():void
		{
			this._deletedItems = null;
		}
	}
}