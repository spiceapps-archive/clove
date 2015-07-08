package com.spice.clove.facebook.impl.content.control.render
{
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.render.AbstractCloveDataRenderer;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyMediator;

	public class FacebookFanPageDataRenderer extends AbstractCloveDataRenderer
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookFanPageDataRenderer(controller:CloveContentController,mediator:IProxyMediator)
		{
			super(controller,mediator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getUID(vo:Object):String
		{
			
			return "";
		}
		
		/**
		 */
		
		override public function setCloveData(vo:Object, data:ICloveData):Boolean
		{
			return false;
		}
	}
}