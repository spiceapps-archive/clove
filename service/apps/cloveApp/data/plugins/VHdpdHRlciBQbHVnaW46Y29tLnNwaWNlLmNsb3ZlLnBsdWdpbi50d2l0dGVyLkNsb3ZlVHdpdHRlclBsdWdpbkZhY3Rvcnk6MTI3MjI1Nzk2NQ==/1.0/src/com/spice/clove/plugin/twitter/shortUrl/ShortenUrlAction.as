package com.spice.clove.plugin.twitter.shortUrl
{
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.plugin.posting.Message;
	import com.spice.monkeyPatch.menu.MenuItem;
	
	import flash.events.Event;
	
	public class ShortenUrlAction
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		
		
		
		private var _menuItem:MenuItem;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		 
		public function ShortenUrlAction()
		{
			_menuItem = new MenuItem("Shorten URLs");
			_menuItem.addEventListener(Event.SELECT,onShortenUrlsSelect);
			
			new CloveEvent(CloveEvent.ADD_POSTER_ACTION,_menuItem).dispatch();
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function register():void
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onShortenUrlsSelect(event:Event):void
		{
			var me:MenuItem = MenuItem(event.target);
			
			var msg:Message = me.data;
			
			var urls:Array = msg.text.match(new RegExp( "((?<=^|\\s)((ht|f)tp(s?)://)?(\\w+:\\w+@)?([-\\w]+\\.)+(com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum|travel|[a-z]{2})((?=([^\\w]|$)))(:\\d+)?.*?)(?=[,:!?.]*(\\s|$))","g"));
			
			
			for each(var url:String in urls)
			{
				new BitlyService(url,msg).init();
			}
		}

	}
}