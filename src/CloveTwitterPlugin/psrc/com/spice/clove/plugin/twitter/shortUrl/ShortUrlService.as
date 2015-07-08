package com.spice.clove.plugin.twitter.shortUrl
{
	import com.spice.clove.plugin.posting.Message;
	import com.spice.utils.queue.cue.Cue;

	public class ShortUrlService extends Cue
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _data:String;
		private var _search:String;
		private var _message:Message;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ShortUrlService(search:String,message:Message)
		{
			_search = search;
			_message = message;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get data():String
		{
			return _data;
		}
		
		
		/**
		 */
		
		public function get url():String
		{
			return _search;
		}
		
		/**
		 */
		
		public function get message():Message
		{
			return _message;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		final override public function init():void
		{
			if(!this._message.metadata.hasSetting("shortening"))
			{
				this.message.metadata.saveSetting("shortening",{});
				this.message.metadata.saveSetting("shortened",{});
			}
			
			//check for shortening, or shortened
			if(this._message.metadata.getSetting("shortening")[_search] ||
			   this._message.metadata.getSetting("shortened")[_search])
			{
				this.complete();
				return;
			}
			
			
			this._message.metadata.getSetting("shortening")[_search] = true;
			
			init2();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		protected function init2():void
		{
			
		}
		
		/**
		 */
		
		protected function setUrl(url:String):void
		{
			this._data = url;
			
			
			if(this._message.metadata.getSetting("shortened")[url])
			{
				this.complete();
				return;
			}
			
			this._message.metadata.getSetting("shortened")[url] = true;
			
			
			this._message.text = this._message.text.replace(_search,url);
			
			this.complete();
		}
	}
}