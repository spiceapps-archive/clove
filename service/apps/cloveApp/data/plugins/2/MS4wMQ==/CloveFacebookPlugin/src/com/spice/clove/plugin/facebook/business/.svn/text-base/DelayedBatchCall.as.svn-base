package com.spice.clove.plugin.facebook.business
{
	import com.spice.recycle.events.DisposableEventDispatcher;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.setTimeout;
	
	public class DelayedBatchCall extends DisposableEventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _executing:Boolean;
		private var _batch:Array;
		private var _int:int;
		private var _target:IEventDispatcher;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DelayedBatchCall(bindDispatcher:IEventDispatcher)
		{
			this.clearBatch();
			
			this._target = bindDispatcher;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get batch():Array
		{
			return _batch;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		final public function clearBatchIfDone():void
		{
			if(!_executing)
			{
				this.clearBatch();
			}
		}
		
		
		/**
		 */
		
		public function addToBatch(item:Object):void
		{
			if(_batch.indexOf(item) > -1)
				return;
			
			_batch.push(item);
			
			this.timeout();
		}
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		final protected function timeout():void
		{
			_executing = true;
			
			flash.utils.clearTimeout(_int);
			
			_int = flash.utils.setTimeout(onBatch2,1);
		}
		
		/**
		 */
		
		protected function onBatch():void
		{
			
			//abstract
		}
		
		/**
		 */
		
		protected function clearBatch():void
		{
			//abstract
			this._batch = [];
		}
		
		/**
		 */
		
		protected function complete():void
		{
			this._target.dispatchEvent(new Event("batchComplete"));
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onBatch2():void
		{
			this._executing = false;
			
			this.onBatch();
		}

	}
}