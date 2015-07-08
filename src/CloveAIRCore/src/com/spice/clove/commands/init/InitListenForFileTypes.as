package com.spice.clove.commands.init
{
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.desktop.NativeApplication;
	import flash.events.BrowserInvokeEvent;
	import flash.events.InvokeEvent;
	import flash.filesystem.File;
	
	public class InitListenForFileTypes extends Cue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InitListenForFileTypes()
		{
			 
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function init():void
		{
			
			
			
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE,onInvoke);
			
			this.complete();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onInvoke(event:InvokeEvent):void
		{
			//var file:File = event.arguments[0];
			for each(var file:String in event.arguments)
			{
				new CloveEvent(CloveEvent.INSTALL_PLUGIN_WITH_CONFIRM,new File(file)).dispatch();
			}
		}
		
		
	}
}