package com.spice.clove.commands.bundle
{
	import com.spice.clove.business.BundleDelegate;
	import com.spice.utils.queue.cue.Cue;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class FinalizeBundleCue extends Cue implements IResponder
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _service:BundleDelegate;
		private var _idCue:NewBundleCue;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FinalizeBundleCue(idCue:NewBundleCue)
		{
			_service = new BundleDelegate(this);
			_idCue = idCue;
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
			_service.rebundle(_idCue.id);
		}
		
		/**
		 */
		
		public function result(data:Object):void
		{
			Alert.show(ResultEvent(data).message.body.toString());
		}
		
		/**
		 */
		
		public function fault(data:Object):void
		{
			Alert.show(FaultEvent(data).fault.faultString);
		}
	}
}