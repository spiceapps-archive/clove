package com.spice.clove.models
{
	
	import com.spice.air.controls.menu.TranslatableNativeMenuItem;
	
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	
	public class MenuModel
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        
		public var menus:Array;
		
		public static const CONTROLS:String    = "controls";
		public static const WINDOW:String      = "Window";
		public static const EDIT:String        = "Edit";
		public static const VIEW:String        = "View";
		public static const FILE:String        = "File";
		public static const APPLICATION:String = "Clove";
		public static const HISTORY:String     = "History";
		public static const BETA:String        = "Beta";
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _menuItems:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
	
		public function MenuModel():void
		{
			menus = new Array();
			
			this._menuItems = {};
			
			
			this.registerMenuItem("Clove",new TranslatableNativeMenuItem("Clove"));
			//this.registerMenuItem("Controls",new TranslatableNativeMenuItem("Controls"));
			this.registerMenuItem("File",new TranslatableNativeMenuItem("File"));
			this.registerMenuItem("Edit",new TranslatableNativeMenuItem("Edit"));
//			this.registerMenuItem("Window",new TranslatableNativeMenuItem("Window"));
			this.registerMenuItem("Beta",new TranslatableNativeMenuItem("Beta"));
			//this.registerMenuItem("View",new TranslatableNativeMenuItem("View"));
//			this.registerMenuItem("History",new TranslatableNativeMenuItem("History")); //NativeMenuItem
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /*
		 */
		
		public function addMenuItem(name:String,item:NativeMenuItem):void
		{
			
			
			var target:NativeMenuItem = this._menuItems[name];
			
			if(!target)
			{
				throw new Error("menu item "+name+" does not exist");
			}
			
			
			if(!target.submenu)
			{
				target.submenu = new NativeMenu();
			}
			
			target.submenu.addItem(item);
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		private function registerMenuItem(name:String,item:NativeMenuItem):void
		{
			this._menuItems[name] = item;
			
			this.menus.push(item);
		}
			
		
	}
}