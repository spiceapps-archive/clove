package com.spice.clove.plugin.extra.twitpic
{
	import com.spice.clove.commandEvents.CloveCueEvent;
	import com.spice.clove.ext.extra.twitpic.events.TwitpicEvent;
	import com.spice.clove.ext.extra.twitpic.net.TwitpicRequest;
	import com.spice.clove.ext.extra.twitpic.net.TwitpicService;
	import com.spice.clove.ext.services.twitter.TwitterPlugin;
	import com.spice.events.QueueManagerEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class TwitpicCall com.spice.recycle.
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _plugin:TwitterPlugin;
		private var _select:Boolean;
		private var _data:Object;
		private var _success:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitpicCall(plugin:TwitterPlugin,select:Boolean = true)
		{
			_plugin = plugin;
			_select = select;
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get data():Object
		{
			return _data;
		}
		
		/**
		 */
		
		public function get success():Boolean
		{
			return _success;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function post():void
		{
			if(_select)
			{
				_plugin.selectableCall(null,selectPlugin);
			}
			else
			{
				selectPlugin(_plugin);
			}
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function selectPlugin(plugin:TwitterPlugin):void
		{
		Logger.log("TwitpicCall::selectPlugin("+plugin.username+")");
			
			var serv:TwitpicService = new TwitpicService();
			serv.setCredentials(plugin.username,plugin.password);
			serv.addEventListener(TwitpicEvent.NEW_REQUEST,onNewRequest,false,0,true);
			serv.upload();
		}
		
		/**
		 */
		
		private function onNewRequest(event:TwitpicEvent):void
		{
			event.target.removeEventListener(event.type,onNewRequest);
			
			event.request.addEventListener(QueueManagerEvent.CUE_COMPLETE,onRequestComplete,false,0,true);
			
			new CloveCueEvent(event.request).dispatch();
			
			dispatchEvent(event.clone());
		}
		
		/**
		 */
		
		private function onRequestComplete(event:QueueManagerEvent):void
		{
			Logger.log("TwitpicCall::Complete()");
			_data    = TwitpicRequest(event.target).data;
			_success = TwitpicRequest(event.target).success;
			
			event.target.removeEventListener(event.type,onRequestComplete);
			
			dispatchEvent(new Event(Event.COMPLETE));
			
		}

	}
}