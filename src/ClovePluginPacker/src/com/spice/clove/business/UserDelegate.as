package com.spice.clove.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.spice.clove.vo.UserVO;
	
	import mx.rpc.IResponder;
	
	public class UserDelegate
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
		 
		
		public function UserDelegate(responder:IResponder)
		{
			_service = ServiceLocator.getInstance().getService('userService');
			
			this._responder = responder;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function verifySession():void
		{
			var serv:Object = _service.verifySession();
			serv.addResponder(_responder);
		}
		
		/**
		 */
		
		public function login(vo:UserVO):void
		{
			var serv:Object = _service.login(vo.username,vo.password);
			serv.addResponder(_responder);
		}
		
		/**
		 */
		
		public function signup(vo:UserVO):void
		{
			var serv:Object = _service.signup(vo.username,vo.password);
			serv.addResponder(_responder);
		}
		
		
		

	}
}