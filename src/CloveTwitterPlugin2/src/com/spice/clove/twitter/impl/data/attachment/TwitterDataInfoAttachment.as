package com.spice.clove.twitter.impl.data.attachment
{
	import com.spice.clove.plugin.core.calls.CallIconViewControllerType;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.views.ICloveViewController;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.content.data.attachment.VisibleCloveDataAttachment;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.clove.twitter.impl.views.assets.TwitterAssets;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;

	public class TwitterDataInfoAttachment extends VisibleCloveDataAttachment
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */  
		
		public function TwitterDataInfoAttachment(type:String,viewController:ICloveDataViewController,icon:Class)
		{
			super(type,viewController);  
			
			ProxyCallUtils.quickCall(CallIconViewControllerType.VIEW_CONTROLLER_SET_ICON,viewController.getProxy(),icon);
		}
		
		
		
	}
}