package com.spice.clove.plugin.flex.views.controls
{
	import com.spice.events.TextManagerEvent;
	import com.spice.core.text.command.ITextCommandReplacer;
	import com.spice.utils.textCommand.TextCommandTarget;
	
	import flash.events.Event;
	import flash.events.TextEvent;
	
	import mx.controls.Text;
	
	
	/*
	  
	  @author craigcondon
	  
	 */	
	
	public class SuperText extends Text
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _untouchedText:String;
//		private var _textManager:ITextCommandReplacer;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function SuperText()
		{
			super();
			
			
		}
		
		
		
		private function onScroll(event:Event):void
		{
			this.textField.scrollV = 0;
		}
		
		
		
		override protected function createChildren() : void
		{
			super.createChildren();
			
			this.textField.addEventListener(Event.SCROLL,onScroll);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/*
		  replaces text according to the handlers registered by the set ITextCommandReplacer
		  @return 
		  
		 */		
		
		/*public function get textManager():ITextCommandReplacer
		{
			return _textManager;
		}*/

		/*
		  @private
		 */
		
//		public function set textManager(value:ITextCommandReplacer):void
//		{
//			
//			Logger.log("textManager="+value,this);
//			
//			if(_textManager)
//			{
//				_textManager.removeEventListener(TextManagerEvent.NEW_HANDLER,onNewHandler);
//			}
//			_textManager = value;
//			
//			
//			if(!value)
//				return;
//			
//			_textManager.addEventListener(TextManagerEvent.NEW_HANDLER,onNewHandler,false,0,true);
//			
//			
//			
//			
//			_textManager.replaceText(new TextCommandTarget(this,"untouchedText"));
//			
//			
//		}
		
		/*
		 */
		
		/*override public function set htmlText(value:String):void
		{
			super.htmlText = _untouchedText = value;
			
			
			
			//NOTE: for NOW, we ned to 
			if(false && _textManager)		
			{
				_textManager.replaceText(new TextCommandTarget(this,"untouchedText"));
			}
			
			
		}*/
		
		/*
		 */
		
		public function get untouchedText():String
		{
			return super.htmlText;
		}
		
		/*
		 */
		
		public function set untouchedText(value:String):void
		{
			super.htmlText = value;
		}
		
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onNewHandler(event:TextManagerEvent):void
		{
			
			this.htmlText = this._untouchedText;
		}

	}
}

	