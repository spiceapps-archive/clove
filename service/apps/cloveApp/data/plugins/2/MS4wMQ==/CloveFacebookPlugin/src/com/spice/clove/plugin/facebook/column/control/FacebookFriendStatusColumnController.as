package com.spice.clove.plugin.facebook.column.control
{
	import com.facebook.commands.status.GetStatus;
	import com.facebook.data.status.GetStatusData;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.facebook.column.control.sub.FacebookCommentController;
	import com.spice.clove.plugin.facebook.column.render.FacebookFriendStatusItemRenderer;
	import com.spice.clove.plugin.facebook.cue.FacebookCallCue;
	import com.spice.clove.plugin.facebook.data.FriendInfo;
	
	import mx.binding.utils.BindingUtils;

	public class FacebookFriendStatusColumnController extends FacebookColumnController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		[Bindable] 
		[Setting]
		public var friend:FriendInfo;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookFriendStatusColumnController(controller:IPluginController = null)
		{
			
			this.title = "Friend Status";
			
			var render:FacebookFriendStatusItemRenderer = new FacebookFriendStatusItemRenderer();
		 	BindingUtils.bindProperty(render,"friend",this,"friend");
			
			super(controller,render);
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
			if(!this.friend)
				return;
				
			this.call(new FacebookCallCue(new GetStatus(this.friend.friendID,30),onResult));
		}
		
		override protected function onRenderedDataDoubleClick(event:CloveColumnEvent):void
		{
			this.setBreadcrumb(new FacebookCommentController(event.data.rowuid));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onResult(data:GetStatusData):void
		{
			this.fillColumn(data.status);
		}
	}
}