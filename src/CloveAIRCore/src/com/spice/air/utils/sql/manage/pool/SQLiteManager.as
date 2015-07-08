package com.spice.air.utils.sql.manage.pool
{
	import com.spice.air.utils.sql.manage.cue.SQLStatementCue;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.utils.queue.ChildQueueManager;
	import com.spice.utils.queue.QueueManager;
	import com.spice.utils.queue.cue.Cue;
	import com.spice.utils.queue.cue.ICue;
	import com.spice.utils.queue.global.GlobalQueueManager;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	
	import mx.controls.Alert;

	public class SQLiteManager
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private static var _instances:Object;
		
		
		private var _queue:QueueManager;
		private var _connection:SQLConnection;
		private var _async:Boolean;
		private var _pool:ObjectPoolManager = ObjectPoolManager.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLiteManager(database:String,async:Boolean = true,openMode:String = SQLMode.CREATE,autoCompact:Boolean = false)
		{
			_queue = new QueueManager();
			_connection = new SQLConnection();
			_async = async;
			
			if(async)
			{
				_connection.openAsync(new File(database),openMode);
			}
			else
			{
				_connection.open(new File(database),openMode,autoCompact);
			}
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get connection():SQLConnection
		{
			return this._connection;
		}
		
		/**
		 */
		
		public function execute(value:SQLStatement):Cue
		{
			var cue:Cue = _pool.getObject(SQLStatementCue).construct(value);
			
			_queue.addCue(cue);
			
			return cue;
		}
		
		
		/**
		 */
		
//		public function insert(value:SQLStatement,data:*,cols:Vector.<String>):void
//		{
//			
//			_queue.addCue(_pool.getObject(SQLStatementInsertCue).insert(value,data,cols));
//			
//			
//			//create a block
//		}
		
		/**
		 */
		
//		public function remove(value:SQLStatement,data:*,cols:Vector.<String>):void
//		{
//			_queue.addCue(_pool.getObject(SQLStatementDeleteCue).remove(value,data,cols));
//		}
		
		
		/**
		 */
		
		public function addCue(cue:Cue):Cue
		{
			this._queue.addCue(cue);
			return cue;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public static function open(database:String,
									async:Boolean = true,
									openMode:String = SQLMode.CREATE,
									autoCompact:Boolean = false):SQLiteManager
		{
			if(!_instances)
			{
				_instances = {};
			}
			
			if(!_instances[async])
			{
				_instances[async] = {};
			}
			
			var man:SQLiteManager = _instances[async][database];
			
			if(!man)
			{
				
				_instances[async][database] = man = new SQLiteManager(database,async,openMode,autoCompact);
			}
			
			return man;
		}
		
		
		
	}
}