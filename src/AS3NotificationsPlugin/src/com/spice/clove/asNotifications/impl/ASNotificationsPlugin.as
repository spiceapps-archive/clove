package com.spice.clove.asNotifications.impl
{
	import com.adobe.air.notification.AbstractNotification;
	import com.spice.clove.asNotifications.impl.views.NotificationManager;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.data.ToasterNotificationData;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;

	public class ASNotificationsPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _pur:NotificationManager;
		private var _queue:Array;
		
		public static const MAX_NOTIFICATIONS:int = 4;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ASNotificationsPlugin(factory:ASNotificationsPluginFactory)
		{
			super("AS3 Notifications","com.spice.clove.asNotifications",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
			
			_queue = [];
		}
		
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallAppCommandType.DISPATCH_TOASTER_NOTIFICATION:return this.sendToasterNotification(call.getData());
			}
			
			super.answerProxyCall(call);
		}
		
		/**
		 */
		
		override public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallAppCommandType.DATA_PROCESSED: return this.showDataProcessed(n.getData());	
			}
			
			super.notifyProxyBinding(n);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		private var _showNotificationsTimeout:int;
		
		/**
		 */
		
		protected function showDataProcessed(data:Array):void
		{
			flash.utils.clearTimeout(_showNotificationsTimeout);
			this._showNotificationsTimeout = flash.utils.setTimeout(showNotifications,5000);
			
			this._queue = this._queue.concat(data);
			
//			_pur.alert("New Co",NativeApplication.nativeApplication.activeWindow);
		}
		
		/**
		 */
		
		private function showNotifications():void
		{
			for(var i:int = 0, n:int = this._queue.length; i < MAX_NOTIFICATIONS && i < n; i++)
			{
				this._pur.addNotification(this._queue.shift());
			}
			this._queue = [];
			
//			this._pur.addNotification(new Clo
		}
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			new ProxyCall(CallAppCommandType.DATA_PROCESSED,this.getPluginMediator(),null,null,this).dispatch();
			
			_pur = new NotificationManager();
			
			this.finishInitialization();
		}
		/**
		 */
		protected function sendToasterNotification(value:ToasterNotificationData):void
		{
			Alert.show(value.title);
		
		}
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			
			
			this.addAvailableCalls([CallAppCommandType.DISPATCH_TOASTER_NOTIFICATION]);
		}
	}
}