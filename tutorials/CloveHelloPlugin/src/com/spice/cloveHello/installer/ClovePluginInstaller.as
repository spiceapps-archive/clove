package com.spice.cloveHello.installer
{
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.install.ServiceInstaller;
	import com.spice.cloveHello.CloveHelloPlugin;
	import com.spice.cloveHello.icons.CloveHelloPluginIcon;
	
	import mx.controls.Alert;
	
	public class ClovePluginInstaller extends ServiceInstaller implements IServiceInstaller
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var username:String;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ClovePluginInstaller()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get icon():*
		{
			return CloveHelloPluginIcon.CLOVE_HELLO_PLUGIN_ICON;
		}
		/**
		 */
		
		public function get installViewClass():Class
		{
			return ClovePluginInstallerView;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function check():void
		{
			if(!this.username || this.username == "")
			{
				Alert.show("Please enter a username!");
			}
			else
			{
				this.completeInstallation();
			}
		}
		
		/**
		 */
		
		public function init():void
		{
			//
		}
		
		/**
		 */
		
		public function install(controller:IPluginController):void
		{
			var plugin:CloveHelloPlugin = CloveHelloPlugin(controller.plugin);
			plugin.settings.username = this.username;
		}

	}
}