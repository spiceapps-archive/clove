package com.spice.cloveHello.service.cue
{
	import com.spice.cloveHello.service.vo.MessageValueObject;
	import com.spice.utils.queue.cue.StateCue;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	[Event(name="complete")]
	public class CallDataCue extends StateCue
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _data:Array;
		private var _start:int;
		private var _length:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CallDataCue(start:int,length:Number = 50)
		{
			_start = start
			_length = length;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get data():Array
		{
			return this._data;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override public function init():void
		{
			super.init();
			
			var n:Number = _start + _length;
			
			var data:Array = [];
			
			var now:Date = new Date();
			
			for(var i:int = _start; i < n; i++)
			{
				data.push(new MessageValueObject("Title - "+i,"Message - "+i,i.toString(),new Date(now.getTime() - 1000 * 60 * 60 * 24 * i)));
			}
			
			this._data = data;
			
			flash.utils.setTimeout(onTimeout,1000);
		}
		
		/**
		 */
		
		private function onTimeout():void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
			
			this.complete();
		}
	}
}