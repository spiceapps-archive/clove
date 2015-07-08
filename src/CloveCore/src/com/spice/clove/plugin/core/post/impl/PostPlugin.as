package com.spice.clove.plugin.core.post.impl
{
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.post.impl.content.option.PostMenuOptionViewController;
	import com.spice.clove.plugin.core.post.impl.models.PostPluginModelLocator;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.plugin.impl.views.menu.AbstractRegisteredMenuItemButtonViewController;
	import com.spice.clove.post.core.calls.CallFromPostPluginType;
	import com.spice.clove.post.core.calls.CallToPostPluginType;
	import com.spice.clove.post.core.outgoing.IClovePostable;
	import com.spice.clove.service.core.calls.CallFromServicePluginType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	
	public class PostPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		protected var _model:PostPluginModelLocator = PostPluginModelLocator.getInstance();
		private var _postMenuOptionViewController:PostMenuOptionViewController;
		private var _getPostablesCall:ProxyCall;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function PostPlugin(factory:PostPluginFactory)
		{
			super("Post Plugin","com.spice.clove.plugin.core.post",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
			
			
			_model.plugin = this;
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		
		/**
		 */
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{  
				case CallToPostPluginType.ADD_ACTIVE_POSTABLE: return this.addActivePostable(c.getData());
				case CallToPostPluginType.OPEN_POST_WINDOW: return this.openPostView();
				case CallToPostPluginType.ADD_TEXT_TO_POST_WINDOW: return this.concatTextToPostView(c.getData());
				case CallToPostPluginType.POST_BROWSE_FOR_ATTACHMENT:  return this.browseForAttachment(c.getData());
				case CallFromServicePluginType.SERVICE_ACCOUNT_UNINSTALL: return this.dispatchGetPostablesCall();
			}
			
			super.answerProxyCall(c);
		}
		
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallFromPostPluginType.GET_DEFAULT_POSTABLES: return this.addPluginPostables(n.getData());
			}
			
			super.handleProxyResponse(n);
		}
		
		/**
		 */
		
		public function addActivePostable(c:IClovePostable):void
		{
			
		}
		
		/**
		 */
		
		public function addDefaultPostable(c:IClovePostable):void
		{
			_model.defaultPostables.addItem(c);
		}
		
		/**
		 */
		
		public function concatTextToPostView(value:String):void
		{
			
		}
		
		/**
		 */
		
		public function openPostView():void
		{
			
		}
		
		/**
		 */
		
		public function browseForAttachment(acceptedFileTypes:Vector.<String>):void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		protected function getPostMenuOptionViewController():PostMenuOptionViewController
		{
			if(!_postMenuOptionViewController)
			{
				_postMenuOptionViewController = new PostMenuOptionViewController(this.getPluginMediator());
			}
			
			return _postMenuOptionViewController;
		}
		
		/**
		 */
		
		protected function addPluginPostables(postables:Vector.<IClovePostable>):void
		{
			if(!postables)
				return;
			
			for each(var postable:IClovePostable in postables)
			{
				if(this._model.defaultPostables.getItemIndex(postable) > -1)
					continue;
				
				this._model.defaultPostables.addItem(postable);
			}
		}
		/**
		 */
		
		override protected function initialize():void
		{  
			super.initialize();
			  
			
			
			_model.menuOptionViewControllers.push(new AbstractRegisteredMenuItemButtonViewController(CallRegisteredViewType.GET_NEW_REGISTERED_MENU_BUTTON_VIEW_CONTROLLER,this.getPluginMediator(),this.getPostMenuOptionViewController()));
			
			this.finishInitialization();
		}
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			
			this.dispatchGetPostablesCall();
		}
		
		
		
		/**
		 */
		
		protected function dispatchGetPostablesCall():void
		{
			this._model.defaultPostables.removeAll();
			
			if(!this._getPostablesCall)
				this._getPostablesCall = new ProxyCall(CallFromPostPluginType.GET_DEFAULT_POSTABLES,this.getPluginMediator(),null,this,this);
			
			this._getPostablesCall.dispatch();
				
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallToPostPluginType.ADD_ACTIVE_POSTABLE,
									CallToPostPluginType.ADD_TEXT_TO_POST_WINDOW,
									CallToPostPluginType.OPEN_POST_WINDOW,
									CallToPostPluginType.POST_BROWSE_FOR_ATTACHMENT,
									CallFromServicePluginType.SERVICE_ACCOUNT_UNINSTALL]);
		}		
		
	}
}