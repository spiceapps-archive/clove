package com.spice.clove.facebook.impl.cue
{
	import com.facebook.Facebook;
	import com.facebook.events.FacebookEvent;
	import com.facebook.net.FacebookCall;
	import com.spice.impl.queue.AbstractCue;

	public class FacebookCallCue extends AbstractCue
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _call:FacebookCall;
		private var _connection:Facebook;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookCallCue(call:FacebookCall,connection:Facebook)
		{
			_call = call;
			_connection = connection;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function initialize():void
		{
			super.initialize();
			
			_connection.post(_call).addEventListener(FacebookEvent.COMPLETE,onCallComplete);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onCallComplete(event:FacebookEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onCallComplete);
			
			this.complete();
		}
	}
}