package com.architectd.digg2.loginHelper
{
	import com.architectd.digg2.DiggService;
	import com.architectd.digg2.loginHelper.views.HTMLLoginHelperView;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.events.DataEvent;
	
	public class AIRLoginHTMLHelper extends Cue implements IDiggLoginHelper
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable] 
        public var service:DiggService;
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _view:HTMLLoginHelperView;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function AIRLoginHTMLHelper()
		{
			_view = new HTMLLoginHelperView();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get view():HTMLLoginHelperView
		{
			return _view;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function init():void
		{
			_view.addEventListener(DataEvent.DATA,onData);
			_view.service = this.service;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onData(event:DataEvent):void
		{
			
			this.service.settings.pin = String(event.data);
			
			this.complete();
		}

	}
}