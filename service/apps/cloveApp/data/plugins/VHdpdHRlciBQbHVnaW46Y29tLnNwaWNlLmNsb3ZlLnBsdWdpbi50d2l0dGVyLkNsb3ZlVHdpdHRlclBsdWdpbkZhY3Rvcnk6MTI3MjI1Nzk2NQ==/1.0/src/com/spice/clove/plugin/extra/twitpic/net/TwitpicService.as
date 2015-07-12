package com.spice.clove.ext.extra.twitpic.net
{
	import com.spice.clove.ext.extra.twitpic.events.TwitpicEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class TwitpicService com.spice.recycle.
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _username:String;
		private var _password:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function TwitpicService()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function setCredentials(username:String,password:String):void
		{
			_username = username;
			_password = password;
		}
		
		/*
		 */
		
		public function upload():void
		{
			var ref:FileReference = new FileReference();
			ref.addEventListener(Event.SELECT,onSelect);
			
			
			
			ref.browse([new FileFilter("image","*.jpg;*.png;*.gif")]);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onSelect(event:Event):void
		{
			event.target.removeEventListener(event.type,onSelect);
			
			dispatchEvent(new TwitpicEvent(TwitpicEvent.NEW_REQUEST,new TwitpicRequest(event.target as FileReference,_username,_password)));
			
			
		}
		

	}
}