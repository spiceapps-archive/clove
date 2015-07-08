package com.spice.air.utils.sql.manage
{
	import com.spice.air.utils.sql.manage.stmt.*;
	import com.spice.utils.DescribeTypeUtil;
	import com.spice.vanilla.core.recycle.IDisposable;
	
	import flash.data.SQLConnection;

	public class DAOController implements IDisposable
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _table:String;
		private var _primaryKey:String;
		private var _itemClass:Class;
		private var _columns:Vector.<String>;
		private var _statements:Object = {};
		
		
		//for delete, count, and select
		private var _where:SQLiteWhereStmt;
		private var _sqlConnection:SQLConnection;
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DAOController(target:*,
									  table:String,
									  primaryKey:String = "dbid")
		{
			_itemClass   = target is Class ? target : null;
			_primaryKey  = primaryKey;
			_table       = table;
			
			
			var createStmt:SQLiteCreateTableStmt = new SQLiteCreateTableStmt(_table);
			
			this._columns 	   = new Vector.<String>;
			this.registerStatement(SQLiteStatementType.CREATE_TABLE,createStmt);
			
		
			
			if(_itemClass)
			{
				var info:XML = DescribeTypeUtil.describeCachedType(_itemClass);
				
				var accessors:XMLList = info..accessor.((@access == 'readwrite' || name() == "variable") && @type != 'Function');
				var vars:XMLList = info..variable;
				//accessors.n
				
				for each(var node:XML in accessors)
				{
					this.addCol(node.@name);
				}
				
				for each(var node:XML in vars)
				{
					this.addCol(node.@name);
				}
			}
			else
			//used by History Decorator
			if(target is Array)
			{
				for each(var n:String in target)
				{
					this.addCol(n);
				}
			}
			
			this._columns.fixed = true;
			
			
			var insert:SQLiteInsertStmt = createStmt.toInsertStmt();
			insert.columns.fixed = true;
			insert.parameters.fixed = true;
			
			
			
			
			_where = new SQLiteWhereStmt();
			
			
			var select:SQLiteSelectStmt    = createStmt.toSelectStmt();
			var selectPaginate:SQLiteSelectStmt    = createStmt.toSelectStmt();
			var updateSpecific:SQLiteUpdateStmt = createStmt.toUpdateStmt(true);
			var remove:SQLiteDeleteStmt    = select.toDeleteStmt();
			
			var selectFirst:SQLiteSelectStmt = SQLiteSelectStmt(select.clone());
			selectFirst.setLimit(1).setOrderBy(this._primaryKey).ascending();
			
			var selectLast:SQLiteSelectStmt = SQLiteSelectStmt(selectFirst.clone());
			selectLast.orderBy.ascending(false);
			
//			var update:SQLiteUpdateStmt = new SQLiteUpdateStmt(
			
			var selectAll:SQLiteSelectStmt = SQLiteSelectStmt(select.clone())
			//selectAll.where.value(new SQLiteKeyStmt(this._primaryKey)).and();
			
			var deleteAll:SQLiteDeleteStmt = selectAll.toDeleteStmt();
			var truncate:SQLiteDeleteStmt = selectAll.toDeleteStmt();
			truncate.where = new SQLiteWhereStmt();
			var count:SQLiteSelectStmt 	   = SQLiteSelectStmt(select.clone()).selectKeys(["count(`"+this._primaryKey+"`)"]);
			
			selectPaginate.where	  = _where;
			selectAll.where   = _where; //SELECT * FROM `table` WHERE `primaryKey` AND ...
			deleteAll.where   = _where; //DELETE FROM `table` WHERE `primaryKey` AND ...
			selectFirst.where = _where;
			selectLast.where  = _where;
			count.where      = _where;
			
			
			this.registerStatement(SQLiteStatementType.INSERT,insert);  
			this.registerStatement(SQLiteStatementType.SELECT,select);
			this.registerStatement(SQLiteStatementType.SELECT_FIRST,selectFirst);
			this.registerStatement(SQLiteStatementType.SELECT_LAST,selectLast);
			this.registerStatement(SQLiteStatementType.SELECT_PAGINATE,selectPaginate);
			this.registerStatement(SQLiteStatementType.DELETE,remove);
			this.registerStatement(SQLiteStatementType.SELECT_ALL,selectAll);
			this.registerStatement(SQLiteStatementType.DELETE_ALL,deleteAll);
			this.registerStatement(SQLiteStatementType.TRUNCATE,truncate);
			this.registerStatement(SQLiteStatementType.NUM_ROWS,count);
			this.registerStatement(SQLiteStatementType.UPDATE_ITEM,updateSpecific);
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get sqlConnection():SQLConnection
		{
			return this._sqlConnection;
		}
		
		/**
		 */
		
		public function set sqlConnection(value:SQLConnection):void
		{
			this._sqlConnection = value;
			
			//set the sqlConnection to all the statements
			for each(var stmt:ISQLiteStmt in this._statements)
			{
				stmt.target.sqlConnection = value;
			}
		}
		
		/**
		 */
		
		public function get where():SQLiteWhereStmt
		{
			return this._where;
		}
		
		/**
		 */
		
		public function get columns():Vector.<String>
		{
			return this._columns;
		}
		
		/**
		 */
		
		public function get itemClass():Class
		{
			return this._itemClass;
		}
		
		/**
		 */
		
		public function get primaryKey():String
		{
			return this._primaryKey;
		}
		
		/**
		 */
		
		public function get table():String
		{
			return this._table;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function dispose():void
		{
			this.sqlConnection = null;
		}
		/**
		 */
		
		public function getStatement(name:String):ISQLiteStmt
		{
			return this._statements[name];
		}
		
		
		/**
		 */
		
		public function registerStatement(name:String,stmt:ISQLiteStmt):void
		{
			this._statements[name] = stmt;
			
			if(this._sqlConnection)
			{
				stmt.target.sqlConnection = this._sqlConnection;
			}
			
			
			//set the item class if it exists
			if(this._itemClass)
			{
				if(name.indexOf("select") > -1)
				{
					stmt.target.itemClass = this._itemClass;
				}
			}
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function addCol(n:String):void
		{
			_columns.push(n);
			
			if(n == this._primaryKey)
			{
				_statements[SQLiteStatementType.CREATE_TABLE].addColumn(n, SQLiteColumnType.INTEGER,true,true);
			}
			else
			{
				_statements[SQLiteStatementType.CREATE_TABLE].addColumn(n);
			}
			
		}
		
		
	}
}