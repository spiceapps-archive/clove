package com.spice.clove.plugin.core.urlShortener.impl
{
	import com.spice.clove.plugin.core.urlShortener.impl.settings.UrlShortenerPluginSettings;
	import com.spice.clove.plugin.core.urlShortener.impl.shorteners.BitlyUrlShortener;
	import com.spice.clove.plugin.core.urlShortener.impl.command.ShortenUrlTextCommandHandler;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.textCommands.core.calls.CallTextCommandsPluginType;
	import com.spice.clove.urlShortener.core.IUrlShortener;
	import com.spice.clove.urlShortener.core.calls.CallUrlShortenerPluginType;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	public class UrlShortenerPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _settings:UrlShortenerPluginSettings;
		private var _inputHandler:ShortenUrlTextCommandHandler;
		private var _defaultUrlShortener:IUrlShortener;
		
		private var _availableUrlShorteners:Vector.<IUrlShortener>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UrlShortenerPlugin(factory:UrlShortenerPluginFactory)
		{
			super("Url Shortener Plugin","com.spice.clove.plugin.core.urlShortener",(_settings = new UrlShortenerPluginSettings()),factory);
			
			this.addUrlShortener(new BitlyUrlShortener(this));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallUrlShortenerPluginType.URL_SHORTENER_ADD: this.addUrlShortener(call.getData());
				case CallUrlShortenerPluginType.URL_SHORTENER_SET_DEFAULT: this.setDefault(call.getData());
			}
			
			super.answerProxyCall(call);
		}
		
		/**
		 */
		
		public function addUrlShortener(value:IUrlShortener):void
		{
			
			if(!_availableUrlShorteners)
			{
				_availableUrlShorteners = new Vector.<IUrlShortener>();
			}
			
			_availableUrlShorteners.push(value);
			
			var defaultShortener:String = this._settings.getDefaultShortener().getData();
			if(!defaultShortener || defaultShortener == value.getName())
			{
				this.setDefault(value);
			}
		}
		
		
		/**
		 */
		
		
		public function setDefault(value:IUrlShortener):void
		{
			
			this._settings.getDefaultShortener().setData(value.getName());
				
			this._defaultUrlShortener = value;
		}
		
		
		/**
		 */
		
		public function getDefaultUrlShortener():IUrlShortener
		{
			return this._defaultUrlShortener;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			
			
			this.finishInitialization();
		}
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
				
			
			this._inputHandler = new ShortenUrlTextCommandHandler(this);
			
			new ProxyCall(CallTextCommandsPluginType.TEXT_COMMANDS_REGISTER_INPUT_EVALUATOR,this.getPluginMediator(),this._inputHandler).dispatch().dispose();
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallUrlShortenerPluginType.URL_SHORTENER_ADD,CallUrlShortenerPluginType.URL_SHORTENER_SET_DEFAULT]);
		}
	}
}