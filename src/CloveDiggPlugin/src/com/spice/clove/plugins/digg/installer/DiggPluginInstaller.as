package com.spice.clove.plugins.digg.installer
{
	import com.architectd.digg2.DiggService;
	import com.architectd.digg2.data.VerifyLoginData;
	import com.architectd.digg2.events.DiggEvent;
	import com.architectd.digg2.loginHelper.AIRLoginHTMLHelper;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.install.ServiceInstaller;
	import com.spice.clove.plugins.digg.DiggPlugin;
	import com.spice.clove.plugins.digg.icon.DiggIcons;
	import com.yahoo.oauth.OAuthConsumer;
	
	import mx.containers.Canvas;

	public class DiggPluginInstaller extends ServiceInstaller implements IServiceInstaller
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		public var username:String;
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _service:DiggService;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function DiggPluginInstaller()
		{
			_service = new DiggService(new OAuthConsumer(DiggPlugin.OAUTH_KEY,DiggPlugin.OAUTH_SECRET),new AIRLoginHTMLHelper());
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get loginHelper():AIRLoginHTMLHelper
		{
			return this._service.loginHelper as AIRLoginHTMLHelper;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function get installViewClass():Class
		{
			return DiggPluginInstallerView;
		}
		
		/**
		 * called when the plugin is being installed by the installation controller
		 * @param controller
		 * 
		 */		
		
		public function install(controller:IPluginController):void
		{
			DiggPlugin(controller.plugin).model.settings.username = this.username;
		}
		
		
		
		public function get icon():*
		{
			return DiggIcons.DIGG_32_ICON;
		}
		
		/**
		 */
		
		
		public function check():void
		{
//			this.completeInstallation();
		}
		
		
		public function init():void
		{
			_service.login().addEventListener(DiggEvent.NEW_DATA,onVerifyLogin);
		}
		
		private function onVerifyLogin(event:DiggEvent):void
		{
			this.username = VerifyLoginData(event.data[0]).username;
			
			this.completeInstallation();
		}
	}
}