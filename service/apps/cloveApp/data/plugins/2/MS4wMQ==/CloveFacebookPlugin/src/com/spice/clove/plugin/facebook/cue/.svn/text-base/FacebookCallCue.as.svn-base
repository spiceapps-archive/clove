package com.spice.clove.plugin.facebook.cue
{
	import com.facebook.Facebook;
	import com.facebook.events.FacebookEvent;
	import com.facebook.net.FacebookCall;
	import com.spice.utils.queue.cue.CueStateType;
	import com.spice.utils.queue.cue.StateCue;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	
	public class FacebookCallCue extends StateCue
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _connection:Facebook;
		private var _call:FacebookCall;
		private var _resultCallback:Function;
		private var _restart:Boolean;
		
		[Bindable] 
		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookCallCue(call:FacebookCall,
										resultCallback:Function = null,
										restartIfFail:Boolean = true)
		{
			_call	    	= call;
			_resultCallback = resultCallback;
			_restart        = restartIfFail;
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
			_connection = _model.connection;
			
			Logger.log("init "+_connection+" "+_call,this);
			
			_call.addEventListener(FacebookEvent.COMPLETE,onComplete);
			
			if(_connection)
				_connection.post(_call);
			else
				Logger.log("Facebook is not connected!",this,LogType.WARNING);			
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onComplete(event:FacebookEvent):void
		{
			
			Logger.log("onComplete() success="+event.success,this);
			
			event.target.removeEventListener(event.type,onComplete);
			
			
			if(event.success)
			{
				
				if(_resultCallback != null)
					_resultCallback(event.data);
				
				
				this.complete();
				
			}
			else
			{

				Logger.log("error="+event.error.errorCode+" "+event.error.errorMsg,this,LogType.WARNING);
				this.complete(CueStateType.ERROR);
						
			}
			
			
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		
		private function grantPermission(type:String):void
		{
			
			Alert.show("Press OK once you have granted the extended permission","Grant Permission",4,null,onPermissionGranted);
			
			_connection.grantExtendedPermission(type);
		}
		
		/**
		 */
		
		private function onPermissionGranted(event:CloseEvent):void
		{
			if(event.detail == Alert.OK)
			{
				//restart
				this.init();
			}
		}
		
        

	}
}