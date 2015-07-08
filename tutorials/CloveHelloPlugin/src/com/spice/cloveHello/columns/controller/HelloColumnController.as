package com.spice.cloveHello.columns.controller
{
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.control.ColumnController;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.cloveHello.CloveHelloPlugin;
	import com.spice.cloveHello.columns.render.HelloColumnItemRenderer;
	import com.spice.cloveHello.service.cue.CallDataCue;
	
	import flash.events.Event;
	
	public class HelloColumnController extends ColumnController
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function HelloColumnController()
		{
			super(new HelloColumnItemRenderer());
			
			this.title = "Hello Column";
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function onColumnStartLoad(event:CloveColumnEvent):void
		{
			this.loadOlderContent(null);
		}
		
		/**
		 */
		
		override protected function loadOlderContent(data:RenderedColumnData):void
		{
			var cue:CallDataCue = new CallDataCue(0);
			cue.addEventListener(Event.COMPLETE,onCueComplete);
			
			CloveHelloPlugin(this.pluginController.plugin).call(cue);
			
			this.setLoadCue(cue);
			
				
		}
		
		
		/**
		 */
		private function onCueComplete(event:Event):void
		{
			var cue:CallDataCue = CallDataCue(event.target);
			
			this.fillColumn(cue.data);
		}
		
		

	}
}