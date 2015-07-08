package com.spice.air.utils.sql.manage.stmt
{
	public class SQLiteLimitStmt extends ConcreteSQLiteStmt
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		private var _rows:Number;
		private var _offset:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteLimitStmt(rows:Number = NaN,offset:Number = NaN)
		{
			this.setLimit(rows,offset);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get rows():Number
		{
			return _rows;
		}
		
		/**
		 */
		public function get offset():Number
		{
			return _offset;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function setLimit(rows:Number = NaN,offset:Number = NaN):void
		{
			this._rows 	= rows;
			this._offset = offset;
			
			
			this.setParameter(":limit",isNaN(rows) ? undefined : rows);
			this.setParameter(":offset",isNaN(offset) ? undefined : offset);
			
		}
		/**
		 */
		
		override public function toString():String
		{
			if(isNaN(_rows))
				return "";
			
			if(!isNaN(_offset))
				return "LIMIT :offset, :limit";
			
			return "LIMIT :limit";
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteLimitStmt(_rows,_offset);
		}
	}
}