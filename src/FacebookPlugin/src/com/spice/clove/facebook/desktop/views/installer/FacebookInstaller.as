package com.spice.clove.facebook.desktop.views.installer
{
	import com.facebook.air.SessionData;
	import com.spice.clove.facebook.impl.FacebookPlugin;
	import com.spice.clove.facebook.impl.account.FacebookAccount;
	import com.spice.clove.plugin.core.views.ICloveViewController;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.install.IClovePluginInstallerViewController;
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.clove.plugin.impl.install.ClovePluginInstaller;

	public class FacebookInstaller extends  ClovePluginInstaller implements IClovePluginInstallerViewController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:FacebookPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookInstaller(plugin:FacebookPlugin)
		{
			super(plugin,this);
			
			_plugin = plugin;
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
			var iv:FacebookInstallerView = new FacebookInstallerView();
			iv.installer = this;
			view.setView(iv);
		}
		
		
		/**
		 */
		
		public function setSession(value:SessionData):void
		{  
			FacebookAccount(this._plugin.addAcount()).getFacebookSettings().getSession().setData(value);
			this.notifyCompletion();
		}
	}
}