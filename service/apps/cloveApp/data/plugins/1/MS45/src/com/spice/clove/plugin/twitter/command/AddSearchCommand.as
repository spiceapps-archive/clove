package com.spice.clove.plugin.twitter.command
{
	import com.spice.utils.command.CommandCue;
	import com.spice.utils.command.InvokationCommand;

	
	/*
	  command called by the browser 
	  @author craigcondon
	  
	 */	
	public class AddSearchCommand extends CommandCue
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function AddSearchCommand(cmd:InvokationCommand)
		{
			super(cmd);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		override public function init() : void
		{
			
			
			this.complete();
		}
	}
}