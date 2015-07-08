package com.spice.air.utils.sql.manage.stmt
{
	public class SQLiteOrderByStmt extends ConcreteSQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _orderType:String;
		private var _key:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteOrderByStmt(key:* = null)
		{
			this.setOrderBy(key);
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
			
			_key= value;
			this.change();
		}
		
		/**
		 */
		
		public function get orderType():String
		{
			return _orderType;
		}
		
		/**
		 */
		public function set orderType(value:String):void
		{
			if(_orderType == value)
				return;
			_orderType = value;
			this.change();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setOrderBy(key:String):void
		{
			if(key)
				this.key = key;
		}
		
		/**
		 */
		
		public function ascending(value:Boolean = true):SQLiteOrderByStmt
		{
			this._orderType = value ? "ASC" : "DESC";
			return this;
		}
		
		/**
		 */
		
		override public function toString():String
		{
			if(!this._key)
				return "";
			
			return "ORDER BY "+this.key+(this._orderType ? " "+this._orderType : "");
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteOrderByStmt(this._key);
		}
	}
}