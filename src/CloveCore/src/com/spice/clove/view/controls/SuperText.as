package com.spice.clove.view.controls
{
	import com.spice.events.TextManagerEvent;
	import com.spice.utils.textCommand.TextCommandTarget;
	
	import mx.controls.Text;
	
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
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/*
		 */
		
		/*[Disposable]
		[Bindable(event="textManagerChange")]
		public function get textManager():ITextCommandReplacer
		{
			return _textManager;
		}

		
		public function set textManager(value:ITextCommandReplacer):void
		{
			
			;
			
			
			
			this.dispatchEvent(new Event("textManagerChange"));
		}*/
		
		/*
		 */
		
		override public function set htmlText(value:String):void
		{
			super.htmlText = _untouchedText = value;
			
			
			/*if(_textManager)
			{
				_textManager.replaceText(new TextCommandTarget(this,"untouchedText"));
			}*/
			
			
		}
		
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

	