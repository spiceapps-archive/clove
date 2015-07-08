package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.monkeyPatch.menu.MenuItem;
	
	import flash.events.Event;
	
	public class AddMenuItemEvent extends CairngormEvent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const ADD_MENU_ITEM:String = "addMenuItem"
        
        public var menuItem:MenuItem;
        public var parentName:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function AddMenuItemEvent(menuItem:MenuItem,parent:String)
		{
			this.parentName = parent;
			this.menuItem = menuItem;
			
			super(ADD_MENU_ITEM);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		
		override public function clone():Event
		{
			return new AddMenuItemEvent(menuItem,parentName);
		}
	}
}