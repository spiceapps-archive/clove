package com.spice.clove.twitter.impl.content.control.render
{
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.data.CloveDataSettingName;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.render.AbstractCloveDataRenderer;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.clove.twitter.impl.content.control.TwitterContentControllerType;
	import com.spice.clove.twitter.impl.content.control.search.TwitterKeywordSearchContentController;
	import com.spice.clove.twitter.impl.content.control.search.TwitterUserSearchContentController;
	import com.spice.clove.twitter.impl.data.attachment.TwitterDataAttachmentFactory;
	import com.spice.clove.twitter.impl.data.attachment.TwitterDataAttachmentType;
	import com.spice.clove.twitter.impl.data.attachment.TwitterDataInfoAttachmentFactory;
	import com.spice.impl.text.command.handle.link.TextCommandLinkHandler;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.core.settings.ISettingFactory;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.NumberSetting;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	public class TwitterSearchDataRenderer extends AbstractCloveDataRenderer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		  
		private var _useConversation:Boolean;
		private var _controller:CloveContentController;
		private var _settingFactory:ISettingFactory;
		private var _mediator:IProxyMediator;
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const MENTION_HANDLER:String = "twitMention";
		public static const HASHTAG_HANDLER:String = "hashtagHandler";
		
		
		public static const USERNAME_SEARCH_REGEXP:String = '(?<=[^\\w]@|^@)(\\w+)';
		public static const HASH_SEARCH_REGEXP:String = '(?<!")(#([\\w]+))(?!")';
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterSearchDataRenderer(controller:CloveContentController,
												  mediator:IProxyMediator,
												  showConversationAttachment:Boolean = true)
		{  
			this._useConversation = showConversationAttachment;
			
			_mediator = mediator;
			
			super(controller,mediator);	
			
			_controller = controller;
			
			
			this.setAttachmentsFactory(CloveDataSettingName.ATTACHMENTS,new TwitterDataAttachmentFactory(mediator,this));
			this.setAttachmentsFactory(CloveDataSettingName.INFORMATIVE_ATTACHMENTS,new TwitterDataInfoAttachmentFactory(mediator));
			
			//@username
			this.getTextManager().addTextHandler(new TextCommandLinkHandler(USERNAME_SEARCH_REGEXP,"#FF4000",MENTION_HANDLER));
			
			//#hashtag
			this.getTextManager().addTextHandler(new TextCommandLinkHandler(HASH_SEARCH_REGEXP,"#666666",HASHTAG_HANDLER));
			
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function setCloveData(vo:Object, data:ICloveData):Boolean
		{
			super.setCloveData(vo,data);
			
			try
			{
				//data.set
				data.construct(vo.id,
							   vo.createdAt,
							   vo.fromUser.screenName,
							   vo.text,
							   vo.fromUser.profileImageUrl);
				
				var st:ISettingTable = data.getSettingTable();
				
				
				StringSetting(st.getNewSetting(BasicSettingType.STRING,TwitterDataSetting.USERNAME)).setData(vo.fromUser.screenName);
				NumberSetting(st.getNewSetting(BasicSettingType.NUMBER,TwitterDataSetting.USER_ID)).setData(vo.fromUser.id);
				
				
				if(/*this._useConversation && 
					*/vo.hasOwnProperty("inReplyToStatusId") && 
					vo.inReplyToStatusId > 0)
				{
					
					this.addMetadata(TwitterDataAttachmentType.CONVERSATION_ATTACHMENT,data.getUID());
				}
//				
//				
//				var setting:CloveDataAttachmentListSetting = CloveDataAttachmentListSetting(st.getNewSetting(CloveDataSettingType.ATTACHMENT_LIST,CloveDataSettingName.INFORMATIVE_ATTACHMENTS));
//				
//				
//				
//				if(vo.hasOwnProperty("favorited") && vo.favorited)
//				{
//					var fav:VisibleCloveDataAttachment = VisibleCloveDataAttachment(this.getAttachmentsFactory(CloveDataSettingName.INFORMATIVE_ATTACHMENTS).getNewAttachment(TwitterDataInfoAttachmentType.FAVORITED));
//				
//					setting.addVisibleAttachment(fav);
//				}
				
				
				
				
				this.setMessageReplacements(vo,data);
				
			}catch(e:Error)
			{
				Logger.logError(e);
				return false;
			}
			
			return this.filterCloveData(data);
		}
		
		
		/**
		 */
		
		override protected function linkSelected(value:String,type:String):void
		{
			switch(type)
			{
				case MENTION_HANDLER: return this.addMentions(value);
				case HASHTAG_HANDLER: return this.addSearch(value);
			}
			
			super.linkSelected(value,type);
		}
		
		
		/**
		 */
		
		override protected function dataIconClick(data:ICloveData):void
		{
			this.addMentions(StringSetting(data.getSettingTable().getSetting(TwitterDataSetting.USERNAME)).getData());
		}
		
		/**
		 */
		
		override public function getUID(vo:Object):String
		{
			return vo.id;
		}
		
		
		/**
		 */
		
		public function getController():CloveContentController
		{
			return this._controller;
		}
		
		/**
		 */
		
		public function clone(showConversation:Boolean = true):TwitterSearchDataRenderer
		{
			return new TwitterSearchDataRenderer(this._controller,this._mediator,showConversation);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function addMentions(value:String):void
		{
			  
			_controller.setBreadcrumb(new TwitterUserSearchContentController( TwitterContentControllerType.USER_SEARCH,this._controller.getPlugin(),value));
		}
		
		/**
		 */
		
		private function addSearch(value:String):void
		{
			_controller.setBreadcrumb(new TwitterKeywordSearchContentController( TwitterContentControllerType.KEYWORD_SEARCH,this._controller.getPlugin(),value));
			
		}
	}
}