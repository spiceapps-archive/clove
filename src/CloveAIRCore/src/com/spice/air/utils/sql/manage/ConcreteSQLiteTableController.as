package com.spice.air.utils.sql.manage
{
	import com.spice.air.utils.sql.manage.cue.SQLBatchCue;
	import com.spice.air.utils.sql.manage.pool.SQLiteManager;
	import com.spice.air.utils.sql.manage.stmt.ISQLiteStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteExprStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteInsertStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteSelectStmt;
	import com.spice.air.utils.sql.manage.stmt.SQLiteUpdateStmt;
	import com.spice.events.QueueManagerEvent;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.utils.queue.cue.Cue;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.flash.gc.Janitor;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	[Event(name="collectionChange",type="mx.events.CollectionEvent")]
	
	public class ConcreteSQLiteTableController extends EventDispatcher implements ISQLiteTableController, IDisposable
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		protected var _selectPaginateStmt:SQLiteSelectStmt;
		protected var _selectAllStmt:SQLiteSelectStmt;
		protected var _insertStmt:SQLiteInsertStmt;
		protected var _selectFirstStmt:SQLiteSelectStmt;
		protected var _selectLastStmt:SQLiteSelectStmt;
		protected var _deleteAllStmt:ISQLiteStmt;
		protected var _truncateStmt:ISQLiteStmt;
		protected var _deleteStmt:ISQLiteStmt;
		protected var _updateStmt:SQLiteUpdateStmt;
		protected var _countStmt:ISQLiteStmt;
		
		
		/**
		 * the DAO that's providing us with all of the statements 
		 */		
		
		protected var _dao:DAOController;
		
		/**
		 * the primary key 
		 */		
		
		protected var _primaryKey:String;
		
		/**
		 * the primary key parameter :param
		 */	
		
		protected var _primaryKeyParam:String;
		
		/**
		 * used for caching the batch cues 
		 */		
		protected var _pool:ObjectPoolManager = ObjectPoolManager.getInstance();
		
		/**
		 * used when reading rows 
		 */		
		
		protected var _readConnection:SQLiteManager;//sync
		
		/**
		 * used when writing, deleting, and updating rows 
		 */		
		
		protected var _writeConnection:SQLiteManager;//async
		
		
		private var _count:int = -1;
		  
		/**
		 * the first item in the database 
		 */		
		protected var _firstIndex:int = -1;
		  
		/**
		 * the last item in the database 
		 */		
		protected var _lastIndex:int = -1;
		
		/**
		 */
		
		private var _janitor:Janitor;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ConcreteSQLiteTableController()
		{
			_janitor = new Janitor();
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get readConnection():SQLConnection
		{
			return this._readConnection.connection;
			
		}
		
		
		public function get writeConnection():SQLConnection
		{
			return this._writeConnection.connection;
			
		}
		
		/**
		 */
		public function get target():ConcreteSQLiteTableController
		{
			return this;
		}
		
		/**
		 */
		
		public function get dao():DAOController
		{
			return _dao;
		}
		
		
		/**
		 */
		public function setSelectOrderBy(value:String,asc:Boolean = false):void
		{
			this._selectAllStmt.setOrderBy(value).ascending(asc);
			this._selectPaginateStmt.setOrderBy(value).ascending(asc);
		}
		
		
		/**
		 */
		
		[Bindable(event="collectionChange")]
		public function get numRows():Number
		{	
			Logger.log("GET NUM ROWS",this);
			
			//save the processing by caching the number of rows
//			if(_count > -1)
//				return _count;
			
			var tg:SQLStatement = this._countStmt.target;
			      
			tg.execute();
			var result:Array = this._countStmt.target.getResult().data;
			_count = 0;
			  
			for each(var col:Object in result)
				for each(var size:int in col)
					_count += size;
			
			return _count;
			
		}
		
		
		
		/**
		 */  
		
//		public function get firstRow():*
//		{
//			if(!_first)
//			{
//				this._selectFirstStmt.target.execute();
//				
//				
//				var result:Array = this._selectFirstStmt.target.getResult().data;
//				
//				_first = result ? result[0] : null;
//			}
//			
//			return _first;
//		}
		
		/**
		 */
		
//		public function get lastRow():*
//		{
//			if(!_last)
//			{
//				this._selectLastStmt.target.execute();
//				var result:Array = this._selectLastStmt.target.getResult().data;
//				
//				_last = result ? result[0] : null;
//			}
//			
//			return _last;
//		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function open(dao:DAOController,file:File,openMode:String = "create"):void
		{
			
			_dao 		= dao;
			
			
			this._readConnection  = this._writeConnection =  SQLiteManager.open(file.nativePath,false);
//			this._writeConnection = SQLiteManager.open(file.nativePath,true);
			
			
			
			this._dao.sqlConnection = _readConnection.connection;
			
			_insertStmt      = SQLiteInsertStmt(dao.getStatement(SQLiteStatementType.INSERT));
			_countStmt       = dao.getStatement(SQLiteStatementType.NUM_ROWS);
			_selectPaginateStmt		 = SQLiteSelectStmt(dao.getStatement(SQLiteStatementType.SELECT_PAGINATE));
			_selectAllStmt   = SQLiteSelectStmt(dao.getStatement(SQLiteStatementType.SELECT_ALL));
			_selectFirstStmt = SQLiteSelectStmt(dao.getStatement(SQLiteStatementType.SELECT_FIRST));
			_selectLastStmt  = SQLiteSelectStmt(dao.getStatement(SQLiteStatementType.SELECT_LAST));
			_deleteAllStmt   = dao.getStatement(SQLiteStatementType.DELETE_ALL);
			_truncateStmt   = dao.getStatement(SQLiteStatementType.TRUNCATE);
			_deleteStmt	     = dao.getStatement(SQLiteStatementType.DELETE);
			_updateStmt      = SQLiteUpdateStmt(dao.getStatement(SQLiteStatementType.UPDATE_ITEM));
			
			//create the table
			dao.getStatement(SQLiteStatementType.CREATE_TABLE).target.execute();
			
			
			this._janitor.addEventListener(_countStmt,Event.CHANGE,onCountStmtChange,false,0,true);
			
			this._primaryKey 	  = _dao.primaryKey;
			this._primaryKeyParam = ":"+_primaryKey;
			
			
			this._insertStmt.target.sqlConnection    = this._writeConnection.connection;
			this._deleteAllStmt.target.sqlConnection = this._writeConnection.connection;
			this._deleteStmt.target.sqlConnection    = this._writeConnection.connection;
			this._updateStmt.target.sqlConnection    = this._writeConnection.connection;
			
			
		}
		/**
		 */
		
		public function insert(items:Array):Cue
		{
			//make abstract
			var initId:Number;
			
			var stmt:SQLStatement = this._insertStmt.target;
			
			//the cols we can insert into the database
			var params:Vector.<String> = this._insertStmt.columns;
			
			
			var cue:SQLBatchCue = _pool.getObject(SQLBatchCue).construct(stmt,items,params);
			cue.addEventListener(QueueManagerEvent.CUE_COMPLETE,onInsertResult);
			this._writeConnection.addCue(cue);
			
			
			if(_count > -1)
			{
				_count = _count + items.length;
			}
			
			
			
			
			
			this._lastIndex = items[items.length-1][this._dao.primaryKey];
			
			
			return cue;
		}
		
		/**
		 */
		
		public function update(items:Array):Cue
		{
			
			var cols:Vector.<String> = this._insertStmt.columns.concat();
			cols.push(this._primaryKey);
			
			var cue:SQLBatchCue = _pool.getObject(SQLBatchCue).construct(this._updateStmt.target,items,cols);
			_writeConnection.addCue(cue);
			return cue;
		}
		
		/**
		 */
		
		public function removeAll(truncate:Boolean = false):void
		{
			_count = -1;
			
			if(truncate)
			{
				this._writeConnection.execute(this._truncateStmt.target).addEventListener(QueueManagerEvent.CUE_COMPLETE,onDeleteAllResult);
			}
			else
			{
				this._writeConnection.execute(this._deleteAllStmt.target).addEventListener(QueueManagerEvent.CUE_COMPLETE,onDeleteAllResult);
			}
			
			this._firstIndex = -1;
			this._lastIndex = -1;
			
		}
		
		
		
		
		/**
		 */
		
		public function remove(stack:Array,limit:Number = 0):Cue
		{
			var start:int = getStartIndex();
			var end:int   = getLastIndex();
			var stmt:SQLStatement = this._deleteStmt.target;
			
			
			var vect:Vector.<String> = new Vector.<String>(1,true);
			vect[0] = this._primaryKey;
			
			for each(var item:* in stack)
			{	
				var i:int = item[this._primaryKey];
				
				if(_firstIndex > -1 && start == i) this._firstIndex = -1;
				if(_lastIndex > -1  && end   == i) this._lastIndex = -1;
				
			}
			//TODO: HAVE THE CUE A "STATEMENT_CUE_STACK"
			var cue:SQLBatchCue = _pool.getObject(SQLBatchCue).construct(stmt,stack,vect);
			cue.addEventListener(QueueManagerEvent.CUE_COMPLETE,onDeleteAllResult);
			this._writeConnection.addCue(cue);
			
			if(_count > -1)
			{
				_count -= stack.length;
			}
			
			return cue;
			
		}
		
		
		/**
		 */
		public function dispose():void
		{
			if(!this._janitor)
				return;
			
			this._janitor.dispose();
			this._janitor = undefined;
		}
		
		
		/**
		 */
		
		public function selectAll():Array
		{
			this._selectAllStmt.target.execute();
			return this._selectAllStmt.target.getResult().data;
		}
		
		/**
		 */
		
		public function paginate(limit:Number = 0,offset:Number = 0):Array
		{
			_selectPaginateStmt.setLimit(limit,offset);
			_selectPaginateStmt.target.execute();
			
			//abstract
			return _selectPaginateStmt.target.getResult().data;
		}
		
		
		/**
		 */
		
		public function reset():void
		{
			this._count = -1;
//			this._last = null;
//			this._first = null;
			this._lastIndex = -1;
			this._firstIndex = -1;
		}
		
		
		//--------------------------------------------------------------------------f
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 * sets the offset for the primary key so the collection_event dispatched is the CORRENT index
		 */
		
		protected function getStartIndex():int
		{
			
			if(this._firstIndex == -1)
			{
				this._selectFirstStmt.target.execute();
				
				var results:Array = this._selectFirstStmt.target.getResult().data;
				
				
				this._firstIndex = results ? results[0][this._dao.primaryKey] : 0;
			}
			
			return this._firstIndex;
		}
		
		protected function getLastIndex():int
		{
			
			if(this._lastIndex == -1)
			{
				this._selectLastStmt.target.execute();
				
				var results:Array = this._selectLastStmt.target.getResult().data;
				
				
				this._lastIndex = results ? results[0][this._dao.primaryKey] : 0;
			}
			
			return this._lastIndex;
		}
		
		
		/**
		 */
		
		protected function onInsertResult(event:QueueManagerEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onInsertResult);
			
			
			
			
			
			this.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,true,false,CollectionEventKind.ADD,-1,-1,event.target.items));
		}
		
		
		/**
		 */
		
		protected function onUpdateResult(event:SQLEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onUpdateResult);
			
			
			
			this.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,true,false,CollectionEventKind.UPDATE,-1,-1,event.target.items));
		}
		
		/**
		 */
		
		protected function onDeleteResult(event:QueueManagerEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onDeleteResult);
			
			
			
			
			//abstract
			this.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,true,false, CollectionEventKind.REMOVE,-1,-1,event.target.items));
			
		}
		
		
		/**
		 */
		
		protected function onDeleteAllResult(event:QueueManagerEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onDeleteAllResult);
			
			this.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,true,false,CollectionEventKind.REMOVE));
		}
		
		/**
		 */
		
		private function onCountStmtChange(event:Event):void
		{
			_count = -1;
		}
		
	}
}