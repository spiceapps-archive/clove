package com.spice.clove.plugin.core.post.desktop
{
	import com.spice.clove.plugin.core.post.desktop.posting.options.DesktopPostMenuOptionViewController;
	import com.spice.clove.plugin.core.post.desktop.views.posting.PostWindow;
	import com.spice.clove.plugin.core.post.impl.PostPlugin;
	import com.spice.clove.plugin.core.post.impl.content.option.PostMenuOptionViewController;
	import com.spice.clove.plugin.core.post.impl.outgoing.CloveMessage;
	import com.spice.clove.post.core.outgoing.IClovePostable;
	
	import flash.events.Event;

	public class DesktopPostPlugin extends PostPlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _postWindow:PostWindow;
		private var _menuOption:DesktopPostMenuOptionViewController;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DesktopPostPlugin(factory:DesktopPostPluginFactory)
		{
			super(factory);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		
		/**
		 */
		
		public function getPostWindow():PostWindow
		{
			if(!_postWindow)
			{
				_postWindow = new PostWindow();
				this._postWindow.addEventListener(Event.CLOSE,onPostWindowClose);
			}
			
			return _postWindow;
		}
		
		/**
		 */
		
		override public function addActivePostable(postable:IClovePostable):void
		{	
			var win:PostWindow = this.getPostWindow();
			
			win.getComposer().messageHandler.addPostable(postable);
			win.open();
		}
		
		
		
		/**
		 */
		
		override public function concatTextToPostView(text:String):void
		{
			var win:PostWindow = this.getPostWindow();
			
			var m:CloveMessage = win.getComposer().getMessage();
			
			if(!m.getText())
				m.setText(text+" ");
			else
				m.setText(m.getText()+text);
			
			win.open();
		}
		
		
		/**
		 */
		
		override public function openPostView():void
		{
			this.getPostWindow().open();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getPostMenuOptionViewController():PostMenuOptionViewController
		{
			if(!_menuOption)
			{
				_menuOption = new DesktopPostMenuOptionViewController(this.getPluginMediator());
			}
			
			return _menuOption;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onPostWindowClose(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onPostWindowClose);
			
			this._postWindow = null;
		}
		
	}
}