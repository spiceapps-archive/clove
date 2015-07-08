package com.spice.clove.commands.export
{
	import com.spice.utils.queue.cue.Cue;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	public class PackCue extends Cue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _pack:ByteArray;
		private var _file:FileReference;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PackCue(pack:ByteArray,file:FileReference)
		{
			_pack = pack;
			
			_file = file;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function init():void
		{
			_file.addEventListener(Event.COMPLETE,onLoad);
			_file.load();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onLoad(event:Event):void
		{
			
			
			
			event.currentTarget.removeEventListener(event.type,onLoad);
			
//			_pack.writeObject(new CPlugItem(_file.name,_file.data));
			
			this.complete();
			
		}

	}
}