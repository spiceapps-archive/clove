package com.spice.clove.plugin.core.post.impl.content.option
{
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.impl.content.control.option.menu.CloveDataMenuOption;
	import com.spice.clove.plugin.impl.views.menu.AbstractRegisteredMenuItemViewController;
	import com.spice.clove.post.core.outgoing.ICloveMessage;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBindingObserver;
	
	public class PostMenuOptionViewController extends AbstractRegisteredMenuItemViewController implements IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function PostMenuOptionViewController(mediator:IProxyMediator)
		{
			super(mediator);
			
			
//			this.addAvailableMenuItem(new CloveDataMenuOption(new ProxyBindingObserver(PostMenuOptionType.ATTACH_PHOTO,this)));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case PostMenuOptionType.ATTACH_PHOTO: return this.attachPhoto(n.getData());
			}
			
			super.notifyProxyBinding(n);
		}
		
		
		/**
		 */
		
		public function attachPhoto(value:ICloveMessage):void
		{
			Logger.log("Attach Photo",this);	
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setDataOptionsToUse(data:Object):void
		{
			this.useMenuItems([PostMenuOptionType.ATTACH_PHOTO]);
		}
	}
}