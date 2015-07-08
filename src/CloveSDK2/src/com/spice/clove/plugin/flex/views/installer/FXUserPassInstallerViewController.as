package com.spice.clove.plugin.flex.views.installer
{
	import com.spice.clove.plugin.core.calls.CallUserPassInstallerViewControllerType;
	import com.spice.clove.plugin.core.views.ICloveViewController;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.flash.views.install.FLPluginInstallerViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	public class FXUserPassInstallerViewController extends FLPluginInstallerViewController implements IProxyResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _title:String;
		private var _target:IProxyOwner;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FXUserPassInstallerViewController(target:IProxyOwner)
		{
			super(FXUserPassInstallerView);
			
			_target = target;
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function setView(target:ICloveViewTarget):void
		{
			
			ProxyCallUtils.quickCall(CallUserPassInstallerViewControllerType.GET_TITLE,_target.getProxy(),null,this);
			
			super.setView(target);
		}
		
		/**
		 */
		
		public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallUserPassInstallerViewControllerType.GET_TITLE: return this.setTitle(n.getData());
			}
		}
		/**
		 */
		
		public function getTitle():String
		{
			return this._title;
		}
		
		
		/**
		 */
		public function setTitle(value:String):void
		{
			this._title = value;
		}
		
		/**
		 */
		
		public function setUsername(value:String):void
		{
			ProxyCallUtils.quickCall(CallUserPassInstallerViewControllerType.SET_USERNAME,_target.getProxy(),value);
		}
		
		/**
		 */
		
		public function setPassword(value:String):void
		{
			ProxyCallUtils.quickCall(CallUserPassInstallerViewControllerType.SET_PASSWORD,_target.getProxy(),value);
		}
		
	}
}