package com.spice.clove.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.IResponder;
	
	public class BundleDelegate
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _service:Object;
		private var _responder:IResponder;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BundleDelegate(responder:IResponder)
		{
			_service = ServiceLocator.getInstance().getService('bundleService');
			
			_responder = responder;
		}
		  
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function createNewBundle():void
		{
			var serv:Object = _service.createNewBundle();
			serv.addResponder(_responder);
		}
		
		/**
		 */
		
		public function rebundle(id:*):void
		{
			var serv:Object = _service.rebundle(id);
			serv.addResponder(_responder);
		}

	}
}