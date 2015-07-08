package com.spice.clove.commands.init
{
	import com.spice.clove.business.UserDelegate;
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.model.ViewModel;
	import com.spice.utils.queue.cue.Cue;
	
	import mx.rpc.IResponder;
	
	public class InitSession extends Cue implements IResponder
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _service:UserDelegate;
		
		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function InitSession()
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
		
		override public function init():void
		{
			_service.verifySession();
		}
		
		/**
		 */
		
		public function result(data:Object):void
		{
			_model.viewModel.currentView = ViewModel.CHOICE_VIEW;
		}
		
		/**
		 */
		
		public function fault(data:Object):void
		{
			_model.viewModel.currentView = ViewModel.LOGIN_VIEW;
		}
	}
}