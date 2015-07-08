package com.spice.clove.controls
{
	import com.adobe.cairngorm.control.FrontController;
	import com.spice.clove.command.*;
	import com.spice.clove.command.initialize.InitializeCommand;
	import com.spice.clove.command.plugin.*;
	import com.spice.clove.commandEvents.*;
	import com.spice.vanilla.impl.plugin.AbstractPluginController;
	
	
	/*
	  the front controller used by clove to register all the commands
	 */
	 
	public class CloveCoreController extends FrontController
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _initCommandClass:Class
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CloveCoreController(initCommandClass:Class = null)
		{
			super();
			
			this._initCommandClass = initCommandClass ? initCommandClass : InitializeCommand;
			
			this.init();
			
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		protected function init():void
		{
			this.initCommands();
			this.initApplication();
		}
		
		/*
		 */
		
		protected function initCommands():void
		{
			this.addCommand(CloveEvent.INITIALIZE,this._initCommandClass);
			
			
			
			//installs the same plugin using the same resources
			this.addCommand(InstallSamePluginEvent.INSTALL_SAME,InstallSamePluginCommand);
			
			
			
			
			this.addCommand(CloveEvent.LOAD_PLUGIN,LoadPluginCommand);
			
			//adds core plugins
			this.addCommand(CloveEvent.ADD_CORE_PLUGIN,LoadPluginCommand);
			
			
			
			
			//uninstalls a plugin
			this.addCommand(CloveEvent.UNINSTALL_PLUGIN,UninstallPluginCommand);
			this.addCommand(CloveEvent.UNINSTALL_PLUGIN_COMPLETELY,UninstallAllPluginsCommand);
			
			
			
			
			
			
			this.addCommand( CreateColumnEvent.CREATE_COLUMN,CreateColumnCommand);
			
			
			
			
			//adds a favorite in Neem, NOTE: favorites are saved individually from their column data to avoid deletion
			//this.addCommand(CloveEvent.ADD,NewFavoriteCommand);
			
			//checks the server for updates
//			this.addCommand(CloveEvent.CHECK_UPDATE,CheckUpdateCommand);
			
			
			//removes a neem column, but prompts for type and warning
			this.addCommand(CloveEvent.REMOVE_COLUMN,RemoveCloveColumnCommand);
			
			
			
			
			//adds a cue to a given stack specified in the event
			this.addCommand(CloveCueEvent.ADD_CUE,AddCueCommand);
			
			//sends a notification via growl, or the AS3 vers
//			this.addCommand(NotificationEvent.NOTIFY,AddNotificationCommand);
			
			
			//minimizes a neem column so it can be used again
//			this.addCommand(CloveEvent.MINIMIZE_COLUMN,MinimizeColumnCommand);
			
			
			
			//refreshes the columns
			//this.addCommand(CloveEvent.LOAD_COLUMNS,RefreshColumnsCommand);
			
			//installs plugin byte data
			this.addCommand(CloveEvent.DOWNLOAD_PLUGIN,DownloadAndInstallPluginCommand);
			
			//controls the add-on header views
			this.addCommand(CloveEvent.ADD_HEADER_VIEW,AddViewCommand);
			this.addCommand(CloveEvent.SET_MAIN_HEADER_VIEW,AddViewCommand);
			this.addCommand(CloveEvent.ADD_FOOTER_VIEW,AddViewCommand);
		}
		
		
		/*
		 */
		
		protected function initApplication():void
		{
			
		}
		
	}
}