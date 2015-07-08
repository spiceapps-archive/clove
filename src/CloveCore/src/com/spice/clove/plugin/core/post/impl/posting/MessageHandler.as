package com.spice.clove.plugin.core.post.impl.posting
{
	import com.spice.clove.analytics.core.AnalyticalActionType;
	import com.spice.clove.analytics.core.AnalyticsPluginHelper;
	import com.spice.clove.plugin.core.calls.CallClovePostableType;
	import com.spice.clove.plugin.core.post.impl.models.PostPluginModelLocator;
	import com.spice.clove.plugin.core.post.impl.outgoing.CloveMessage;
	import com.spice.clove.post.core.calls.CallCloveMessageType;
	import com.spice.clove.post.core.outgoing.ICloveAttachment;
	import com.spice.clove.post.core.outgoing.IClovePostable;
	import com.spice.clove.urlExpander.core.CallUrlExpanderType;
	import com.spice.clove.urlExpander.core.data.AddExpandedUrlData;
	import com.spice.core.calls.CallQueueType;
	import com.spice.impl.queue.Queue;
	import com.spice.impl.text.command.RegExPatterns;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	import mx.collections.ArrayList;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	/*
	Instantiated whenever a new post window appears. This class handles
	all attachments, and messages
	@author craigcondon
	*/	
	
	[Event(name="complete",type="flash.events.Event")]
	[Event(name="progress",type="flash.events.ProgressEvent")]
	
	[Bindable]
	public class MessageHandler extends EventDispatcher implements IProxyBinding, IProxyResponseHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//  
		//--------------------------------------------------------------------------
		
		
		private var _postables:ArrayList;
		
		/*
		handles the posting
		*/
		
		private var _postQueue:Queue;
		private var _message:CloveMessage;
		
		
		private var _model:PostPluginModelLocator = PostPluginModelLocator.getInstance();
		
		
		private var _analytics:AnalyticsPluginHelper;
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		public var requireSubject:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		public function MessageHandler()
		{
			
			_postables = new ArrayList();
			
			_postables.addEventListener(CollectionEvent.COLLECTION_CHANGE,onSendFromChange,false,0,true);
			_model.defaultPostables.addEventListener(CollectionEvent.COLLECTION_CHANGE,onDefaultPostablesChange,false,0,true);
			
			
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
				case CallCloveMessageType.NEW_MESSAGE_ATTACHMENT_ADDED: return this.prepareNewAttachment(n.getData());
				case CallQueueType.QUEUE_COMPLETE: return this.queueComplete();
			}
		}
		
		
		/**
		 */
		
		public function getMessage():CloveMessage
		{
			if(!_message)
			{
				_message = new CloveMessage(_model.plugin);
				
				new ProxyBind(_message.getProxy(),this,[CallCloveMessageType.NEW_MESSAGE_ATTACHMENT_ADDED]);
			}
			
			return _message;
		}
		
		
		/**
		 */
		
		public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallUrlExpanderType.EXPAND_URL:
					var data:AddExpandedUrlData = AddExpandedUrlData(n.getData());
					
					if(!this._analytics)
					{
						this._analytics = new AnalyticsPluginHelper(this._model.plugin.getPluginMediator());
					}
					
					this._analytics.recordAction(AnalyticalActionType.LINK_SHARED,data.getOriginalUrl());
				break;
			}
		}
		/*
		*/
		
		public function addPostable(postable:IClovePostable):void
		{
			if(postables.getItemIndex(postable) == -1)
				postables.addItem(postable);
			
			for each(var att:ICloveAttachment in this.getMessage().getAttachments())
			{
				new ProxyCall(CallClovePostableType.PREPARE_ATTACHMENT,postable.getProxy(),att).dispatch().dispose();
			}
			
		}
		
		/*
		*/
		
		public function send(message:CloveMessage):void
		{
			
			
			var msg:String = message.getText();
			
			
//			this._analytics.recordAction(AnalyticalActionType.LINK_SHARED,
			
			
			if(postables.length == 0)
			{
				Logger.log("Please select an account using the plus button in the upper right corner.",this,1);
				return;
			}
			 
			//do not allow to post more than once
			
			var urls:Array = msg.match(new RegExp(RegExPatterns.URL,"igs"));
			
			for each(var url:String in urls)
			{
				new ProxyCall(CallUrlExpanderType.EXPAND_URL,this._model.plugin.getPluginMediator(),url,this).dispatch();
			}
			
			if(this._postQueue)
				return;
			
			this._postQueue = new Queue();
			
			
			//listen for on complete
			new ProxyBind(this._postQueue.getProxy(),this,[CallQueueType.QUEUE_COMPLETE],true); 
			
			
			
			var m:CloveMessage;
			
			
			for each(var postable:IClovePostable in postables.toArray())
			{
				
				m = message.clone();
				
				
				postable.setMessage(m);
				
				//we queue the posts since some services only allow one request. this will
				//also enable us to better control the UI, and close the post window on complete
				this._postQueue.addCue(postable);
			}
			
			
			
			this._postQueue.start();
			
			
			_postables.removeAll();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/*
		*/
		
		[Bindable(event='progress')]
		public function get postQueue():Queue
		{
			return this._postQueue;
		}
		
		
		/*
		*/
		
		
		
		public function get postables():ArrayList
		{
			return _postables;
		}
		
		/*
		*/
		
		[Bindable(event="availablePluginChange")]
		public function get availablePlugins():Array
		{
			
			var allPostables:Array = this._model.defaultPostables.toArray();
			
			
			
			var avail:Array = [];
			
			
				//we loop because we need to check if the postable is already in the TO.
			for each(var postable:IClovePostable in allPostables)
			{
				if(this._postables.getItemIndex(postable) == -1)
				{
					avail.push(postable);
				}
			}
			
			return avail;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function queueComplete():void
		{
			this._postQueue.dispose();
			this._postQueue = null;
			
			
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
		/**
		 */
		
		protected function prepareNewAttachment(n:ICloveAttachment):void
		{
			for each(var postable:IClovePostable in this._postables.source)
			{
				new ProxyCall(CallClovePostableType.PREPARE_ATTACHMENT,postable.getProxy(),n).dispatch().dispose();
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/*
		*/
		
		private function preparePostableStack(stack:Array,attachments:Array):void
		{
//			for each(var postable:IPostable in stack)
//			{
//				this.preparePostable(postable,attachments);
//			}
			
		}
		
		
		
		private function preparePostable(postable:IClovePostable,attachments:Array):void
		{
			/*for each(var att:Attachment in attachments)
			{
				postable.prepareAttachment(att);
			}*/	
		}
		/*
		*/
		
		private function onCollectionChange(event:CollectionEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		/*
		*/
		
		private function onSendFromChange(event:CollectionEvent):void
		{
			
			this.dispatchEvent(new Event("availablePluginChange"));
			
			
			/*this.dispatchEvent(new Event("availablePluginChange"));
			
			if(event.kind == CollectionEventKind.ADD)
			{
				if(_message)
					this.preparePostableStack(event.items,this._message.attachments.source);
			}*/
		}
		
		/**
		 */
		
		private function onDefaultPostablesChange(event:CollectionEvent):void
		{
			this.dispatchEvent(new Event("availablePluginChange"));
			
		}
		
		/*
		*/
		
		private function onAttachmentsChange(event:CollectionEvent):void
		{
			if(event.kind != CollectionEventKind.ADD)
				return;
			
			//run the attachment through the postable service so that
			//it can prepare for the upload. (twitter for instance uploads it immediatly)
			this.preparePostableStack(postables.toArray(),event.items);
			
			
			
			this.dispatchEvent(new Event("attachmentsChange"));
		}
	}
}