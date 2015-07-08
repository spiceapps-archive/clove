package com.spice.air.utils.sql.manage.stmt
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;

	public class SQLiteListStmt extends ConcreteSQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _glue:String;
		private var _prefix:String;
		private var _statements:ArrayCollection;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteListStmt(stmts:Array = null,glue:String = ",")
		{
			
			_statements = new ArrayCollection();
			_statements.addEventListener(CollectionEvent.COLLECTION_CHANGE,onStatementsChange);
			
			this.setList(stmts || [],glue);
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get prefix():String
		{
			return _prefix;
		}
		
		/**
		 */
		
		public function set prefix(value:String):void
		{
			if(_prefix == value)
				return;
			
			_prefix = value;
			this.change();
		}
		
		/**
		 */
		
		public function get glue():String
		{
			return _glue;
		}
		
		/**
		 */
		public function set glue(value:String):void
		{
			if(_glue == value)
				return;
			
			_glue = value;
			this.change();
		}
		
		/**
		 */
		
		public function get statements():ArrayCollection
		{
			return _statements;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function concat(...lists:Array):SQLiteListStmt
		{  
			var thisClone:SQLiteListStmt = SQLiteListStmt(this.clone());
			
			for each(var list:SQLiteListStmt in lists)
			{
				var clone:SQLiteListStmt = SQLiteListStmt(list.clone());
				thisClone.statements.addAll(clone.statements);	
			}
			
			return thisClone;
		}
		/**
		 */
		
		public function setList(stmts:Array,glue:String = ",")
		{
			
			this._statements.source = stmts;
			
			this._glue = glue;
		}
		/**
		 */
		
		override public function toString():String
		{
			if(!_statements.source.length)
				return "";
			
			return (_prefix ? _prefix+" " : "")+_statements.source.join(this._glue);
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			var stmts:Array = new Array(this._statements.length);
			
			for(var i:int = 0; i < stmts.length; i++)
			{
				stmts[i] = this._statements.getItemAt(i).clone();
			}
			
			return new SQLiteListStmt(stmts,this._glue);
		}
		
		/**
		 */
		
		private function onStatementsChange(event:CollectionEvent):void
		{
			if(event.kind != CollectionEventKind.ADD)
				return;
			
			this.addChildStatement(event.items[0]);
		}
	}
}