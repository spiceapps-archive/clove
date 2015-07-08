package com.spice.air.utils.sql.manage.stmt
{
	
	public class SQLiteValueStmt extends ConcreteSQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _value:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteValueStmt(value:String)
		{
			this._value = value;
		}
		
		/**
		 */
		
		public function get value():String
		{
			return _value;
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
			return value;
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteValueStmt(this._value);
		}
	}
}