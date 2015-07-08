package com.spice.clove.twitter.impl.content.control.option
{
	import com.spice.clove.plugin.core.content.control.option.menu.ICloveDataMenuOption;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.content.control.option.menu.CloveDataMenuOption;
	import com.spice.clove.plugin.impl.views.content.control.option.AbstractDataOptionViewController;
	import com.spice.clove.post.core.calls.CallToPostPluginType;
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;
	import com.spice.clove.twitter.impl.content.control.ITwitterContentController;
	import com.spice.clove.twitter.impl.content.control.render.TwitterDataSetting;
	import com.spice.clove.twitter.impl.outgoing.TwitterDMPostable;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyResponseObserver;

	public class TwitterDataOptionViewController extends AbstractDataOptionViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _menuOptions:Array;
		private var _controller:ITwitterContentController;
//		private var _factory:Twitter
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterDataOptionViewController(mediator:IProxyMediator,controller:ITwitterContentController,useExtra:Array = null)
		{
			super(mediator);
			
			_controller = controller;
			
			_menuOptions = 
				[
					TwitterDataOptionType.DELETE_POST,
					TwitterDataOptionType.DIRECT_MESSAGE,
					TwitterDataOptionType.FOLLOW,
					TwitterDataOptionType.FOLLOWING,
					TwitterDataOptionType.UNFOLLOWING,
					TwitterDataOptionType.FAVORITE,
					TwitterDataOptionType.FAVORITING,
					TwitterDataOptionType.UNFAVORITING,
					TwitterDataOptionType.QUOTE,
					TwitterDataOptionType.REPLY
				];
			
			
			_menuOptions = (useExtra?useExtra:[]).concat(_menuOptions);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getAccount():TwitterPluginAccount
		{
			return TwitterPluginAccount(this._controller.getAccount());
		}
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case TwitterDataOptionType.QUOTE: return this.quote(n.getData());
				case TwitterDataOptionType.REPLY: return this.reply(n.getData());	
				case TwitterDataOptionType.FOLLOW: return this.follow(n.getData());
				case TwitterDataOptionType.RETWEET: return this.retweet(n.getData());
				case TwitterDataOptionType.UNFOLLOW: return this.unfollow(n.getData());	
				case TwitterDataOptionType.FAVORITE: return this.favorite(n.getData());	
				case TwitterDataOptionType.UNFAVORITE: return this.unfavorite(n.getData());	
//				case TwitterDataOptionType.: return this.reportAsSpam(n.getData());	
				case TwitterDataOptionType.DELETE_POST: return this.deletePost(n.getData());	
				case TwitterDataOptionType.DIRECT_MESSAGE: return this.directMessage(n.getData());	
				case TwitterDataOptionType.DELETE_DIRECT_MESSAGE: return this.deleteDirectMessage(n.getData());	
			}
			
			super.handleProxyResponse(n);
		}
		
		
		/**
		 */
		
		
		public function directMessage(target:ICloveData):void
		{
			this.addAccountIfNone();
			
			ProxyCallUtils.quickCall(CallToPostPluginType.ADD_ACTIVE_POSTABLE,this.getProxyMediator(),new TwitterDMPostable(target,this.getAccount()));
		}
		
		/**
		 */
		
		public function deleteDirectMessage(target:ICloveData):void
		{
		
		}
		
		/**
		 */
		  
		public function quote(target:ICloveData):void
		{
			this.addAccountIfNone();
			
			var tx:String = target.getMessage().replace(/<[^<]+?>/gi,"");//new RegExp("<[^<]+?>", "gi");
			this.copyTextToPostWindow(tx+" /by @"+target.getTitle());
		}
		
		/**
		 */
		
		public function retweet(target:ICloveData):void
		{
			//retweet	
		}
		
		/**
		 */
		
		public function reply(target:ICloveData):void
		{	
			this.copyTextToPostWindow("@"+target.getTitle());
		}
		
		/**
		 */
		
		public function favorite(target:ICloveData):void
		{
			this.addAccountIfNone();
			
			
//			var infAttachments:CloveDataAttachmentListSetting = CloveDataAttachmentListSetting(target.getSettingTable().getNewSetting(CloveDataSettingType.ATTACHMENT_LIST,CloveDataSettingName.INFORMATIVE_ATTACHMENTS));
//			
//			
//			
//			if(!infAttachments.hasAttachment(TwitterDataInfoAttachmentType.FAVORITED))
//			{
//				var att:VisibleCloveDataAttachment = VisibleCloveDataAttachment(TwitterSearchDataRenderer(target.getItemRenderer()).getAttachmentsFactory(CloveDataSettingName.INFORMATIVE_ATTACHMENTS).getNewAttachment(TwitterDataInfoAttachmentType.FAVORITED));
//				
//				infAttachments.addVisibleAttachment(att);
//				
//				
//				ProxyCallUtils.quickCall(CallCloveDataType.UPDATE_CLOVE_DATA,target.getProxy());
//			}
//			
//			this.getAccount().connection.favorite(Number(target.getUID()));
		}
		
		/**
		 */
		
		public function unfavorite(target:ICloveData):void
		{
			this.addAccountIfNone();
			
//			var infAttachments:CloveDataAttachmentListSetting = CloveDataAttachmentListSetting(target.getSettingTable().getNewSetting(CloveDataSettingType.ATTACHMENT_LIST,CloveDataSettingName.INFORMATIVE_ATTACHMENTS));
//			
//			infAttachments.removeAttachmentsByType(TwitterDataInfoAttachmentType.FAVORITED);
//			
//			
//			ProxyCallUtils.quickCall(CallCloveDataType.UPDATE_CLOVE_DATA,target.getProxy());
//			
//			this.getAccount().connection.unfavorite(Number(target.getUID()));
		}
		
		/**
		 */
		
		public function deletePost(target:ICloveData):void
		{
			
		}
		
		/**
		 */
		
//		public function reportAsSpam(target:ICloveData):void
//		{
//			
//		}
		
		
		/**
		 */
		
		public function follow(target:ICloveData):void
		{
			this.addAccountIfNone();
			
			this.getAccount().connection.follow(TwitterDataSetting.getUsername(target));
		}
		
		/**
		 */
		
		public function unfollow(target:ICloveData):void
		{
			this.addAccountIfNone();
			
			
			this.getAccount().connection.unfollow(TwitterDataSetting.getUsername(target));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		protected function copyTextToPostWindow(text:String):void
		{
			this.addAccountIfNone();
			
			ProxyCallUtils.quickCall(CallToPostPluginType.ADD_TEXT_TO_POST_WINDOW,this.getProxyMediator(),text);
		}
		/**
		 */
		
		override protected function setDataOptionsToUse(data:Object):void
		{
			super.setDataOptionsToUse(data);
			
			var options:Array = [];
			
			
			var username:String = TwitterDataSetting.getUsername(ICloveData(data));
			var id:Number = Number(ICloveData(data).getUID());
			
			this.setEnabled(TwitterDataOptionType.FOLLOWING,false);
			this.setEnabled(TwitterDataOptionType.UNFOLLOWING,false);
			this.setEnabled(TwitterDataOptionType.FAVORITING,false);
			this.setEnabled(TwitterDataOptionType.UNFAVORITING,false);
			
			//if the user is being followed, then show the unfollow menu item ONLY
			if(this.getAccount() && this.getAccount().getTwitterSettings().getFollowing().hasString(username))
			{
				
				
				if(this.getAccount() && this.getAccount().connection.getWaitingToUnfollow().indexOf(username) == -1)
					options.push(TwitterDataOptionType.UNFOLLOW);
				else
					options.push(TwitterDataOptionType.UNFOLLOWING);
			}
			else
			{
				//if we're not contacting the server, then show follow
				if(!this.getAccount() || this.getAccount().connection.getWaitingToFollow().indexOf(username) == -1)
					options.push(TwitterDataOptionType.FOLLOW);
				else
					//give the loading menu item if we're currently trying to get a response from the server
					options.push(TwitterDataOptionType.FOLLOWING);
			}
			
			
			//if the user is being followed, then show the unfollow menu item ONLY
			if(this.getAccount() && this.getAccount().getTwitterSettings().getFavorites().hasNumber(id))
			{
				if(this.getAccount().connection.getWaitingToUnfavorite().indexOf(id) == -1)
					options.push(TwitterDataOptionType.UNFAVORITE);
				else
					options.push(TwitterDataOptionType.UNFAVORITING);
			}
			else
			{
				//if we're not contacting the server, then show follow
				if(!this.getAccount() || this.getAccount().connection.getWaitingToFavorite().indexOf(id) == -1)
					options.push(TwitterDataOptionType.FAVORITE);
				else
					//give the loading menu item if we're currently trying to get a response from the server
					options.push(TwitterDataOptionType.FAVORITING);
			}  
			
//			options.push(TwitterDataOptionType.DELETE_DIRECT_MESSAGE);
			options.push(TwitterDataOptionType.DIRECT_MESSAGE);
//			options.push(TwitterDataOptionType.RETWEET);
			options.push(TwitterDataOptionType.REPLY);
			options.push(TwitterDataOptionType.QUOTE);
			
			this.useMenuItems(options);
			
//			this.ignoreMenuOption(TwitterDataOptionType.DELETE_DIRECT_MESSAGE);
			
		}
		
		/**
		 */
		
		override protected function setupAvailableMenuItems():void
		{
			super.setupAvailableMenuItems();
			
			this.setAvailableMenuItems(this._menuOptions);
		}
		
		/**
		 */
		
		override protected function createMenuItem(name:String):ICloveDataMenuOption
		{
			var checked:Boolean;
			
			switch(name)
			{
				case TwitterDataOptionType.UNFOLLOW:
				case TwitterDataOptionType.UNFAVORITE: 
					checked = true;
				break;
			}
			
			return new CloveDataMenuOption(new ProxyResponseObserver(name,this),false,checked); 
		}
		
		
		/**
		 */
		
		private function addAccountIfNone():void
		{
			
			//if there are no accounts, then make one
			if(this._controller.getTwitterPlugin().getAccounts().length == 0)
			{
				this._controller.getTwitterPlugin().addAcount()
			}
			
			//if the account is null, then set to the first account available
			if(!this.getAccount())
			{	
				this._controller.setAccount(this._controller.getTwitterPlugin().getAccountAt(0));
			}
		}
		
		
	}
}