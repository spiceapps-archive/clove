package com.spice.clove.plugins.digg.cue
{
	import com.architectd.digg2.DiggService;
	import com.architectd.digg2.calls.DiggCall;
	import com.architectd.digg2.data.StoryData;
	import com.architectd.digg2.events.DiggEvent;
	import com.spice.utils.queue.cue.StateCue;

	public class DiggCue extends StateCue
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _connection:DiggService;
		private var _call:DiggCall;
		private var _onResult:Function;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggCue(connection:DiggService,call:DiggCall,onResult:Function = null)
		{
			
			this._connection = connection;
			this._call       = call;
			this._onResult   = onResult;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function init():void
		{
			
			this._connection.call(this._call).addEventListener(DiggEvent.NEW_DATA,onNewData);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		protected function onNewData(event:DiggEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onNewData);
			
			
			if(this._onResult != null)
			{
				this._onResult(event.data);
			}
			
			this.complete();
		}
		
		
	}
}