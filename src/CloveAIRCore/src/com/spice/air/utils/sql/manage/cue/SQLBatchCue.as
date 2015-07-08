package com.spice.air.utils.sql.manage.cue
{
	import com.spice.impl.utils.AsyncUtil;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	
	public class SQLBatchCue extends Cue
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _i:int;
		private var _items:Array;
		private var _stmt:SQLStatement;
		private var _cols:Vector.<String>;
		private var _currentItem:Object;
		private var _pool:ObjectPoolManager
		private static var _async:AsyncUtil;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLBatchCue()
		{
			/*if(!_async)
			{
				_async = new AsyncUtil(SQLBatchCue,100);
			}*/
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get items():Array
		{
			return this._items;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function construct(stmt:SQLStatement,items:Array,cols:Vector.<String>):SQLBatchCue
		{
			_stmt  = stmt;
			_items = items;
			_cols  = cols;
			_i     = 0;
			return this;
		}
		
		/**
		 */
		
		override public function init():void
		{
			if(_i == 0)		
			{
				_stmt.addEventListener(SQLEvent.RESULT,onResult);
				_stmt.addEventListener(SQLErrorEvent.ERROR,onError);
			}
			
			if(_i >= _items.length)
			{
				_stmt.removeEventListener(SQLEvent.RESULT,onResult);
				_stmt.removeEventListener(SQLErrorEvent.ERROR,onError);
				
				if(!_pool)
				{
					_pool = ObjectPoolManager.getInstance();
				}
				
				
				this.complete();
				
				return;
			}
			
			_currentItem = _items[_i];
			
			
			for each(var col:String in _cols)
			{
				_stmt.parameters[":"+col] = _currentItem[col];	
			}
			
			
			_stmt.execute();
//			_async.callLater(_stmt.execute);
		}
		
		
		
		/**
		 */
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onResult(event:SQLEvent):void
		{
			_i++;
			this.init();
		}
		
		/**
		 */
		
		private function onError(event:SQLErrorEvent):void
		{
			_i++;
			this.init();
		}
	}
}