package com.spice.air.utils.sql.manage.stmt
{
	public class SQLiteColTypeStmt extends ConcreteSQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		
		private var _type:String;
		
		private var _primaryKey:Boolean;
		
		private var _autoIncrement:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteColTypeStmt(name:String,
										  type:String = SQLiteColumnType.TEXT,
										  primaryKey:Boolean = false,
										  autoIncrement:Boolean = false)
		{
			this._name		   = name;
			this._type 		   = type;
			this._primaryKey    = primaryKey;
			this._autoIncrement = autoIncrement;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get name():String
		{
			return this._name;
		}
		/**
		 */
		
		public function set name(value:String):void
		{
			if(_name == value)
				return;
			
			this._name = value;
			
			this.change();
		}
		
		/**
		 */
		
		public function get type():String
		{
			return this._type;
		}
		/**
		 */
		
		public function set type(value:String):void
		{
			if(_type == value)
				return;
			
			this._type = value;
			
			this.change();
		}
		
		/**
		 */
		
		public function get primaryKey():Boolean
		{
			return this._primaryKey;
		}
		/**
		 */
		
		public function set primaryKey(value:Boolean):void
		{
			if(_primaryKey == value)
				return;
			
			this._primaryKey = value;
			
			this.change();
		}
		
		
		/**
		 */
		
		public function get autoIncrement():Boolean
		{
			return _autoIncrement;
		}
		
		public function set autoIncrement(value:Boolean):void
		{
			if(_autoIncrement == value)
				return;
			
			this._autoIncrement = value;
			
			this.change();
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
			return name+" "+_type+(_primaryKey ? " PRIMARY KEY" : "")+(_autoIncrement ? " AUTOINCREMENT" : "");
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteColTypeStmt(_name,_type,_primaryKey,_autoIncrement);
		}
	}
}