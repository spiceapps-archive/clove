package com.spice.air.utils.sql.manage.stmt
{
	public class SQLiteUpdateStmt extends ConcreteSQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		 
		private var _from:String; 
		private var _set:SQLiteListStmt;
		private var _where:SQLiteWhereStmt;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteUpdateStmt(from:String,
										 set:SQLiteListStmt = null,
										 where:SQLiteWhereStmt = null)
		{
			this._from  = from;
			this.set   = set || new SQLiteListStmt();
			this.where = where || new SQLiteWhereStmt();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get from():String
		{
			return _from;
		}
		
		/**
		 */
		
		public function get set():SQLiteListStmt
		{
			return _set;
		}
		
		/**
		 */
		
		public function set set(value:SQLiteListStmt):void
		{
			if(_set == value)
				return;
			this.swapChildren(_set,value); _set = value;
		}
		
		/**
		 */
		
		public function get where():SQLiteWhereStmt
		{
			return _where;
		}
		
		/**
		 */
		
		public function set where(value:SQLiteWhereStmt):void
		{
			if(_where == value)
				return;
			this.swapChildren(_where,value); _where = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function setValue(key:String,value:*):void
		{
			this.set.statements.addItem(new SQLiteBinopStmt(key,'=',value is ISQLiteStmt ? value : new SQLiteValueStmt(value)));	
		}
		
		/**
		 */
		
		override public function toString():String
		{
			this._set.prefix = "SET";
			
			return "UPDATE "+_from+" "+this._set+" "+this._where;
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteUpdateStmt(_from,
										SQLiteListStmt(_set.clone()),
										SQLiteWhereStmt(_where.clone()));
		}
	}
}