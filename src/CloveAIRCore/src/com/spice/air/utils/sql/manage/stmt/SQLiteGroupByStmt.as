package com.spice.air.utils.sql.manage.stmt
{
	import com.spice.air.utils.sql.manage.stmt.ISQLiteStmt;
	
	public class SQLiteGroupByStmt extends ConcreteSQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		private var _key:String;
		
		private var _having:SQLiteHavingStmt;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteGroupByStmt(key:String = null,having:SQLiteHavingStmt = null)
		{
			this.setGroupBy(key);
				
			this.having = having;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get key():String
		{
			return _key;
		}
		
		/**
		 */
		
		public function set key(value:String):void
		{
			if(_key == value)
				return;
			
			_key = value;
			this.change();
		}
		
		/**
		 */
		
		public function get having():SQLiteHavingStmt
		{
			return _having;
		}
		
		/**
		 */
		public function set having(value:SQLiteHavingStmt):void
		{
			if(_having == value)
				return;
			
			this.swapChildren(_having,value); _having = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setGroupBy(key:String = null):SQLiteGroupByStmt
		{
			if(key)
			{
				this._key = key;
				
				if(!having)
				{
					this.having = new SQLiteHavingStmt();
				}
				
			}
			
			return this;

		}
		
		/**
		 */
		
		override public function toString():String
		{
			if(!key)
				return "";
			
			return "GROUP BY "+_key+" "+_having;
			
			
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteGroupByStmt(_key,SQLiteHavingStmt(_having));
		}
		
		
	}
}