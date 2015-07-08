package com.spice.clove.plugin.bestBuy.mediate
{
	import com.adobe.serialization.json.JSON;
	import com.spice.clove.plugin.bestBuy.column.render.BestBuyReviewAttachment;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.mediate.IPluginCall;
	import com.spice.clove.plugin.mediate.IPluginCallHandler;
	import com.spice.clove.plugin.mediate.PluginMediator;
	import com.spice.clove.plugin.product.mediate.ITechProductCall;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class BestBuyReviewCallHandler implements IPluginCallHandler
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _call:ITechProductCall;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BestBuyReviewCallHandler()
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		
		public function answerCall(call:IPluginCall,controller:IPluginController):void
		{
			
			
			_call = ITechProductCall(call);
			
			
			//http://api.remix.bestbuy.com/v1/products%28type=hardgood&manufacturer=%22HTC*%22&name=%22Hero*%22&salePrice%3E=10%29?show=name&format=json&apiKey=k44jwna8ajzyzcacrbpaaapr
			var search:String= "http://api.remix.bestbuy.com/v1/products(manufacturer=\""+_call.manufacturer+"*\"&name=\""+_call.productName+"*\"&salePrice>"+_call.price+")?format=json&apiKey=k44jwna8ajzyzcacrbpaaapr";
			
			
			Logger.log("answerCall("+call+") search="+search,this);
			
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onProductData);
			loader.load(new URLRequest(search));
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onProductData(event:Event):void
		{
			
			Logger.log("onProductData()",this);
			
			var data:Object =  JSON.decode(event.target.data);
			
			var products:Array = data.products;
			
			
			if(products.length > 0)
				_call.responder.result(new BestBuyReviewAttachment("Check Best Buy for \""+_call.productName+"\"",products[0]));
			
			
		}
		

	}
}