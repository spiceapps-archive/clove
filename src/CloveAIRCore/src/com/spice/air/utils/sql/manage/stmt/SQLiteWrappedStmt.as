package com.spice.air.utils.sql.manage.stmt
{
	
	public class SQLiteWrappedStmt extends ConcreteSQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _statement:ConcreteSQLiteStmt;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteWrappedStmt(target:ISQLiteStmt = null)
		{
			this.statement = ConcreteSQLiteStmt(statement);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get statement():ConcreteSQLiteStmt
		{
			return _statement;
		}
		
		/**
		 */
		
		public function set statement(value:ConcreteSQLiteStmt):void
		{
			if(_statement == value)
				return;
			
			this.swapChildren(_statement,value); _statement = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function toString():String
		{
			if(!target)
				return "";
			
			return _statement.toString();
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteWrappedStmt(_statement ? _statement.clone() : null);
		}
	}
}