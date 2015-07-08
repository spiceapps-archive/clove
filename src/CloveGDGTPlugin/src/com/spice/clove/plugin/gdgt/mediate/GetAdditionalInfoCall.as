package com.spice.clove.plugin.gdgt.mediate
{
	import com.spice.clove.plugin.column.render.IRenderedColumnDataAttachment;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.mediate.PluginCall;
	import com.spice.clove.plugin.product.mediate.ITechProductCall;
	import com.spice.clove.plugin.product.mediate.ProductCallType;
	
	import mx.rpc.IResponder;
	
	public class GetAdditionalInfoCall extends PluginCall implements ITechProductCall, IResponder
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _productName:String;
		private var _manufacturer:String;
		private var _price:Number;
		private var _data:RenderedColumnData;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function GetAdditionalInfoCall(manufacturer:String,productName:String,price:Number,data:RenderedColumnData)
		{
			super(ProductCallType.GET_TECH_PRODUCT_INFO,this);
			
			this._manufacturer = manufacturer;
			this._price = price;
			
			_productName = productName;
			_data = data;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		public function get productName():String
		{
			return _productName;
		}
		
		/*
		 */
		
		public function get manufacturer():String
		{
			return this._manufacturer;
		}
		
		/*
		 */
		
		public function get price():Number
		{
			return this._price;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function result(data:Object):void
		{
			
			Logger.log("fetch additional info result",this);
			
			//YUCK-- ONLY FOR DEMO
			for each(var att:IRenderedColumnDataAttachment in _data.attachments.source)
			{
				if(att.label == data.label)
					return;
			}
			
			_data.addAttachment(IRenderedColumnDataAttachment(data))
		}
		
		/*
		 */
		
		public function fault(data:Object):void
		{
			
		}

	}
}