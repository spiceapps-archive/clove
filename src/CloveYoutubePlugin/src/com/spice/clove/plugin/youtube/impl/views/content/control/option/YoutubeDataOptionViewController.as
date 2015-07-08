package com.spice.clove.plugin.youtube.impl.views.content.control.option
{
	import com.spice.clove.plugin.impl.views.content.control.option.AbstractDataOptionViewController;
	import com.spice.vanilla.core.proxy.IProxyMediator;

	public class YoutubeDataOptionViewController extends AbstractDataOptionViewController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeDataOptionViewController(mediator:IProxyMediator)
		{
			super(mediator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setDataOptionsToUse(data:Object):void
		{
			super.setDataOptionsToUse(data);
		}
	}
}