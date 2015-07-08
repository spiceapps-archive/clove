package com.spice.clove.plugins.digg.column.controls
{
	import com.architectd.digg2.calls.stories.BuryStoryCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.events.plugin.ColumnControllerEvent;
	import com.spice.clove.plugin.column.ICloveColumn;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugins.digg.column.controls.sub.StoryCommentsController;
	import com.spice.clove.plugins.digg.column.render.DiggStoryColumnItemRenderer;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class DiggStoryColumnController extends DiggColumnController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _menuOptions:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggStoryColumnController()
		{
			
			_menuOptions = [
							{
								label:"Bury",
								callback:buryStory
							}
						   ];
			
			
			super(new DiggStoryColumnItemRenderer());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function set column(value:ICloveColumn) : void
		{
			super.column = value;
			
			
			this.dispatchEvent(new ColumnControllerEvent(ColumnControllerEvent.ADD_MENU_OPTIONS,this._menuOptions));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		/**
		 */
		
		override protected function onRenderedDataDoubleClick(event:CloveColumnEvent) : void
		{
			
			
//			flash.net.navigateToURL(new URLRequest(event.data.vo.diggUrl));
			this.setBreadcrumb(new StoryCommentsController(event.data));
		}
		
		/**
		 */
		
		override protected function onRendereDataIconClick(event:CloveColumnEvent) : void
		{
			
			flash.net.navigateToURL(new URLRequest(event.data.vo.shortUrl));
		}
		
		
		/**
		 */
		
		protected function buryStory(item:RenderedColumnData):void
		{
			this.connection.call(new BuryStoryCall(item.dbid.toString()));
			
			item.vo.burried = true;
			
			item.update();
		}
		
		
		/**
		 */
		
		protected function loadContent(maxDate:Date = null):void
		{
			
		}
		
		/**
		 */
		
		override protected function loadOlderContent(data:RenderedColumnData) : void
		{
			loadContent(new Date(Number(data.datePosted)));
		}
	}
}