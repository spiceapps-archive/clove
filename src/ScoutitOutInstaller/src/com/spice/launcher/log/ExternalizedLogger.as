package com.spice.launcher.log
{
	import com.spice.utils.logging.SpicyLogger;
	
	import flash.external.ExternalInterface;
	
	public class ExternalizedLogger extends SpicyLogger
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _jsFunc:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ExternalizedLogger(jsFunc:String,type:int,traceLogs:Boolean)
		{
			super(type,traceLogs,true);
			
			this._jsFunc = jsFunc;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		override public function log(message:*, caller:Object=null, metadata:Object=null) : void
		{
			
			super.log(message,caller,metadata);
			
			ExternalInterface.call(_jsFunc,message,this.type);
		}

	}
}