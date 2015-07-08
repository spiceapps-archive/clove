package com.spice.clove.commands.bundle
{
	import com.spice.clove.business.BundleDelegate;
	import com.spice.utils.queue.cue.Cue;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class NewBundleCue extends Cue implements IResponder
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _service:BundleDelegate;
		private var _id:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function NewBundleCue()
		{
			_service = new BundleDelegate(this);	
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get id():String
		{
			return _id;
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
			_service.createNewBundle();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function result(data:Object):void
		{
			
			_id = ResultEvent(data).message.body.toString();
			this.complete();
			
			
		}
		
		/**
		 */
		
		public function fault(data:Object):void
		{
			
			Alert.show(FaultEvent(data).fault.faultString);
		}

	}
}