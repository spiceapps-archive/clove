package com.spice.clove.plugin.twitter.column.control
{
	import com.spice.clove.plugin.column.ICloveColumn;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.twitter.column.control.render.TwitterSearchColumnItemRenderer;
	
	import flash.events.Event;
	
	[Bindable] 
	public class TwitterSearchBasedColumnController extends TwitterUserBasedColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _column:ICloveColumn;
		
        
		private var _search:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function TwitterSearchBasedColumnController(controller:IPluginController = null,search:String = null)
		{
			super(controller);
			
			this.search = search;
			
			this.itemRenderer = new TwitterSearchColumnItemRenderer();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/*
		 */
		
		[Setting]
		[Bindable(event="searchChange")]
		public function get search():String
		{
			return _search;
		}
		
		/*
		 */
		
		public function set search(value:String):void
		{
			if(_search && _search != value)
			{
				this.column.history.removeAllItems();
			}
			
			
			_search = value;
			
			
			
			this.dispatchEvent(new Event("searchChange"));
		}
		
		

	}
}