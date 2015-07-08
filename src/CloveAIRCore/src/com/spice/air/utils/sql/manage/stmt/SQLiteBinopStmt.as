package com.spice.air.utils.sql.manage.stmt
{
	import flash.events.EventDispatcher;

	public class SQLiteBinopStmt extends ConcreteSQLiteStmt implements ISQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _rhs:ConcreteSQLiteStmt;
		private var _operator:String;
		private var _lhs:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteBinopStmt(lhs:String,operator:String,rhs:*)
		{
			this._lhs 	  = lhs;
			this._operator = operator;
			this.rhs      = rhs is ConcreteSQLiteStmt ? rhs : new SQLiteValueStmt(rhs);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get lhs():String
		{
			return _lhs;
		}
		
		/**
		 */
		
		public function set lhs(value:String):void
		{
			if(_lhs == lhs)
				return;
			_lhs = value;
			
			this.change();
		}
		
		/**
		 */
		
		public function get operator():String
		{
			return this._operator;
		}
		
		/**
		 */
		
		public function set operator(value:String):void
		{
			if(_operator == value)
				return;
			
			this._operator = value;
			
			this.change();
		}
		
		/**
		 */
		
		public function get rhs():ConcreteSQLiteStmt
		{
			return _rhs;
		}
		
		/**
		 */
		
		public function set rhs(value:ConcreteSQLiteStmt):void
		{
			if(_rhs == value)
				return;
			
			this.swapChildren(_rhs,value); _rhs = value;
			
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
			return _lhs+" "+_operator+" "+_rhs;
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteBinopStmt(_lhs,_operator,_rhs.clone());
		}
	}
}