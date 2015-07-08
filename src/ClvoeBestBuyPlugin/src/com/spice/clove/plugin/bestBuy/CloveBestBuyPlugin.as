package com.spice.clove.plugin.bestBuy
{
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.plugin.ClovePlugin;
	import com.spice.clove.plugin.bestBuy.mediate.BestBuyReviewCallHandler;
	import com.spice.clove.plugin.bestBuy.views.GoToBestBuyCartButton;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.product.mediate.ProductCallType;
	
	public class CloveBestBuyPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CloveBestBuyPlugin()
		{
			
			super(new CloveBestBuySettings());
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function initialize(controller:IPluginController):void
		{
			super.initialize(controller);
			
			//register the call handler so that other plugins can check product details for their items
			controller.mediator.addCallHandler(ProductCallType.GET_TECH_PRODUCT_INFO,new BestBuyReviewCallHandler,controller);
			
			new CloveEvent(CloveEvent.ADD_FOOTER_VIEW,new GoToBestBuyCartButton()).dispatch();
			
			this.complete();
		}

	}
}