package com.spice.air.utils.sql.manage.cue
{
	import com.spice.recycle.pool.ObjectPool;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.data.SQLStatement;
	import flash.net.Responder;
	

	public class SQLStatementCue extends Cue
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		protected var _stmt:SQLStatement;
		private var _pool:ObjectPoolManager = ObjectPoolManager.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SQLStatementCue()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function construct(stmt:SQLStatement):SQLStatementCue
		{
			_stmt = stmt;
			return this;
		}
		
		/**
		 */
		
		override public function init():void
		{
			_stmt.execute(-1,new Responder(result,fault));
		}
		
		/**
		 */
		
		public function result(data:Object):void
		{
			this.complete();
			
			_pool.addObject(this);
			
		}
		
		/**
		 */
		
		public function fault(data:Object):void
		{
			this.complete();
		}
	}
}