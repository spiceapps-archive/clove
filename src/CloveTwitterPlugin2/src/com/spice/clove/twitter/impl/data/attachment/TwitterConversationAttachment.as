package com.spice.clove.twitter.impl.data.attachment
{
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.render.AbstractCloveDataRenderer;
	import com.spice.clove.plugin.impl.content.data.attachment.CloveDataAttachment;
	import com.spice.clove.plugin.impl.content.data.attachment.VisibleCloveDataAttachment;
	import com.spice.clove.plugin.impl.icons.attachment.AttachmentIcons;
	import com.spice.clove.plugin.impl.views.RegisteredViewController;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.clove.service.core.account.content.control.IAccountContentController;
	import com.spice.clove.service.impl.account.content.control.AccountContentController;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.content.control.TwitterContentControllerFactory;
	import com.spice.clove.twitter.impl.content.control.render.TwitterDataSetting;
	import com.spice.clove.twitter.impl.content.control.render.TwitterSearchDataRenderer;
	import com.spice.clove.twitter.impl.content.control.sub.TwitterConversationContentController;
	import com.spice.clove.twitter.impl.views.assets.TwitterAssets;
	
	import mx.controls.Alert;

	public class TwitterConversationAttachment extends VisibleCloveDataAttachment
	{ 
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _renderer:ICloveDataRenderer;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterConversationAttachment(viewController:RegisteredCloveDataViewController,renderer:ICloveDataRenderer)
		{
			super( TwitterDataAttachmentType.CONVERSATION_ATTACHMENT,viewController);
			
			
			_renderer = renderer;
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getIcon():*
		{
			return AttachmentIcons.CONVERSATION;
		}
		
		/**
		 */
		
		override public function getLabel():String
		{
			return "Conversation";
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function visibleAttachmentClick():void
		{
			super.visibleAttachmentClick();  
			
			
			var renderer:TwitterSearchDataRenderer =  TwitterSearchDataRenderer(this._renderer).clone(false);
			
			var controller:TwitterConversationContentController = new TwitterConversationContentController(TwitterPlugin(renderer.getController().getPlugin()),renderer,Number(this.getMetadata().getData()));
			controller.setAccount(IAccountContentController(renderer.getController()).getAccount());
			renderer.getController().setBreadcrumb(controller);
		}
		
		
		
	}
}