package com.spice.clove.commands.export
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.PackerEvent;
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.events.QueueManagerEvent;
	import com.spice.utils.queue.QueueManager;
	
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.binding.utils.ChangeWatcher;
	
	public class ExportPluginCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _queue:QueueManager;
		private var _data:ByteArray;
		private var _total:Number;
		
		
		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ExportPluginCommand()
		{
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
			var list:Array = PackerEvent(event).value as Array;
			
			_total = list.length;
			
			_data = new ByteArray();
			
			_queue = new QueueManager();
			_queue.addEventListener(QueueManagerEvent.QUEUE_COMPLETE,onQueueComplete);
			
			
			
			for each(var ref:FileReference in list)
			{
				_queue.addCue(new PackCue(_data,ref));
			}
			
			
			ChangeWatcher.watch(_queue,"stackLength",onCue);
			
			_queue.start();
			
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public function onCue(event:*):void
        {
        	_model.packModel.percentDone = (_total - _queue.stackLength) / _total * 100;
        }
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onQueueComplete(event:QueueManagerEvent):void
		{
			
			event.currentTarget.removeEventListener(event.type,onQueueComplete);
			
			
			_model.packModel.percentDone = 0;
//			_model.packModel.file = this._data;
			
			
		}

	}
}