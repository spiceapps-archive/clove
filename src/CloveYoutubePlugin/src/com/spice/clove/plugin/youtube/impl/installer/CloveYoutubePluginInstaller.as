package com.spice.clove.plugin.youtube.impl.installer
{
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.install.IClovePluginInstallerViewController;
	import com.spice.clove.plugin.impl.install.ClovePluginInstaller;
	import com.spice.vanilla.core.plugin.IPlugin;
	
	import flash.events.Event;

	public class CloveYoutubePluginInstaller extends ClovePluginInstaller implements IClovePluginInstallerViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveYoutubePluginInstaller(plugin:IPlugin)
		{
			super(plugin,this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function setView(view:ICloveViewTarget):void
		{
			this.notifyCompletion();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		/*override protected function createInstallerView():DisplayObject
		{
			var view:CloveYoutubeInstallerView = new CloveYoutubeInstallerView();
			view.addEventListener(Event.COMPLETE,onViewComplete);
			
			return view;
		}*/
		
		
		/**
		 */
		override protected function isFinished():Boolean
		{
			
			return true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
	
		private function onViewComplete(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onViewComplete);
			
			this.notifyCompletion();
		}
	}
}