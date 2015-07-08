package com.spice.clove.plugin.bestBuy.column.render
{
	import com.spice.clove.plugin.column.render.RenderedColumnDataAttachment;
	import com.spice.clove.plugin.icons.BestBuyIcons;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Alert;
	
	public class BestBuyReviewAttachment extends RenderedColumnDataAttachment
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var reviewData:Object;
        
        
        [Bindable] 
        public var reviews:String = "";
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */

		public function BestBuyReviewAttachment(label:String,data:Object)
		{
			super(label,BestBuyIcons.LOGO_ICON);
			
			this.reviewData = data;
			
			
			//http://reviews.bestbuy.com/3545a/7266638/reviews.htm?format=embedded
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get attachmentView():Class
		{
			return BestBuyReviewAttachmentView;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function addToCart():void
		{
			Logger.log("add to cart data="+this.reviewData,this);
			Logger.log("add to cart url="+this.reviewData.addToCartUrl,this);
			flash.net.navigateToURL(new URLRequest(this.reviewData.addToCartUrl));
		}
		
		/**
		 */
		
		public function fetchReviews():void
		{
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onReviewsLoad);
			loader.load(new URLRequest("http://reviews.bestbuy.com/3545a/"+this.reviewData.sku+"/reviews.htm?format=embedded"));
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onReviewsLoad(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onReviewsLoad);
			
			this.reviews = event.target.data;
		}
		
		
	}
}