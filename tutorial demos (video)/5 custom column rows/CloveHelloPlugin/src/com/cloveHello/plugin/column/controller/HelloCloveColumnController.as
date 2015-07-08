package com.cloveHello.plugin.column.controller
{
	import com.cloveHello.plugin.CloveHelloPlugin;
	import com.cloveHello.plugin.column.render.HelloCloveColumnItemRenderer;
	import com.cloveHello.plugin.service.cue.CallDataCue;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.control.ColumnController;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	
	public class HelloCloveColumnController extends ColumnController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function HelloCloveColumnController()
		{
			super(new HelloCloveColumnItemRenderer());
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
			var start:int;
			
			if(data)
			{
				start = int(data.rowuid);
			}
			
			var plugin:CloveHelloPlugin = CloveHelloPlugin(this.pluginController.plugin);
			
			var call:CallDataCue = new CallDataCue(start);
			call.addEventListener(Event.COMPLETE,onDataLoad);
			
			
			this.setLoadCue(call);
			
			
			plugin.call(call);
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onDataLoad(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onDataLoad);
			
			var data:Array = CallDataCue(event.target).data;
			
			this.fillColumn(data);
		}

	}
}