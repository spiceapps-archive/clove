package com.spice.clove.plugin.twitter.column.control
{
	import com.architectd.twitter.calls.timeline.UserTimelineCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.ICloveColumn;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.twitter.column.control.render.TwitterRowItemRenderer;
	import com.spice.display.controls.list.SmoothList;
	
	[Bindable] 
	public class TwitterUserSearchColumnController extends TwitterSearchBasedColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _column:ICloveColumn;
		
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterUserSearchColumnController(controller:IPluginController = null,user:String = null)
		{
			super(controller,user);
			
			this.itemRenderer = new TwitterRowItemRenderer();
			
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function set search(value:String) : void
		{
			super.search = value;
			
			this.title = "User Search: "+value;
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
			
			Logger.log("load() search="+search,this);
			
			if(!this._twitter || !this.search)
				return;
				
			this.loadContent();
		}
		
		
		/**
		 */
		
		override protected function loadContent(maxID:Number=NaN) : void
		{
			
			this.call(new UserTimelineCall(this.search,30,0,NaN,maxID),onSearch);
		}
		

	}
}