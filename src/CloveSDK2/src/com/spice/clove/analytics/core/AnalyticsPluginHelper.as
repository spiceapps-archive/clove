package com.spice.clove.analytics.core
{
	import com.spice.clove.analytics.core.calls.CallAnalyticsPluginType;
	import com.spice.clove.analytics.core.calls.data.RecordMetricData;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;

	public class AnalyticsPluginHelper
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _mediator:IProxyMediator;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AnalyticsPluginHelper(mediator:IProxyMediator)
		{
			this._mediator = mediator;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function recordAction(name:String,content:String = null,count:uint = 1,metadata:Object = null):void
		{
			ProxyCallUtils.quickCall(CallAnalyticsPluginType.ANALYTICS_RECORD_ACTION,this._mediator,new RecordMetricData(name,content,count,metadata));
		}
		
		
		/**
		 */  
		
		public function recordStartDateAction(name:String):void
		{
			this.recordAction(name);//the date automatically gets recorded on the server
		}
		
		
		/**
		 */
		
		public function addStickyTag(tag:Object):void
		{
			ProxyCallUtils.quickCall(CallAnalyticsPluginType.ANALYTICS_ADD_STICKY_TAG,this._mediator,tag);
		}
		
	}
}