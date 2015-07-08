package com.spice.air.utils.sql.manage.stmt
{
	public class SQLiteDeleteStmt extends ConcreteSQLiteStmt
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		private var _from:String;
		
		
		
		private var _where:SQLiteWhereStmt;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteDeleteStmt(from:String,
										 where:SQLiteWhereStmt = null)
		{    
			this._from = from;
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
		
		public function set from(value:String):void
		{
			if(_from == value)
				return;
			
			_from = value;
			
			this.change();
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
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteDeleteStmt(_from,
									    SQLiteWhereStmt(_where.clone()));
		}
		
		
		/**
		 */
		
		override public function toString():String
		{
			return "DELETE FROM "+_from.toString()+" "+this._where;
		}
	}
}