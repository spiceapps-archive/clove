package com.spice.clove.plugin.gdgt.cue
{
	import com.adobe.serialization.json.JSON;
	import com.spice.binding.DataBoundController;
	import com.spice.clove.plugin.column.ICloveColumn;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.column.render.RenderedColumnDataAttachment;
	import com.spice.clove.plugin.gdgt.column.attachment.GDGTReviewPhotoAttachment;
	import com.spice.clove.plugin.gdgt.mediate.GetAdditionalInfoCall;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	/*
	  GDGT does NOT have review information in their feeds, so this fetches them using Dapper 
	  @author craigcondon
	  
	 */	
	 
	public class GDGTReviewFetchCue extends Cue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _url:String;
		private var _data:RenderedColumnData;
		private var _loader:URLLoader;
		private var _column:ICloveColumn;
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function GDGTReviewFetchCue(reviewUrl:String,data:RenderedColumnData)
		{
			_url = reviewUrl;
			_data = data;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function init():void
		{
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE,onFeedInfoLoad);
			_loader.load(new URLRequest("http://architectd.com/projects/clove/demo/gdgt/fetch.php?url="+this._url));
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onFeedInfoLoad(event:Event):void
		{
			
			
			event.currentTarget.removeEventListener(event.type,onFeedInfoLoad);
			
			//new GetAdditionalInfoCall(productName).dispatch();
			
			try
			{
				var feedData:Object = JSON.decode(event.target.data);
				
				var manufacturer:String = feedData.manufacturer;
				var product:String		= feedData.product;
				var img:String		    = feedData.img;
				var about:String		= feedData.about;
				var price:String		= feedData.price;
				
				about = about.length > 0 ? about : "No one's written any about text for this gadget yet. Why don't you <a href='event:addSomeIn+++"+this._url+"'><font color='#FC0000'>add some in</font></a>?";
				
				
				_data.setMessage(about);
				_data.vo.image = img;
				
				
				
				var brk:Boolean;
				
				//ONLY FOR THIS DEMO!!
				for each(var att:RenderedColumnDataAttachment in this._data.attachments.source)
				{
					if(att is GDGTReviewPhotoAttachment)
						brk = true;
				}
				
				if(!brk)
					_data.addAttachment(new GDGTReviewPhotoAttachment());
				
			}catch(e:Error)
			{
				Logger.log(e,LogType.WARNING);
			}
			
			
			new GetAdditionalInfoCall(manufacturer,product,Math.round(Number(price)/1.1),_data).dispatch()
			
			
			//we're not using the loader anymore so spare the GC the extra work
			_loader  = undefined;
			feedData = undefined;
			
			this.complete();
			
		}

	}
}