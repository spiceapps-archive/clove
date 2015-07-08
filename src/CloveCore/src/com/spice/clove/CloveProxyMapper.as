package com.spice.clove
{
	import com.spice.clove.model.CloveInternalProxyMediator;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout;
	
	[Event(name="complete")]
	
	
	public class CloveProxyMapper extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _pluginProxyMediator:ClovePluginMediator = ClovePluginMediator.getInstance();
		private var _internalProxyMediator:CloveInternalProxyMediator = CloveInternalProxyMediator.getInstance();
		private var _handlers:Array;
		private var _model:CloveModelLocator;
		private var _complete:Boolean;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveProxyMapper()
		{
			this.init();
			
			flash.utils.setTimeout(this.complete,1);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get internalProxyMediator():CloveInternalProxyMediator
		{
			return this._internalProxyMediator;
		}
		
		
		/**
		 */
		public function get pluginProxyMediator():ClovePluginMediator
		{
			return this._pluginProxyMediator;
		}
		
		
		/**
		 * the root application uses this method to access the model locator.
		 * this is a safer way of instantiating it without breaking the app, since
		 * the bootstrap is needed before the ModelLocator can even be used.
		 */
		
		[Bindable(event="complete")]
		public function get model():CloveModelLocator
		{
			if(_complete && !_model)
			{
				_model = CloveModelLocator.getInstance();
			}
			return _model;
		}
		
		/**
		 */
		
		public function isComplete():Boolean
		{
			return _complete;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function init():void
		{
			
			//abstract
		}
		
		/**
		 */
		
		protected function complete():void
		{
			_complete = true;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
	}
}