package com.spice.clove.controls
{
	import com.spice.clove.commandEvents.*;
	import com.spice.clove.commands.*;
	import com.spice.clove.commands.init.InitAIRCommand;
	import com.spice.clove.commands.plugin.*;

	public class CloveAIRController extends CloveCoreController
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		
		public function CloveAIRController()
		{
			super(InitAIRCommand);
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		
		override protected function initCommands():void
		{
			super.initCommands();
			
			//wipes the settings
			
			this.addCommand(CloveAIREvent.WIPE_SETTINGS,WipeSettingsCommand);
			
			this.addCommand(CloveEvent.CHECK_UPDATE,CheckUpdateCommand);
			
			//adds a blank column -- later change this to a group column showing what types of columns are added
			this.addCommand(CloveEvent.ADD_COLUMN,AddColumnCommand);
			
			this.addCommand(CloveEvent.ADD_GROUP,AddColumnCommand);
			
			
			this.addCommand(CloveEvent.INSTALL_PLUGIN_WITH_CONFIRM,InstallPluginWithConfirmCommand);
			this.addCommand(CloveEvent.INSTALL_PLUGIN,UnpackAndInstallPluginCommand);
			
			//enables the ability to add menu items
			this.addCommand(AddMenuItemEvent.ADD_MENU_ITEM,AddMenuItemCommand);
			//opens up preference window
			this.addCommand(CloveEvent.OPEN_PREFERENCES,OpenPreferencesCommand);
			
			this.addCommand(CloveEvent.COPY_TO_POSTER,CopyToPosterCommand);
			this.addCommand(CloveEvent.ADD_ACTIVE_POSTABLE,AddActivePostableCommand);
			this.addCommand(CloveEvent.ADD_POSTER_ACTION,AddPosterActionCommand);
			
			
			
		}
		
		
	}
}