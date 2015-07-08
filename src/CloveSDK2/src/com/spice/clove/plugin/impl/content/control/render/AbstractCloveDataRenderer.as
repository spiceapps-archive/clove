package com.spice.clove.plugin.impl.content.control.render
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallCloveContentItemRendererType;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.calls.data.LinkSelectedCallData;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.core.content.data.CloveDataSettingName;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadata;
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadataList;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.data.CloveDataSettingFactory;
	import com.spice.clove.plugin.impl.content.data.CloveDataSettingType;
	import com.spice.clove.plugin.impl.content.data.CloveMetadataType;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachmentFactory;
	import com.spice.clove.plugin.impl.content.data.meta.CloveMetadata;
	import com.spice.clove.plugin.impl.content.data.meta.CloveMetadataList;
	import com.spice.clove.plugin.impl.text.command.handle.CloveDataTextCommandTarget;
	import com.spice.clove.plugin.impl.views.content.render.RegisteredCloveDataViewController;
	import com.spice.core.notifications.TextCommandNotification;
	import com.spice.core.text.command.handle.ITextCommandHandler;
	import com.spice.impl.text.command.TextCommandManager;
	import com.spice.impl.text.command.handle.link.TextCommandLinkHandler;
	import com.spice.impl.text.command.handle.link.TextCommandUrlHandler;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.observer.IObserver;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.core.settings.ISettingFactory;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	import com.spice.vanilla.impl.proxy.ProxyPassThrough;
	

	public class AbstractCloveDataRenderer extends ProxyOwner implements ICloveDataRenderer, 
																		 IObserver, 
																		 IProxyResponseHandler
																		  
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _viewClass:Class;
		private var _target:CloveDataTextCommandTarget;
		private var _textManager:TextCommandManager;
		private var _notificationsOfInterest:Vector.<String>;
		private var _viewController:RegisteredCloveDataViewController;
		private var _dataSettingFactory:ISettingFactory;
		private var _attFactories:Object;
		private var _controller:CloveContentController;
		private var _currentData:ICloveData;
		private var _currentMetadata:ICloveMetadataList;
		
		/**
		 * global data renderers are items that can add additional metadata to handle clove data. 
		 */		
		
		private var _globalDataRenderers:Vector.<ICloveDataRenderer>;
		
		
		
		public static const LINK_HANDLER:String = "httpUrl";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 * Constructor 
		 * @param viewController the view controller used to render each row view. The user should always
		 * used a RegisteredCloveDataViewController that's passed through either the plugin proxy, or the plugin mediator.
		 * This is to ensure each data renderer stays usable across multiple platforms.
		 * 
		 */		
		public function AbstractCloveDataRenderer(controller:CloveContentController,
												  mediator:IProxyMediator,
												  viewController:RegisteredCloveDataViewController = null,
												  useGlobalDataRenderers:Boolean = true)
		{
			super();
			
			this._controller = controller;
			_viewController = viewController || new RegisteredCloveDataViewController(CallRegisteredViewType.GET_NEW_REGISTERED_DEFAULT_ROW_VIEW_CONTROLLER,mediator);
			
			this._attFactories = {};
			
			
			//FOR NOW. later we want to use a custom setting factory that accepts attachments as well
			_dataSettingFactory = CloveDataSettingFactory.getInstance();
			
			_notificationsOfInterest = new Vector.<String>(1,true);
			_notificationsOfInterest[0] =  TextCommandNotification.RESULT_FOUND;
			
			_textManager = new TextCommandManager();
			_textManager.addObserver(this);
			_target = new CloveDataTextCommandTarget();
			_textManager.addTextHandler(new TextCommandUrlHandler(LINK_HANDLER));
			
			
			
			if(useGlobalDataRenderers)
			{
				//make a call for any additonal data renderers that might want to handle incomming data, such as shortened urls, maps, etc.
				ProxyCallUtils.quickCall(CallAppCommandType.GET_REGISTERED_CLOVE_DATA_RENDERERS,mediator,null,this);
			}
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getTextManager():TextCommandManager
		{
			return this._textManager;
		}
		
		/**
		 */
		
		public function getNotificationsOfInterest():Vector.<String>
		{
			return this._notificationsOfInterest;
		}
		
		/**
		 */
		
		public function notifyObserver(n:INotification):void
		{
			this.replacementFound(n);	
		}
		
		/**
		 */
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallCloveContentItemRendererType.CLOVE_DATA_ICON_CLICK: return this.dataIconClick(c.getData());
//				case CallCloveContentItemRendererType.GET_NEW_ATTACHMENT: return 
				case CallCloveContentItemRendererType.LINK_SELECTED: 
					
					var data:LinkSelectedCallData = c.getData();
					
					
					
					return this.linkSelected( TextCommandLinkHandler.getEventValue(data.getLink()),TextCommandLinkHandler.getEventType(data.getLink()));
				
			}
			
			super.answerProxyCall(c);
		}
		
		
		/**
		 */
		
		public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallAppCommandType.GET_REGISTERED_CLOVE_DATA_RENDERERS: this.addRegisteredCloveDataRenderer(n.getData());
			}
		}
		
		/**
		 * Abstract. sub-classes should always override this method 
		 * @inherit
		 * 
		 */		
		
		public function setCloveData(vo:Object,data:ICloveData):Boolean
		{
			data.registerSettingFactory(this._dataSettingFactory);
			this._currentData = data;
			this._currentMetadata = CloveMetadataList(data.getSettingTable().getNewSetting(CloveDataSettingType.METADATA_LIST,CloveDataSettingName.METADATA));
			
			
			return true;
		}

		
		/**
		 */
		
		public function getMetadataView(data:ICloveMetadata):ICloveDataViewController
		{
			
			
			
			var view:ICloveDataViewController;
			
			for each(var factory:ICloveDataAttachmentFactory in this._attFactories)
			{
				view = factory.getNewAttachment(data.getType());
				
				if(view)
				{
					Object(view).setMetadata(data);
					return view;
				}
			}
			
			for each(var renderer:ICloveDataRenderer in this._globalDataRenderers)
			{
				view = renderer.getMetadataView(data);
				
				if(view)
				{
					Object(view).setMetadata(data);
					return view;
				}
			}
			
			return null;
		}
		/**
		 * Abstract
		 * @inherit
		 * 
		 */		
		public function getUID(vo:Object):String
		{
			return null;//abstract
		}
		
		
		
		/**
		 */		
		
		public function setContentView(content:ICloveData,target:ICloveViewTarget):void
		{
			//re-register the setting factory so the metadata we'll use is re-activated.
			//This will also remove  a BUNCH of overhead, by only processing what the user
			//see's 
			
			content.registerSettingFactory(this._dataSettingFactory);
			
			
			_viewController.setContentView(content,target);
			
			
			if(_globalDataRenderers)
			{
				for each(var renderer:ICloveDataRenderer in this._globalDataRenderers)
				{
					renderer.setContentView(content,target);
				}
			}
		}
		
		
		
		
		
		/**
		 */
		
		public function getAttachmentsFactory(name:String):ICloveDataAttachmentFactory
		{
			return _attFactories[name];
		}
		
		
		/**
		 */
		public function setAttachmentsFactory(name:String,value:ICloveDataAttachmentFactory):void
		{
			this._attFactories[name] = value;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		protected function addMetadata(name:String,value:String,label:String = ""):void
		{
			this._currentMetadata.addMetadata(new CloveMetadata(name,label,value));
//			target.getSettingTable().getNewSetting(
		}
		/**
		 */
		
		protected function addRegisteredCloveDataRenderer(value:ICloveDataRenderer):void
		{
			if(!this._globalDataRenderers)
			{
				_globalDataRenderers = new Vector.<ICloveDataRenderer>();
			}
			
			_globalDataRenderers.push(value);
		}
		
		/**
		 */
		
		protected function getDataSettingFactory():ISettingFactory
		{
			return this._dataSettingFactory;
		}
		
		/**
		 */
		
		protected function replacementFound(n:INotification):void
		{
			//abstract
		}
		
		
		/**
		 * called when a user selects a link in the message box. This could be a url, @user, #hash, etc. It gets handled here. 
		 * @param value the value of the link selected
		 * @param type the type of link selected: url, twitterUser, twitterHash, etc.
		 * 
		 */		
		protected function linkSelected(value:String,type:String):void
		{
			switch(type)
			{
				case LINK_HANDLER: return this.urlSelected(value);
			}
		}
		
		/**
		 */
		
		protected function urlSelected(value:String):void
		{
			new ProxyCall(CallAppCommandType.NAVIGATE_TO_URL,_viewController.getProxyMediator(),value).dispatch().dispose();
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallCloveContentItemRendererType.CLOVE_DATA_ICON_CLICK,
									CallCloveContentItemRendererType.LINK_SELECTED]);
			
			
			
			if(this._globalDataRenderers)
			{
				for each(var renderer:ICloveDataRenderer in this._globalDataRenderers)
				{
					
					//create a proxy pass through so any incomming calls ALSO get passed to any global data renderers
					this.addDisposable(new ProxyPassThrough(renderer.getProxy(),this.getProxyController()));
				}
			}
		}
		
		/**
		 * returns TRUE
		 */
		
		protected function filterText(value:String):Boolean
		{
			if(!this._controller.hasFilters())
				return true;
			
			
			for each(var filter:String in this._controller.getFilters())
			{  
				if(value.indexOf(filter) == -1)
					return false;
			}
			
			return true;
		}
		
		/**
		 */
		
		protected function filterCloveData(value:ICloveData):Boolean
		{
			return !this._controller.hasFilters() || this.filterText(value.getTitle().toLowerCase()) || this.filterText(value.getMessage().toLowerCase());
		}
		
		/**
		 */
		
		protected function addMessageHandler(handler:ITextCommandHandler):void
		{
			_textManager.addTextHandler(handler);
		}
		
		
		
		/**
		 */
		
		protected function setMessageReplacements(vo:Object,target:ICloveData):void
		{
			//registered data renderers get first dibs on text replacements. This is important for use cases
			//such as taking a url, and transforming it to something else.
			if(_globalDataRenderers)
			{
				for each(var renderer:ICloveDataRenderer in this._globalDataRenderers)
				{
					renderer.setCloveData(vo,target);
				}
			}
			
			this._target.setTarget(target);
			this._textManager.replaceText(this._target);
		}
		
		/**
		 */
		
		protected function dataIconClick(data:ICloveData):void
		{
			//abstract
		}
	}
}