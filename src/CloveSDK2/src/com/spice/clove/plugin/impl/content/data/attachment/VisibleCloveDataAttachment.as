package com.spice.clove.plugin.impl.content.data.attachment
{
	import com.spice.clove.plugin.core.calls.CallCloveDataAttachmentType;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.content.data.attachment.IVisibleCloveDataAttachment;
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadata;
	import com.spice.clove.plugin.core.views.ICloveViewController;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.IIconViewController;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.recycle.pool.ObjectPool;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import flash.display.DisplayObject;
	
	import mx.core.IDataRenderer;

	public class VisibleCloveDataAttachment extends CloveDataAttachment implements IVisibleCloveDataAttachment, 
																				   IProxyResponder, 
																				   IIconViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _viewController:ICloveDataViewController;
		private var _proxy:ProxyOwner;
		private var _pool:ObjectPoolManager;
		private var _availableCalls:Vector.<String>;
		private var _inlineViewController:ICloveDataViewController;
		private var _data:ICloveMetadata;
		private var _autoExpand:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function VisibleCloveDataAttachment(type:String,
												   viewController:ICloveDataViewController = null,
												   inlineViewController:ICloveDataViewController = null,
												   autoExpand:Boolean = false)
		{
			super(type);
			_viewController = viewController;
			_inlineViewController = inlineViewController;
			this._autoExpand = autoExpand;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getMetadata():ICloveMetadata
		{
			return this._data;
		}
		
		/**
		 */
		
		public function setMetadata(value:ICloveMetadata):void
		{
			this._data = value;
			
		}
		
		/**
		 */
		
		public function getIcon():*
		{
			return null;
		}
		
		
		/**
		 */
		
		public function autoExpanded():Boolean
		{
			return this._autoExpand;
		}
		/**
		 */
		
		public function getLabel():String
		{
			return this._data.getLabel();
		}
		
		/**
		 */
		
		public function getProxy():IProxy
		{
			if(!_proxy)
			{
				
				_availableCalls = new Vector.<String>();
				_availableCalls.push(CallCloveDataAttachmentType.GET_ATTACHMENT_ICON);
				_availableCalls.push(CallCloveDataAttachmentType.GET_ATTACHMENT_LABEL);  
				_availableCalls.push(CallCloveDataAttachmentType.VISIBLE_ATTACHMENT_CLICK);
				_availableCalls.push(CallCloveDataAttachmentType.SET_INLINE_VIEW);
				_availableCalls.push(CallCloveDataAttachmentType.REMOVE_INLINE_VIEW);
				_availableCalls.push(CallCloveDataAttachmentType.AUTO_EXPANDED);
				this._proxy = new ProxyOwner(this);
			}
			
			return this._proxy.getProxy();
		}
		
		/**
		 */
		
		public function getAvailableCalls():Vector.<String>
		{
			return this._availableCalls;
		}
		
		/**
		 */
		
		public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallCloveDataAttachmentType.GET_ATTACHMENT_ICON: return _proxy.respond(c,this.getIcon());
				case CallCloveDataAttachmentType.GET_ATTACHMENT_LABEL: return _proxy.respond(c,this.getLabel());
				case CallCloveDataAttachmentType.VISIBLE_ATTACHMENT_CLICK: return this.visibleAttachmentClick();
				case CallCloveDataAttachmentType.AUTO_EXPANDED :return _proxy.respond(c,this.autoExpanded());
				case CallCloveDataAttachmentType.SET_INLINE_VIEW:  
					if(_inlineViewController)
					{
						this.setInlineView(c.getData());
					}
				return;
				case CallCloveDataAttachmentType.REMOVE_INLINE_VIEW: 
					if(this._inlineViewController)
					{
						this.removeInlineView(c.getData());
					}
				return;
			}
		}
		
		
		/**
		 */
		
		public function setContentView(content:Object,viewTarget:ICloveViewTarget):void
		{
//			 this.setData(ICloveData(content));
			
			
			_viewController.setContentView(this,viewTarget);
			
//			var oldView:IDataRenderer = IDataRenderer(target.getView());
//			
//			if(oldView is _viewClass)
//			{
//				oldView.data = this;
//				return;
//			}
//			
//			if(_pool) _pool = ObjectPoolManager.getInstance();
//			
//			//if the old view exists, then recycle it
//			if(oldView)
//			{
//				_pool.addObject(target.removeView());
//			}
//			
//			IDataRenderer(target.setView(_pool.getObject(_viewClass))).data = this;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function visibleAttachmentClick():void
		{
			//abstract
		}
		
		
		/**
		 */
		
		protected function setInlineView(view:ICloveViewTarget):void
		{
			_inlineViewController.setContentView(this._data,view);
		}
		
		/**
		 */
		
		protected function removeInlineView(view:ICloveViewTarget):void
		{
			view.removeView();
//			this._inlineViewController
		}
	}
}