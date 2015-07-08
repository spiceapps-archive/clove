package com.spice.clove.web.plugin.root
{
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.column_internal;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.root.CloveRootPlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.twitter.impl.content.control.TwitterContentControllerFactory;
	import com.spice.clove.plugin.twitter.impl.content.control.TwitterContentControllerType;
	import com.spice.clove.plugin.twitter.impl.content.control.search.TwitterKeywordSearchContentController;
	import com.spice.clove.web.plugin.root.content.control.WebRootContentControllerFactory;
	import com.spice.clove.web.plugin.root.history.WebColumnHistoryController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	
	use namespace column_internal;

	public class WebRootPlugin extends CloveRootPlugin implements IProxyResponseHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		public var searchTerm:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function WebRootPlugin(factory:ClovePluginFactory)
		{
			super(factory,new WebRootContentControllerFactory(this),new WebColumnHistoryController(this));
			
			WebRotModelLocator.getInstance().plugin = this;
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallClovePluginType.GET_SEARCH_CONTENT_CONTROLLER:
					var plugin:ClovePluginColumn = new ClovePluginColumn(n.getData());
					this.getRootColumn().children.addItem(plugin);
					
				return;
			}
			
			super.handleProxyResponse(n);
		}
		
		
		/**
		 */
		
		public function search(value:String):void
		{
			
			this.searchTerm = value;
			
			this.getRootColumn().historyManager.removeAllItems(); 
			
			//remove all children
			this.getRootColumn().children.removeAll();
			
			
			
			//look for any search content controller
			new ProxyCall(CallClovePluginType.GET_SEARCH_CONTENT_CONTROLLER, this.getPluginMediator(),value,this).dispatch();
			
			this.getRootColumn().loadNewerContent();
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
			
			
			this.search("Google");
		}
		
	}
}