package com.spice.air.utils.sql.manage.stmt
{
	import flash.events.Event;

	public class SQLiteExprStmt extends ConcreteSQLiteStmt
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _lhs:ISQLiteStmt;
		private var _op:String;
		private var _rhs:SQLiteExprStmt;
		private var _prefix:String;
		private var _wrapAsGroup:Boolean;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteExprStmt(prefix:String = null)
		{
			this._prefix = prefix;
			
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
			return this._prefix;
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
		
		public function get wrapAsGroup():Boolean
		{
			return this._wrapAsGroup;
		}
		
		/**
		 */
		
		public function set wrapAsGroup(value:Boolean):void
		{
			if(_wrapAsGroup == value)
				return;
			
			_wrapAsGroup = value;
			
			this.change();
		}
		
		/**
		 */
		
		public function get expression():ISQLiteStmt
		{
			return this._lhs;
		}
		
		/**
		 */
		
		public function set expression(value:ISQLiteStmt):void
		{
			if(value == this)
			{
				throw new Error("cannot assign LHS or LHS as self");
				
			}
			
			this._lhs = value;
			
			this.addChildStatement(ConcreteSQLiteStmt(value));
		}
		
		/**    
		 */
		
		public function get nextExpression():SQLiteExprStmt
		{
			return this._rhs;
		}
		
		/**
		 */
		
		public function set nextExpression(value:SQLiteExprStmt):void
		{
			
			
			this._rhs = value;
			value.prefix = "";
			
			this.addChildStatement(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function group(value:Boolean = true):SQLiteExprStmt
		{
			this.wrapAsGroup = value;
			return this;
		}
		/**
		 */
		
		public function equals(key:*,value:*):SQLiteExprStmt
		{
			if(value is String && String(value).indexOf(":") != 0)
			{
				value = "'"+value+"'";
			}
			
			return this.setCondition(key,"=",value);
		}
		
		/**
		 */
		
		public function notEquals(key:*,value:*):SQLiteExprStmt
		{
			if(value is String)
			{
				value = "'"+value+"'";
			}
			
			return this.setCondition(key,"<>",value);
		}
		
		/**
		 */
		
		public function greaterThan(key:*,value:*):SQLiteExprStmt
		{
			return this.setCondition(key,">",value);
		}
		
		/**
		 */
		
		public function lessThan(key:*,value:*):SQLiteExprStmt
		{
			return this.setCondition(key,"<",value);
		}
		
		/**
		 */
		
		public function greaterThanOrEqualTo(key:*,value:*):SQLiteExprStmt
		{
			return this.setCondition(key,">=",value);
		}
		
		/**
		 */
		
		public function lessThanOrEqualTo(key:*,value:*):SQLiteExprStmt
		{
			return this.setCondition(key,"<=",value);
		}
		
		/**
		 */
		
		public function value(value:*):SQLiteExprStmt
		{
			this.expression = value is ISQLiteStmt ? value : new SQLiteValueStmt(value);
			return this;
		}
		
		
		/**
		 */
		
		public function and():SQLiteExprStmt
		{
			return this.setOp("AND");
		}
		
		/**
		 */
		
		public function or():SQLiteExprStmt
		{
			return this.setOp("OR");
		}
		
		/**
		 */
		
		/*public function combine(stmt:SQLiteExprStmt):void
		{
			//this._conditions = this._conditions.concat(stmt._conditions);
		}*/
		/**
		 */
		
		override public function toString():String
		{
			
			var buffer:String = "";
			
			if(!this._lhs)
			{
				return buffer;
			}
			
			if(this._prefix)
			{
				buffer += this._prefix+" ";
			}
			
			
			
			buffer += _wrapAsGroup ? "(" : "";
			
			
			
			
			
			buffer += this._lhs;
			
			
			if(_rhs && _rhs._lhs)
			{
				
				buffer += " "+this._op+" "+_rhs;
				
			}
			
			
			return  buffer+(_wrapAsGroup ? ")" : "");
			
		}
		
		/**
		 */
		
		
		override public function clone():ISQLiteStmt
		{
			var clazz:Class = Object(this).constructor;
			
			return this.clone2(new clazz());
		}
		
		/**
		 */
		
		public function copyFrom(expr:SQLiteExprStmt):SQLiteExprStmt
		{
			
			this.expression = expr._lhs;
			this._op = expr._op;
			this.nextExpression = expr._rhs;
			
			return this;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function clone2(expr:SQLiteExprStmt):ISQLiteStmt
		{	
			if(this._lhs) expr.expression = _lhs.clone();
			if(this._rhs) expr.nextExpression = SQLiteExprStmt(_rhs.clone());
			expr._prefix = this._prefix;
			expr._wrapAsGroup = this._wrapAsGroup;
			expr._op = _op;
			
			return expr;
		}
		/**
		 */
		
		protected function setCondition(lhs:*,op:String,rhs:*):SQLiteExprStmt
		{
			this.expression = new SQLiteBinopStmt(lhs,op,rhs); 
			return this;
		}
		
		
		/**
		 */
		protected function setOp(op:String):SQLiteExprStmt
		{
			
			this._op  = op;
			this.nextExpression = new SQLiteExprStmt();
			
			return this._rhs;
		}
	}
}