package com.spice.air.utils.sql.manage.decorators
{
	import com.spice.air.utils.sql.manage.ConcreteSQLiteTableController;
	import com.spice.air.utils.sql.manage.DAOController;
	import com.spice.air.utils.sql.manage.ISQLiteTableController;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.data.SQLConnection;
	import flash.events.EventDispatcher;
	
	import mx.events.CollectionEvent;

	public class SQLiteDecorator extends EventDispatcher implements ISQLiteTableController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _target:ISQLiteTableController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteDecorator(controller:ISQLiteTableController)
		{
			_target = controller;
			
			_target.addEventListener( CollectionEvent.COLLECTION_CHANGE,onTargetChange);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get target():ConcreteSQLiteTableController
		{
			return this._target.target;
		}
		
		/**
		 */
		
		public function get dao():DAOController
		{
			return _target.dao;
		}
		
		/**
		 */
		
		public function get readConnection():SQLConnection
		{
			return _target.readConnection;
		}
		
		/**
		 */
		
		public function get writeConnection():SQLConnection
		{
			return _target.writeConnection;
		}
		
		/**
		 */
		
		[Bindable(event="collectionChange")]
		public function get numRows():Number
		{
			return _target.numRows;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function removeAll(truncate:Boolean = false):void
		{
			_target.removeAll(truncate);
		}
		
		/**
		 */
		
		public function insert(items:Array):Cue
		{
			return _target.insert(items);
		}
		
		public function update(items:Array):Cue
		{
			return _target.update(items);
		}
		
		
		
		public function remove(items:Array,limit:Number = 0):Cue
		{
			return _target.remove(items,limit);	
		}
		
		public function paginate(limit:Number = 0,offset:Number = 0):Array
		{
			return _target.paginate(limit,offset);
		}
		
		/**
		 */
		
		public function selectAll():Array
		{
			return _target.selectAll();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
	
		private function onTargetChange(event:CollectionEvent):void
		{
			this.dispatchEvent(event.clone());
		}
	}
}