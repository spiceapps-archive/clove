package com.spice.clove.commands.bundle
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.PackerEvent;
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.vo.PluginVO;
	import com.spice.clove.vo.RebundleVO;
	import com.spice.utils.queue.QueueManager;
	
	import nochump.util.zip.ZipOutput;
	
	public class RebundleAIRCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		private var _output:ZipOutput;
		private var _bundle:RebundleVO;
		
		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		private var _queue:QueueManager
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function RebundleAIRCommand()
		{
			_queue = new QueueManager(false);	
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function execute(event:CairngormEvent):void
		{
			var newBundleCue:NewBundleCue = new NewBundleCue();
			
			
			var plugins:Array = RebundleVO(PackerEvent(event).value).plugins;
			
			_queue.addCue(newBundleCue);
			
			for each(var plugin:PluginVO in plugins)
			{
				_queue.addCue(new UploadCue(plugin,newBundleCue));
			}
			
			_queue.addCue(new FinalizeBundleCue(newBundleCue));
			
			_queue.start();
			
		}
		
	}
}
