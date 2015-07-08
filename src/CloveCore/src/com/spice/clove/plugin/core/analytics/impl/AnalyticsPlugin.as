package com.spice.clove.plugin.core.analytics.impl
{
	import com.adobe.serialization.json.JSON;
	import com.spice.clove.analytics.core.calls.CallAnalyticsPluginType;
	import com.spice.clove.analytics.core.calls.data.RecordMetricData;
	import com.spice.clove.plugin.core.analytics.impl.settings.AnalyticsPluginSettings;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class AnalyticsPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _stickyTags:Array;
		private var _appName:String;
		private var _actionBatch:Array;
		private var _recordActionsTimeout:int;
		private var _settings:AnalyticsPluginSettings;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AnalyticsPlugin(factory:AnalyticsPluginFactory)
		{  
			super("Analytics",
			      "com.spice.clove.plugin.core.analytics",
				  (this._settings = new AnalyticsPluginSettings()),
				  factory);
				  
			this._stickyTags = [];
			this._appName = 'Clove';
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallAnalyticsPluginType.ANALYTICS_ADD_STICKY_TAG: return this.addStickyTag(c.getData());
				case CallAnalyticsPluginType.ANALYTICS_RECORD_ACTION: return this.recordAction(c.getData());
			}
			
			super.answerProxyCall(c);
		}
		
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallAppCommandType.GET_APPLICATION_NAME: 
					this._appName = n.getData(); 
					return;
			}
			
			super.handleProxyResponse(n);
		}
		
		/**
		 */
		
		public function addStickyTag(tag:Object):void
		{
			this._stickyTags.push(tag);
		}
		
		/**
		 */
		
		public function recordAction(value:RecordMetricData):void
		{
			flash.utils.clearTimeout(this._recordActionsTimeout);
			this._recordActionsTimeout = flash.utils.setTimeout(recordActionBatch,10);
			
			
			if(!this._actionBatch)
			{
				this._actionBatch = [];
			}
			
			this._actionBatch.push(value);
		}
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		
		override protected function initialize():void
		{
			
			super.initialize();
			//get the application ONLY if it's present
			ProxyCallUtils.quickCall(CallAppCommandType.GET_APPLICATION_NAME,this.getPluginMediator(),null,this);

			this.finishInitialization();
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallAnalyticsPluginType.ANALYTICS_ADD_STICKY_TAG,
									CallAnalyticsPluginType.ANALYTICS_RECORD_ACTION]);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		private function recordActionBatch():void
		{
			var batch:Array = this._actionBatch;
			this._actionBatch = null;
			
			//kept SUPER simple because this is a heavy action, and it should be very light
			var request:URLRequest = new URLRequest(CloveUrls.ANALYTICS_URL);
			request.method =  URLRequestMethod.POST;
			
			
			var actions:Array = [];
			
			for each(var action:RecordMetricData in batch)
			{  
				actions.push(action.toObject(this._stickyTags));
				
			}
			
			var data:URLVariables = new URLVariables();
			data.actions		  = JSON.encode(actions);
			data.app			  = this._appName;
			data.visitor 		  = this._settings.getGuid();
				
			request.data = data;  
			
			//we listen to an IO error to shut the application up. We don't care about a response from the server.
			new URLLoader(request).addEventListener(IOErrorEvent.IO_ERROR,onFailSendAnalytics,false,0,true);
		}
		/**
		 */
		
		private function onFailSendAnalytics(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onFailSendAnalytics);
		}
	}
}