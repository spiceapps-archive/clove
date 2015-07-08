package com.spice.air.utils.sql.manage.stmt
{

	public class SQLiteSelectStmt extends ConcreteSQLiteStmt
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		 
		private var _select:Vector.<String>;
		
		 
		private var _from:String;
		
		 
		private var _where:SQLiteWhereStmt;
		
		 
		private var _orderBy:SQLiteOrderByStmt;
		
		 
		private var _groupBy:SQLiteGroupByStmt;
		
		 
		private var _limit:SQLiteLimitStmt;
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _selectAll:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteSelectStmt(from:String,
										 select:Vector.<String>     = null,
										 where:SQLiteWhereStmt 	   = null,
										 orderBy:SQLiteOrderByStmt = null,
										 groupBy:SQLiteGroupByStmt = null,
										 limit:SQLiteLimitStmt     = null)
		{
			super();
			
			this._select  = select   || new Vector.<String>("*");
			this._from    = from.indexOf("main") > -1 ? from : "main."+from;
			this.where   = where   || new SQLiteWhereStmt();
			this.orderBy = orderBy || new SQLiteOrderByStmt();
			this.groupBy = groupBy || new SQLiteGroupByStmt();
			this.limit   = limit   || new SQLiteLimitStmt();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get select():Vector.<String>
		{
			return _select;
		}
		
		/**
		 */
		
		public function get from():String
		{
			return _from;
		}
		
		/**
		 */
		
		public function get where():SQLiteWhereStmt
		{
			return _where;
		}
		
		/**
		 */
		
		public function set where(value:SQLiteWhereStmt):void
		{
			if(_where == value)
				return;
			this.swapChildren(_where,value); _where = value;
		}
		
		/**
		 */
		
		public function get orderBy():SQLiteOrderByStmt
		{
			return _orderBy;
		}
		/**
		 */
		
		public function set orderBy(value:SQLiteOrderByStmt):void
		{
			if(_orderBy == value)
				return;
			this.swapChildren(_orderBy,value); _orderBy = value;
		}
		
		/**
		 */
		
		public function get groupBy():SQLiteGroupByStmt
		{
			return _groupBy;
		}
		
		/**
		 */
		
		public function set groupBy(value:SQLiteGroupByStmt):void
		{
			if(_groupBy == value)
				return;
			this.swapChildren(_groupBy,value); _groupBy = value;
		}
		
		/**
		 */
		
		public function get limit():SQLiteLimitStmt
		{
			return _limit;
		}
		
		/**
		 */
		
		public function set limit(value:SQLiteLimitStmt):void
		{
			if(_limit == value)
				return;
			this.swapChildren(_limit,value); _limit = value;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function toDeleteStmt():SQLiteDeleteStmt
		{
			return new SQLiteDeleteStmt(_from,
										SQLiteWhereStmt(this._where.clone()));
		}
		
		/**
		 */
		
		public function key(name:String):String
		{
			return this.from+"."+name;
		}
		/**
		 */
		
		public function selectKeys(keys:Array):SQLiteSelectStmt
		{
			this._select = new Vector.<String>();
			
			for each(var key:String in keys)
			{
				this._select.push(key);	
			}
			
			this.change();
			return this;
		}
		
		/**
		 */
		
		public function setGroupBy(key:*):SQLiteSelectStmt
		{
			this._groupBy.setGroupBy(key);
			return this;
		}
		/**
		 */
		
		public function setOrderBy(key:*):SQLiteOrderByStmt
		{
			this._orderBy.setOrderBy(key);
			return this.orderBy;
		}
		
		/**
		 */
		
		public function selectAll(value:Boolean = true):SQLiteSelectStmt
		{
			_selectAll = value;
			return this;
		}
		
		
		/**
		 */
		
		public function setLimit(rows:Number,offset:Number = NaN):SQLiteSelectStmt
		{
			this._limit.setLimit(rows,offset);
			return this;
		}
		
		
		
		/**
		 */
		
		override public function toString():String
		{
			return "SELECT "+_select+" FROM "+_from+" "+_where+" "+_orderBy+" "+_groupBy+" "+_limit;
		}
		
		/**
		 */
		
		override public function clone():ISQLiteStmt
		{
			return new SQLiteSelectStmt(_from,
										_select.concat(),
										SQLiteWhereStmt(_where.clone()),
										SQLiteOrderByStmt(_orderBy.clone()),
										SQLiteGroupByStmt(_groupBy.clone()),
										SQLiteLimitStmt(_limit.clone()));
		}
	}
}