package com.spice.clove.plugin.twitter.column.control
{
	import com.architectd.twitter.Twitter;
	import com.architectd.twitter.calls.TwitterCall;
	import com.architectd.twitter.events.TwitterEvent;
	import com.spice.clove.plugin.column.*;
	import com.spice.clove.plugin.column.control.ColumnController;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.clove.plugin.twitter.column.control.render.TwitterRowItemRenderer;
	import com.spice.clove.plugin.twitter.cue.TwitterServiceCue;
	import com.spice.clove.plugin.twitter.icons.TwitterIcons;
	import com.spice.utils.EmbedUtil;
	import com.spice.utils.queue.global.GlobalQueueManager;
	
	import flash.utils.ByteArray;
	
	use namespace column_internal;
	
	
	/**
	 * the root twitter column. this class should nevedr be instantiated.
	 * @author craigcondon
	 * 
	 */	
	public class TwitterColumnController extends ColumnController
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Variables
        //
        //--------------------------------------------------------------------------

		protected var _twitter:Twitter;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable] 
        [Setting]
        public var accountName:String;
        
        [Bindable]	
        [ColumnSetting]
        public var columnIcon:ByteArray = EmbedUtil.toImageByteArray(TwitterIcons.TWITTER_16_ICON); 
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterColumnController(controller:IPluginController = null,itemRenderer:TwitterRowItemRenderer = null)
		{
			super(itemRenderer ? itemRenderer : new TwitterRowItemRenderer());
			
			
			if(controller)
				this.pluginController = controller;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		

		
		/**
		 */
		
		override public function set pluginController(value:IPluginController):void
		{
			super.pluginController = value;
			
			
			Logger.log("set pluginController",this);
			
			try
			{
				this._twitter = CloveTwitterPlugin(value.plugin).connection;
			}catch(e:Error)
			{
				Logger.logError(e);
			}
		}
		
		
		/**
		 */
		
		override public function set column(value:ICloveColumn) : void
		{
			super.column = value;
			
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		
		override protected function loadOlderContent(data:RenderedColumnData) : void
		{
			this.loadContent(Number(data.rowuid));
		}
		
		
		/**
		 */
		
		protected function loadContent(maxID:Number= NaN):void
		{
			
		}
		
		
		/**
		 * twitter for some reason doesn't allow multiple calls to be executed at the same time
		 * so push the call to the models cue
		 */
		
		protected function call(call:TwitterCall,
								callback:Function = null):TwitterServiceCue
		{
			var cue:TwitterServiceCue = new TwitterServiceCue(_twitter,call,callback)
			
			this.setLoadCue(cue);
			
			GlobalQueueManager.getInstance().getQueueManager("twitter").addCue(cue);
			
			return cue;
		}
		
		
		
		/**
		 */

		protected function onSearch(event:TwitterEvent):void
		{
			var data:* = event.result.response;
			
			this.fillColumn(data is Array ? data : [data]);
		}
		
		

	}
}
	