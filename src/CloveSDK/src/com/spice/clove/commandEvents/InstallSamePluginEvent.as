package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class InstallSamePluginEvent extends CairngormEvent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const INSTALL_SAME:String = "installSamePlugin";
		
		public var factoryClass:Class;
		public var installCallback:Function;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InstallSamePluginEvent(factoryClass:Class,installCallback:Function = null)
		{
			super(INSTALL_SAME);
			
			this.factoryClass    = factoryClass;
			this.installCallback = installCallback;
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
			return new InstallSamePluginEvent(this.factoryClass,installCallback);
		}
		

	}
}