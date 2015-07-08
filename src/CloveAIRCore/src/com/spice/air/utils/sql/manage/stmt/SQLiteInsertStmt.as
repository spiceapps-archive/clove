package com.spice.air.utils.sql.manage.stmt
{
	public class SQLiteInsertStmt extends ConcreteSQLiteStmt
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _cols:Vector.<String>;
		private var _params:Vector.<String>;
		private var _table:String;
		private var _values:SQLiteListStmt;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteInsertStmt(table:String)
		{
			_table = table;
			this._cols = new Vector.<String>;
			this._params = new Vector.<String>;
			this._values = new SQLiteListStmt();
			
			this.addChildStatement(this._values);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get columns():Vector.<String>
		{
			return _cols;
		}
		
		/**
		 */
		
		public function get parameters():Vector.<String>
		{
			return this._params;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function insert(key:String,value:*):void
		{
			this._cols.push(key);
			this._params.push(":"+key);
			this._values.statements.addItem(value is ISQLiteStmt ? value : new SQLiteValueStmt(value));
			
			this.change();
		}
		
		
		/**
		 */
		
		override public function toString():String
		{
			return "INSERT INTO "+this._table+" ("+_cols.join(",")+") VALUES("+_values+")";
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			var insert:SQLiteInsertStmt = new SQLiteInsertStmt(_table);
			
			for(var i:int = 0; i < this._cols.length; i++)
			{
				insert.insert(this._cols[i],this._values.statements.getItemAt(i).clone());
			}
			
			return insert;
		}
	}
}