package com.spice.clove.plugin.impl.views.content.render
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.views.RegisteredViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.impl.proxy.IProxyResponseHandler;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	/**
	 * wraps a registered data view controller specified in the application we're running in. This saves
	 * the developer the tedious task of writing DataViewControllers for each platform they're running on 
	 * @author craigcondon
	 * 
	 */	
	
	public class RegisteredCloveDataViewController extends RegisteredViewController implements ICloveDataViewController
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function RegisteredCloveDataViewController(name:String,
														  mediator:IProxy)
		{
			super(name,mediator);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		public function setContentView(content:Object,
									   viewTarget:ICloveViewTarget):void
		{
			
			if(!_target)
			{
				throw new Error("no content view renderers with the name "+_name+" are registered.");
			}
			
			ICloveDataViewController(this._target).setContentView(content,viewTarget);
		}
		
		
		
	}
}