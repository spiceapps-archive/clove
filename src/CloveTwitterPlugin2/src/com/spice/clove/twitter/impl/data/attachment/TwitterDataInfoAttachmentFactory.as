package com.spice.clove.twitter.impl.data.attachment
{
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachment;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachmentFactory;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.clove.twitter.impl.views.assets.TwitterAssets;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyMediator;

	public class TwitterDataInfoAttachmentFactory implements ICloveDataAttachmentFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _favViewController:RegisteredCloveDataViewController;
		private var _rtViewController:RegisteredCloveDataViewController;
		private var _followingViewController:RegisteredCloveDataViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterDataInfoAttachmentFactory(mediator:IProxy)
		{
			_favViewController = new RegisteredCloveDataViewController(CallRegisteredViewType.GET_NEW_REGISTERED_ICON_VIEW_CONTROLLER,mediator);
			_rtViewController = new RegisteredCloveDataViewController(CallRegisteredViewType.GET_NEW_REGISTERED_ICON_VIEW_CONTROLLER,mediator);
			_followingViewController = new RegisteredCloveDataViewController(CallRegisteredViewType.GET_NEW_REGISTERED_ICON_VIEW_CONTROLLER,mediator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getNewAttachment(name:String):ICloveDataAttachment
		{
			switch(name)
			{
				case TwitterDataInfoAttachmentType.FAVORITED: return new TwitterDataInfoAttachment(name,_favViewController,TwitterAssets.STAR);
//				case TwitterDataInfoAttachmentType.FOLLOWING_USER: return new TwitterDataInfoAttachment(name,_favViewController,TwitterAssets.STAR);
				case TwitterDataInfoAttachmentType.RETWEETED: return new TwitterDataInfoAttachment(name,_rtViewController,TwitterAssets.REPOST);
			}
			
			return null;
		}
	}
}