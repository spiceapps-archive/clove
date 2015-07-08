package com.spice.air.invoke
{
	import com.spice.model.Singleton;
	import com.spice.utils.command.CommandManager;
	
	import flash.desktop.NativeApplication;
	import flash.events.BrowserInvokeEvent;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.utils.Base64Decoder;
	
	
	/**
	 */
	
	public class BrowserInvokationManager extends Singleton
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		protected var _handler:CommandManager;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BrowserInvokationManager()
		{
			super();
			
			
			this._handler = new CommandManager();
			
			NativeApplication.nativeApplication.addEventListener(BrowserInvokeEvent.BROWSER_INVOKE,onInvokation);
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		/* public static function getInstance():BrowserInvokationManager
		{
			return Singleton.getInstance(BrowserInvokationManager);
		}
		 */
		 
		public function invoke(cmd:Array):void
		{
			
			this._handler.handleArguments(cmd);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onInvokation(event:BrowserInvokeEvent):void
		{
			var args:Array = [];
			
			/*  var b64:Base64Decoder = new Base64Decoder();
			var b:ByteArray;
			
			//the data is encoded so the invalid characters can be passed
			
			try
			{
				for each(var arg:String in event.arguments)
				{
					b64.decode(arg);
					
					b = b64.drain();
					b.position = 0;
					
					args.push(b.readUTFBytes(b.length));
				}
			}catch(e:*)
			{
				Logger.logError(e);
				 
			}
			 */
			
			
			args = event.arguments;
			
			
			this.invoke(args);
		}

	}
}