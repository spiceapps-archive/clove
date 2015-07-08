package com.spice.clove.twitter.impl.content.control.render
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.IntSetting;
	import com.spice.vanilla.impl.settings.basic.NumberSetting;

	public class TwitterFavoritesDataRenderer extends TwitterSearchDataRenderer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var currentPage:Number = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterFavoritesDataRenderer(controller:CloveContentController,mediator:IProxyMediator)
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
		
		override public function setCloveData(vo:Object, data:ICloveData):Boolean
		{
			super.setCloveData(vo,data);
			
			IntSetting(data.getSettingTable().getNewSetting(BasicSettingType.INT,TwitterDataSetting.PAGE)).setData(currentPage);
			
			return true;
		}
	}
}