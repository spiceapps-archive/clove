package com.spice.clove.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.business.UserDelegate;
	import com.spice.clove.commandEvents.PackerEvent;
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.model.ViewModel;
	import com.spice.clove.vo.UserVO;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	public class UserServiceCommand implements ICommand, IResponder
	{
	
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _service:UserDelegate;
		
		private var _event:PackerEvent;
		
		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
			
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function UserServiceCommand()
		{
			_service = new UserDelegate(this);
			
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
			var func:Function
			
			_event = PackerEvent(event);
			
			switch(event.type)
			{
				case PackerEvent.LOGIN_USER:
					func = _service.login;
				break;
				case PackerEvent.SIGNUP_USER:
					func = _service.signup;
				break;
			}
			
			func(_event.value);
		}
        /**
		 */
		
		public function result(data:Object):void
		{
			_model.viewModel.currentView = ViewModel.CHOICE_VIEW;
			
			_model.userModel.currentUser = _event.value as UserVO;
		}
		
		/**
		 */
		
		public function fault(data:Object):void
		{
			Alert.show(FaultEvent(data).fault.faultString);
		}

	}
}