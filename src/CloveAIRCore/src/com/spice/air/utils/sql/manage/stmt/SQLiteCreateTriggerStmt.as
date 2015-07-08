package com.spice.air.utils.sql.manage.stmt
{
	public class SQLiteCreateTriggerStmt extends ConcreteSQLiteStmt
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _forEachRow:SQLiteListStmt;
		
		
		private var _type:String;
		
		
		private var _event:String;
		
		
		private var _name:String;
		
		
		private var _targetTable:String;
		
		
		private var _when:SQLiteExprStmt;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteCreateTriggerStmt(name:String,
												targetTable:String,
												type:String = "AFTER",
												event:String = "DELETE",
												forEachRow:SQLiteListStmt = null,
												when:SQLiteExprStmt = null)
		{
			this._name 		 = name
			this._targetTable = targetTable;
			this._type 	     = type;
			this._event 		 = event;
			this.forEachRow  = forEachRow || new SQLiteListStmt();
			this.when 		 = when || new SQLiteExprStmt();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get when():SQLiteExprStmt
		{
			return this._when;
		}
		
		/**
		 */
		
		public function set when(value:SQLiteExprStmt):void
		{
			if(_when == value)
				return;
			
			this.swapChildren(_when,value); _when = value;
		}
		
		/**
		 */
		
		public function get forEachRow():SQLiteListStmt
		{
			return this._forEachRow;
		}
		
		/**
		 */
		
		public function set forEachRow(value:SQLiteListStmt):void
		{
			if(_forEachRow == value)
				return;
			
			this.swapChildren(_forEachRow,value); _forEachRow = value;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function insertForEach(item:ISQLiteStmt):void
		{
			this.forEachRow.statements.addItem(item);
		}
		
		/**
		 */
		
		override public function toString():String
		{
			this.when.prefix = "WHEN";
			this.forEachRow.glue = ";";
			
			return "CREATE TRIGGER IF NOT EXISTS "+_name+" "+_type+" "+_event+" ON "+_targetTable+" FOR EACH ROW "+_when+" BEGIN "+this._forEachRow+"; END";
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteCreateTriggerStmt(_name,
											   _targetTable,
											   _type,
											   _event,
											   SQLiteListStmt(_forEachRow.clone()),
											   SQLiteExprStmt(_when.clone()));
		}
	}
}