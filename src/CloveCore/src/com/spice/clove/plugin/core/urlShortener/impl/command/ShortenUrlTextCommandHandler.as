package com.spice.clove.plugin.core.urlShortener.impl.command
{
	import com.spice.clove.plugin.core.urlShortener.impl.UrlShortenerPlugin;
	import com.spice.clove.plugin.core.urlShortener.impl.shorteners.BitlyUrlShortenerCue;
	import com.spice.core.calls.CallCueType;
	import com.spice.core.calls.CallTextCommandTargetType;
	import com.spice.core.queue.ICue;
	import com.spice.core.text.command.ITextCommandTarget;
	import com.spice.core.text.command.handle.ITextCommandResultController;
	import com.spice.impl.text.command.RegExPatterns;
	import com.spice.impl.text.command.handle.TextCommandHandler;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	/**
	 * automatically shortens urls  
	 * @author craigcondon
	 * 
	 */	
	
	public class ShortenUrlTextCommandHandler extends TextCommandHandler implements IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * the urls we're currently handling 
		 */		
		private var _skipUrls:Vector.<String>;
		
		/**
		 * any results 
		 */		
		
		private var _resultUrls:Object;
		
		/**
		 */
		
		private var _plugin:UrlShortenerPlugin;
		
		/**
		 */
		
		private var _evaluating:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ShortenUrlTextCommandHandler(plugin:UrlShortenerPlugin)
		{
			super(RegExPatterns.URL);
			
			this._skipUrls = new Vector.<String>();
			this._resultUrls = {};
			
			_plugin = plugin;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallCueType.COMPLETE: return this.finishUrlShortener(ShortenUrlTextCommandCue(n.getTarget()));
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function handleResultController(target:ITextCommandResultController):void
		{
			
			
			if(_evaluating)
				return;
			
			_evaluating = true;
			super.handleResultController(target);
			
			var results:Array = target.getTestResult() as Array;
			
			
			var skip:Boolean;
			
			
			//note: we replace a text object, instead of passing all results to the text target, because getText, for many
			//command handlers strip any HTML content. 
			var text:String = target.getTextTarget().getText();
			
			for each(var result:String in results)
			{
				
				
				
				for each(var url:String in _skipUrls)
				{
					if(url.indexOf(result) > -1)
					{
						text = this.replaceUrlStr(text,result,this._resultUrls[url]);
						skip = true;
						break;
					}
				}
				
				if(skip)
				{
					skip = false;
					continue;
				}
				
				_skipUrls.push(result);
				
				var cue:ShortenUrlTextCommandCue = new ShortenUrlTextCommandCue(result,target,this._plugin.getDefaultUrlShortener())
			
				new ProxyBind(cue.getProxy(),this,[CallCueType.COMPLETE],true);
				cue.initialize();
			}
			
			target.getTextTarget().setText(text);
			
			_evaluating = false;
		}
		
		/**
		 */
		
		protected function finishUrlShortener(target:ShortenUrlTextCommandCue):void
		{
			var longUrl:String = target.getLongUrl();
			var shortUrl:String = target.getShortUrl();
			
			
			var i:int = _skipUrls.indexOf(longUrl);
			
			if(i > -1)
			{
				_skipUrls.splice(i,1);
			}
			
			if(!shortUrl)
				return;
			
			_skipUrls.push(shortUrl);
			
			this._resultUrls[longUrl] = shortUrl;
			this._resultUrls[shortUrl] = shortUrl;
			
			
			this.replaceUrl(target.getTextTarget(),longUrl,shortUrl);

			
			
			new ProxyCall(CallTextCommandTargetType.TEXT_COMMAND_SET_CURSOR,target.getTextTarget().getProxy(),target.getTextTarget().getText().length).dispatch().dispose();
			
		}
		
		
		/**
		 */
		
		protected function replaceUrl(target:ITextCommandTarget,long:String,short:String):void
		{
			target.setText(target.getText().replace(long,"<font color=\"#0066FF\">"+short+"</font>"));
		}
		
		/**
		 */
		
		protected function replaceUrlStr(text:String,long:String,short:String):String
		{
			return text.replace(long,"<font color=\"#0066FF\">"+short+"</font>");
		}
	}
}