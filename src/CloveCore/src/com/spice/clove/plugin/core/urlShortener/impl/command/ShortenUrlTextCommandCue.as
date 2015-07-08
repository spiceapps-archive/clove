package com.spice.clove.plugin.core.urlShortener.impl.command
{
	import com.spice.clove.urlShortener.core.IUrlShortener;
	import com.spice.core.calls.CallCueType;
	import com.spice.core.queue.ICue;
	import com.spice.core.text.command.ITextCommandTarget;
	import com.spice.core.text.command.handle.ITextCommandResultController;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;

	public class ShortenUrlTextCommandCue extends AbstractCue implements IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _shortener:IUrlShortener;
		private var _target:ITextCommandResultController;
		private var _longUrl:String;
		private var _shortUrl:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ShortenUrlTextCommandCue(longUrl:String,controller:ITextCommandResultController,shortener:IUrlShortener)
		{
			_shortener = shortener;
			_target = controller;
			
			_longUrl = longUrl;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getLongUrl():String
		{
			return this._longUrl;
		}
		
		/**
		 */
		
		public function getShortUrl():String
		{
			return this._shortUrl;
		}
		
		
		/**
		 */
		
		public function getTextTarget():ITextCommandTarget
		{
			return this._target.getTextTarget();
		}
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			_shortUrl = n.getData();
			
			this.notifyChange(n.getType(),n.getData());
		}
		/**
		 */
		
		override public function initialize():void
		{
			super.initialize();
			
			var url:String = _longUrl;
			
			//note: only search for ://, because ftp, https, etc are allowed.
			//if the :// is ommitted, we can assume it's http://
			if(url.indexOf("://") == -1)
			{
				url = "http://"+url;
			}
			
			var cue:ICue = _shortener.shortenUrl(url);
			
			
			new ProxyBind(cue.getProxy(),this,[CallCueType.COMPLETE],true);
			
			cue.initialize();
		}
	}
}