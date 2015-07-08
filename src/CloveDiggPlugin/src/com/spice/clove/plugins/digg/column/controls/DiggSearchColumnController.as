package com.spice.clove.plugins.digg.column.controls
{
	import com.architectd.digg2.calls.search.DiggSearchStoriesCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	
	import flash.events.Event;

	public class DiggSearchColumnController extends DiggStoryColumnController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _search:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggSearchColumnController()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		[Bindable(event="searchChange")]
		[Setting]
		public function get search():String
		{
			return _search;
		}
		
		/**
		 */
		
		public function set search(value:String):void
		{
			_search = value;
			
			this.title = "Search : "+value;
			
			this.dispatchEvent(new Event("searchChange"));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function onColumnStartLoad(event:CloveColumnEvent) : void
		{
			this.laodData();
		}
		/**
		 */
		
		override protected function loadOlderContent(data:RenderedColumnData) : void
		{
			var count:Number = data.vo.count;
			var offset:Number = data.vo.offset;
			
			
			this.laodData(count,offset+count);
			
		}
		
		
		/**
		 */
		
		protected function laodData(count:Number = 30,offset:Number = NaN):void
		{
			
			this.call(new DiggSearchStoriesCall(this._search,count,offset));
		}
	}
}