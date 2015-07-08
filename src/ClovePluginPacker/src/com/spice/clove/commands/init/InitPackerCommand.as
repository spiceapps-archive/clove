package com.spice.clove.commands.init
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.model.ConfigModel;
	import com.spice.commands.init.InitCommand;
	import com.spice.events.QueueManagerEvent;
	
	public class InitPackerCommand extends InitCommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable] private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function InitPackerCommand()
		{
			super(_model.initModel);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function execute(event:CairngormEvent):void
		{
			
			this.addCue(new InitConfig());
			this.addCue(new InitSession());
			
			
			super.execute(event);
		}
		
		

	}
}