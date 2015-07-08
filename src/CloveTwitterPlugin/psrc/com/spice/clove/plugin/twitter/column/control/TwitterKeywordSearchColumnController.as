package com.spice.clove.plugin.twitter.column.control
{
	import com.architectd.twitter.calls.search.KeywordSearchCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.twitter.column.control.render.TwitterSearchColumnItemRenderer;
	
	[Bindable] 
	public class TwitterKeywordSearchColumnController extends TwitterSearchBasedColumnController
	{
		
		
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterKeywordSearchColumnController(controller:IPluginController = null,search:String = null)
		{
			super(controller,search);
			
			this.itemRenderer = new TwitterSearchColumnItemRenderer();
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
			
			this.title = "Search: "+value;
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
			super.onColumnStartLoad(event);
			
			Logger.log("load() search="+search,this);
			
			if(!this._twitter || !this.search)
				return;
				
			this.loadContent();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function loadContent(maxID:Number = NaN):void
		{
			this.call(new KeywordSearchCall(this.search,15,0,NaN,maxID),onSearch);
		}
		

	}
}