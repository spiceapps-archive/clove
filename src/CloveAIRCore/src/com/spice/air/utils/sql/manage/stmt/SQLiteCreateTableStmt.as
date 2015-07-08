package com.spice.air.utils.sql.manage.stmt
{
	public class SQLiteCreateTableStmt extends ConcreteSQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _table:String;
		
		private var _columns:SQLiteListStmt;
		
		private var _primary:SQLiteColTypeStmt;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteCreateTableStmt(table:String,columns:SQLiteListStmt = null)
		{
			this._table = table;
			this.columns = columns || new SQLiteListStmt();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get table():String
		{
			return this._table;
		}
		
		/**
		 */
		
		public function set table(value:String):void
		{
			if(_table == value)
				return;
			
			_table = value;
			
			this.change();
		}
		
		/**
		 */
		
		public function get columns():SQLiteListStmt
		{
			return _columns;
		}
		
		/**
		 */
		
		public function set columns(value:SQLiteListStmt):void
		{
			if(_columns == value)
				return;
			
			this.swapChildren(_columns,value); _columns = value;
		}
		
		/**
		 */
		
		public function get primary():SQLiteColTypeStmt
		{
			return this._primary;
		}
		    
		/**
		 */
		
		public function set primary(value:SQLiteColTypeStmt):void
		{
			if(_primary == value)
				return;
			
			this.swapChildren(_primary,value); _primary = value;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function toSelectStmt():SQLiteSelectStmt
		{
			var sel:Vector.<String> = new Vector.<String>();
			
			for each(var col:SQLiteColTypeStmt in this.columns.statements.source)
			{
				sel.push(col.name);
			}
			
			
			return new SQLiteSelectStmt(table,sel);
		}
		
		
		/**
		 */
		
		public function toUpdateStmt(singleUpdate:Boolean = false):SQLiteUpdateStmt
		{
			var update:SQLiteUpdateStmt = new SQLiteUpdateStmt(this._table);
			
			for each(var col:SQLiteColTypeStmt in this._columns.statements.source)
			{
				if(this._primary && col.name == _primary.name)
					continue;
				  
				update.setValue(col.name,":"+col.name);
			}
			
			if(singleUpdate && this._primary)
			{  
				update.where.equals(this._primary.name,":"+this._primary.name);
			}
			
			return update;
			
		}
		
		/**
		 */
		
		public function toDeleteStmt():SQLiteDeleteStmt
		{
			return this.toSelectStmt().toDeleteStmt();	
		}
		
		/**
		 */
		
		public function toInsertStmt():SQLiteInsertStmt
		{
			var insert:SQLiteInsertStmt = new SQLiteInsertStmt(this.table);
			
			
			for each(var col:SQLiteColTypeStmt in this.columns.statements.source)
			{
				if(col.primaryKey)
					continue;
				
				insert.insert(col.name,":"+col.name);
			}
			
			return insert;
		}
		
		/**
		 */
		
		public function addColumn(name:String,
								  type:String = SQLiteColumnType.TEXT,
								  primaryKey:Boolean = false,
								  autoIncrement:Boolean = false):void
		{
			var stmt:SQLiteColTypeStmt = new SQLiteColTypeStmt(name,type,primaryKey,autoIncrement);
			
			if(primaryKey)
			{
				if(this._primary)
				{
					this._primary.primaryKey = false;
				}
				
				this._primary = stmt;
			}
			
			_columns.statements.addItem(stmt);
		}
		
		/**
		 */
		
		override public function toString():String
		{
			return "CREATE TABLE IF NOT EXISTS "+_table+" ("+this._columns+")";
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteCreateTableStmt(this._table,
											 SQLiteListStmt(this._columns.clone()));
		}
	}
}