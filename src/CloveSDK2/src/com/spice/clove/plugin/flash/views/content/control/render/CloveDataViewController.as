package com.spice.clove.plugin.flash.views.content.control.render
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.flash.views.IControllableView;
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import flash.display.DisplayObject;
	
	import mx.core.IDataRenderer;
	
	/**
	 * this CloveDataViewController is in the flash platform directory since it uses a class as a reference.
	 * This is not portable to other platforms such as C++, Java, or AS3 
	 * @author craigcondon
	 * 
	 */	

	public class CloveDataViewController extends ProxyOwner implements ICloveDataViewController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _viewClass:Class;
		private var _pool:ObjectPoolManager = ObjectPoolManager.getInstance();
		
		protected var _currentView:IDataRenderer;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function CloveDataViewController(viewClass:Class)
		{
			_viewClass = viewClass;
			_pool = ObjectPoolManager.getInstance();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setContentView(content:Object,target:ICloveViewTarget):void
		{
			
			
			if(target.getView() is this._viewClass)
			{
				
				this.setupNewView(content,IDataRenderer(target.getView()));
				return;
			}
			else  
			{
				var oldView:DisplayObject = target.removeView();
				
				if(oldView)
				{
					_pool.addObject(oldView);
				}
				
				var newView:IDataRenderer = _pool.getObject(_viewClass);
				this.setupNewView(content,newView);
				target.setView(DisplayObject(newView));
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function setupNewView(content:Object,view:IDataRenderer):void
		{
			_currentView = view;
			view.data = content;
			
			
			//if the view is controllable, then the controller to this so the view can invoke commands. this is used vs. event listeners
			//to prevent mem leaks
			if(view is IControllableView)
			{
				IControllableView(view).setController(this);
			}
		}
	}
}