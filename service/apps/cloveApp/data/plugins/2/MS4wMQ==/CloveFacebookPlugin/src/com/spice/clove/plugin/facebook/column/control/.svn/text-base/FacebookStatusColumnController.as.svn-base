package com.spice.clove.plugin.facebook.column.control
{
	import com.facebook.commands.stream.AddLike;
	import com.facebook.data.*;
	import com.facebook.data.stream.GetStreamData;
	import com.facebook.data.stream.StreamStoryData;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.ColumnSaveType;
	import com.spice.clove.plugin.column.ICloveColumn;
	import com.spice.clove.plugin.column.render.ICloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.facebook.column.control.sub.FacebookCommentController;
	import com.spice.clove.plugin.facebook.column.render.FacebookStatusItemRenderer;
	import com.spice.clove.plugin.facebook.cue.StreamCallCue;
	import com.spice.clove.plugin.facebook.data.FriendInfo;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;
	import com.spice.clove.plugin.facebook.postable.FacebookReplyPostable;
	
	public class FacebookStatusColumnController extends FacebookColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		
		[Bindable] 
		[Setting]
		public var friend:FriendInfo;
		
		[Bindable] 
		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
		
		private var _filterKey:String;
		
		private var _previousFriendInfo:FriendInfo;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		

        
		public function FacebookStatusColumnController(controller:IPluginController = null,
													   renderer:ICloveColumnItemRenderer = null,
													   filterName:String = "Status Updates",
													   friend:FriendInfo = null)
		{
			super(controller,renderer ? renderer : new FacebookStatusItemRenderer());
			
			_filterKey = filterName;
			
			this.friend = friend;
			
			
			var menus:Array = [
								{
									label:"Reply",
									callback:replyToWallPost
									
								},
								{
									label:"Like",
									callback:likePost
								}
							  ];
			
			
			
			this.menuActions = menus;
			
			this.title = "Facebook Status";
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function set column(value:ICloveColumn):void
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
		
		override protected function onRenderedDataDoubleClick(event:CloveColumnEvent):void
		{
			this.setBreadcrumb(new FacebookCommentController(event.data.rowuid));
		}
		
		/**
		 */
		
		override protected function loadOlderContent(data:RenderedColumnData) : void
		{
			
			var lastDate:Date = new Date(Number(data.datePosted));
			
			var weekBefore:Date = new Date(lastDate.getTime() - (1000*60*60*24*7));
			var dayBefore:Date   = new Date(lastDate.getTime() - (1000*60*60*24));
			
			
			this.loadStream(weekBefore,dayBefore);
			
		}
        /**
		 */
		 
		override protected function onColumnStartLoad(event:CloveColumnEvent):void
		{
			
			Logger.log("onColumnStartLoad",this);
			var now:Date = new Date();
			var lastWeek:Date = new Date(now.getTime() - (1000*60*60*24*7));
			
			this.loadStream(lastWeek,now);
			
		}
		
		private function loadStream(startTime:Date,endTime:Date):void
		{
			//NOTE: for some reason, either Facebook caches requests, or something is screwy. newer content
			//doesn't show right away
			
			var fid:String = this.friend ? this.friend.friendID : null;
			
			if(_previousFriendInfo && this.friend != this._previousFriendInfo)
			{
				this.column.history.removeAllItems();
			}
			
			this._previousFriendInfo = this.friend;
			
			this.call(new StreamCallCue(onGetStream,[fid],startTime,endTime,_filterKey));
		}
		
		/**
		 */
		
		protected function onGetStream(result:GetStreamData):void
		{
			var stories:Array = result.stories.toArray();
			
			var st2:Array = [];
			
			for each(var story:* in stories)
			{
				
				if(story is StreamStoryData && StreamStoryData(story).message == '')
					continue;
				
					
				st2.push(story);
			}
			
			
			
			this.fillColumn(st2, ColumnSaveType.FILL_NEW);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function replyToWallPost(item:RenderedColumnData):void
		{
			
			var name:String =  _model.friendModel.getFriendInfo(item.vo.source_id).name;
			
			
			this.addActivePostable(new FacebookReplyPostable(this.pluginController,"RE: "+name,item.vo.post_id));
		}
		
		/**
		 */
		
		private function likePost(item:RenderedColumnData):void
		{
			this.call(new AddLike(item.rowuid));
		}

	}
}