package com.spice.clove.controls
{
	import com.adobe.cairngorm.control.FrontController;
	import com.spice.clove.commandEvents.*;
	import com.spice.clove.commands.*;
	import com.spice.clove.commands.bundle.RebundleAIRCommand;
	import com.spice.clove.commands.export.*;
	import com.spice.clove.commands.init.InitPackerCommand;
	import com.spice.clove.commands.pluginService.*;
	
	public class ClovePackerController extends FrontController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ClovePackerController()
		{
			super();
			
			
			//initialize the packer app
			this.addCommand(PackerEvent.INITIALIZE,InitPackerCommand);
			
			
			this.addCommand(PackerEvent.EXPORT_PLUGIN,ExportPluginCommand);
			
			
			//unloads a swc with all its assets for packing plugins
			this.addCommand(PackerEvent.UNPACK_SWC,UnpackSWCPluginCommand);
			
			
			//rebundle AIR file
			this.addCommand(PackerEvent.REBUNDLE,RebundleAIRCommand);
			
			
			//logs a user in
			this.addCommand(PackerEvent.LOGIN_USER,UserServiceCommand);
			
			//signs a user up
			this.addCommand(PackerEvent.SIGNUP_USER,UserServiceCommand);
			
			//loads the plugin list (user)
			this.addCommand(PackerEvent.LOAD_PLUGINS,LoadPluginsCommand);
			
			//creates a new plugin
			this.addCommand(PackerEvent.NEW_PLUGIN,NewPluginCommand);
			
			//loads the current plugin
			this.addCommand(PackerEvent.LOAD_PLUGIN,LoadPluginCommand);
			
			//saves current plugin
			this.addCommand(PackerEvent.SAVE_PLUGIN,SavePluginCommand);
		}

	}
}