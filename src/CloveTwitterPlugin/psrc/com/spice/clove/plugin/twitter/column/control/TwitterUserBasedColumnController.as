package com.spice.clove.plugin.twitter.column.control
{
	
	import com.architectd.twitter.calls.friendship.CreateFriendshipCall;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.events.plugin.ColumnControllerEvent;
	import com.spice.clove.plugin.column.*;
	import com.spice.clove.plugin.column.render.*;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.clove.plugin.twitter.column.control.render.RenderedColumnDataTwitterRefAttachment;
	import com.spice.clove.plugin.twitter.column.control.render.RenderedColumnDataTwitterSearchAttachment;
	import com.spice.clove.plugin.twitter.column.control.render.TwitterRowItemRenderer;
	import com.spice.clove.plugin.twitter.column.control.sub.TwitterConversationController;
	import com.spice.clove.plugin.twitter.posting.TwitterDMPostable;
	import com.spice.events.TextCommandHandlerEvent;
	import com.spice.utils.textCommand.handle.TextCommandResultController;
	import com.spice.utils.textCommand.link.LinkifyHandler2;
	
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	
	
	/**
	 * TUserBasedColumn column is the super class of columns that contain tweets
	 * @author craigcondon
	 * 
	 */	
	public class TwitterUserBasedColumnController extends  TwitterColumnController
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _mentionsLinkHandler:LinkifyHandler2;
		private var _hashtagLinkHandler:LinkifyHandler2;
		
		private var _menuOptions:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterUserBasedColumnController(controller:IPluginController = null,itemRenderer:TwitterRowItemRenderer = null)
		{
			super(controller,itemRenderer);
			
			
			
			_menuOptions = [
							 	{
			 						label:"Follow",
			 						callback:follow
			 					},
			 					{
			 						label:"Unfollow",
			 						callback:unfollow
			 					},
			 					{
			 						label:"Retweet",
			 						callback:quoteTweet
			 					},
			 					{
			 						label:"Reply",
			 						callback:reply
			 					},
			 					{
			 						label:"Direct Message",
			 						callback:directMail
			 					}/* ,
			 					{
			 						label:"favorite",
			 						callback:markFavorite
			 					} */
						     ];
			
			
			//since we're regstering text that's colored, we enable the ability to stylt the text
			var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Twitter");
			
			
			var mentionsColor:String = "#FF4000";
			var keywordColor:String  = "#666666";
			
			
			if(style)
			{
				mentionsColor = style.getStyle("mentionsTextColor") ? "#"+style.getStyle("mentionsTextColor").toString(16) : mentionsColor; 
				keywordColor  = style.getStyle("keywordTextColor")   ? "#"+style.getStyle("keywordTextColor").toString(16)  : keywordColor; 
			}
			
			
			this._mentionsLinkHandler = new LinkifyHandler2('(?<=[^\\w]@|^@)(\\w+)',null,mentionsColor,'$1');
			this._hashtagLinkHandler  = new LinkifyHandler2('(?<!")(#([\\w]+))(?!")',null,keywordColor);
			
			this._mentionsLinkHandler.addEventListener(TextCommandHandlerEvent.TEXT_FOUND,onUserFound);
			this._hashtagLinkHandler.addEventListener(TextCommandHandlerEvent.TEXT_FOUND,onHashTagClick);
			
			this.janitor.addDisposable(this._mentionsLinkHandler);
			this.janitor.addDisposable(this._hashtagLinkHandler);
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
			
			//add the menu list
			this.dispatchEvent(new ColumnControllerEvent(ColumnControllerEvent.ADD_MENU_OPTIONS,this._menuOptions));
			
			//add the message handler to process data 
			this.dispatchEvent(new ColumnControllerEvent(ColumnControllerEvent.ADD_CACHED_MESSAGE_HANDLER,this._mentionsLinkHandler));
			this.dispatchEvent(new ColumnControllerEvent(ColumnControllerEvent.ADD_CACHED_MESSAGE_HANDLER,this._hashtagLinkHandler));
			
			
		}
		
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
       
        /**
		 */
		
		private function reply(data:RenderedColumnData):void
		{
			
			this.addWallPostable();
			
			new CloveEvent(CloveEvent.COPY_TO_POSTER,"@"+data.vo.user.screenName+" ").dispatch();
		}
		
		/**
		 */
		
		private function directMail(data:RenderedColumnData):void
		{
			new CloveEvent(CloveEvent.ADD_ACTIVE_POSTABLE,new TwitterDMPostable(this.pluginController,data.vo.user.screenName)).dispatch();
			
		}
		
		/**
		 */
		
		private function quoteTweet(data:RenderedColumnData):void
		{
			
			this.addWallPostable();
			
			new CloveEvent(CloveEvent.COPY_TO_POSTER,"RT @"+data.vo.user.screenName+" "+data.message).dispatch();
			
			
		}
		
		/**
		 */
		
		private function markFavorite(data:RenderedColumnData):void
		{
			//nothing for now
		}
		
		
		/**
		 */
		
		protected function follow(data:RenderedColumnData):void
		{
			var user:String = data.vo.user.screenName as String;
			
			
			this.call(new CreateFriendshipCall(user));
					  
		}
		
		/**
		 */
		
		protected function unfollow(data:RenderedColumnData):void
		{
			
			/*this.call(_twitter.unfollowUser,
					  TweetEvent.COMPLETE,
					  null,
					  data.vo.user.screenName);*/
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function onRendereDataIconClick(event:CloveColumnEvent):void
		{
			
			var col:TwitterUserSearchColumnController = new TwitterUserSearchColumnController();
			col.search = event.data.vo.user.screenName;
			
			this.setBreadcrumb(col);
			
		}
		
		/**
		 */
		
		override protected function onRenderedDataDoubleClick(event:CloveColumnEvent):void
		{
//			var data:RenderedColumnData = event.data;
			
			
//			navigateToURL(new URLRequest("http://twitter.com/"+data.vo.user.screenName+"/status/"+data.vo.id));

			this.setBreadcrumb(new TwitterConversationController(event.data.rowuid));
			
		}
		
		/**
		 */
		
		protected function addWallPostable():void
		{
			CloveTwitterPlugin(this.pluginController.plugin).addActivePostable();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onUserFound(event:TextCommandHandlerEvent):void
		{
			var controller:TextCommandResultController = event.controller;
			
			var data:RenderedColumnData = RenderedColumnData(controller.target.target);
			
			
			var user:String = event.controller.resultTest[0];
			
//			data.addAttachment(new RenderedColumnDataAttachment());
//			var c:RenderedColumnDataTwitterRefAttachment;
			
			data.addAttachment(new RenderedColumnDataTwitterRefAttachment(user));
			
		}
		
		
		private function onHashTagClick(event:TextCommandHandlerEvent):void
		{
			var controller:TextCommandResultController = event.controller;
			
			var data:RenderedColumnData = RenderedColumnData(controller.target.target);
			
			
			var user:String = event.controller.resultTest[0];
			
			
			
			data.addAttachment(new RenderedColumnDataTwitterSearchAttachment(user));
		}
		
	}
}