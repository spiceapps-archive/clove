package com.spice.clove.plugin.flex.views
{
	import com.spice.clove.plugin.core.calls.CallIconViewControllerType;
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.vanilla.core.proxy.IProxyCall;
	
	import mx.core.IDataRenderer;

	public class FXIconViewController extends CloveDataViewController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _icon:*;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FXIconViewController()
		{
			super(IconView);
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
				case CallIconViewControllerType.VIEW_CONTROLLER_GET_ICON: return this.respond(c,this.getIcon());
				case CallIconViewControllerType.VIEW_CONTROLLER_SET_ICON: return this.setIcon(c.getData());
			}
		}
		
		/**
		 */
		
		public function getIcon():*
		{
			return this._icon;
		}
		
		/**
		 */
		
		public function setIcon(value:*):void
		{
			this._icon = value;
			
			//TODO: have the view listen to the controller on icon change??
			//this might be best to allow any sub-classed FXIconViewControllers to use their own view...
			if(this._currentView)
			{
				IconView(this._currentView).source = value;
			}
			
			this.notifyChange(CallIconViewControllerType.VIEW_CONTROLLER_GET_ICON,value);
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setupNewView(content:Object, view:IDataRenderer):void
		{
			super.setupNewView(content,view);
			
			
			if(_icon)
			{
				IconView(view).source = _icon;
			}
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallIconViewControllerType.VIEW_CONTROLLER_GET_ICON,
									CallIconViewControllerType.VIEW_CONTROLLER_SET_ICON]);
		}
	}
}