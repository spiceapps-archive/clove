package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class AddNewAssetEvent extends CairngormEvent
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const ADD_ASSET:String = "addAsset";
        
        public var file:Object;
        public var name:String;
        public var isDriver:Boolean;
        
        //--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function AddNewAssetEvent(name:String,file:Object,isDriver:Boolean = false)
		{
			this.file	  = file;
			this.name	  = name;
			this.isDriver = isDriver;
			
			super(ADD_ASSET);
			
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
			return new AddNewAssetEvent(name,file,isDriver);
		}

	}
}