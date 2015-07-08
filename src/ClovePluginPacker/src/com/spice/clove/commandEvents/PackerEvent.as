package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class PackerEvent extends CairngormEvent
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const EXPORT_PLUGIN:String = "exportPlugin";
        public static const UNPACK_SWC:String    = "unpackSwc";
        public static const REBUNDLE:String    = "rebundle";
        public static const INITIALIZE:String  = "initialize";
        public static const LOGIN_USER:String  = "loginUser";
        public static const SIGNUP_USER:String = "signupUser";
        
        public static const NEW_PLUGIN:String  = "newPlugin";
        public static const SAVE_PLUGIN:String  = "savePlugin";
        public static const LOAD_PLUGINS:String  = "loadPlugins";
        public static const LOAD_PLUGIN:String  = "loadPlugin";
        
        public var value:*;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PackerEvent(type:String,data:Object = null)
		{
			super(type);
			
			this.value = data;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function clone():Event
		{
			return new PackerEvent(type,value);
		}

	}
}