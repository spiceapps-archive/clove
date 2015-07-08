package com.spice.clove.view.controls
{
	import com.spice.clove.model.CloveModelLocator;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.controls.TextArea;
	
	public class PostTextArea extends TextArea
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function PostTextArea()
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Ppublic Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function focus():void
		{
			this.setFocus();
			this.setSelection(this.text.length,this.text.length);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		  why the Flex team didn't return the real textField value baffles me.
		  when typing a shortcut (ttyl -> talk to you later) the TextField reference is changed
		  instead of the TextArea, and setting the value text in TextArea assigns _text to the value...
		  _text is returned by the getter.. ugh >.>
		 */
		[Bindable(event="textChanged")]
		override public function get text():String
		{
			return super.textField.text;
		}
		/*
		 */
		
		public function get clipText():String
		{
			return "";
		}
		
		/*
		 */
		
		public function set clipText(value:String):void
		{
			if(!this.root)
				return;
			
				
			/* var cp:DisplayObject = this.parent;
		
			while(cp && cp.visible)
			{
				cp = cp.parent;
			}
			
			if((cp && !cp.visible) )
			{
				return;
			} */
				
			
			
			this.text += value;
			
			this.dispatchEvent(new Event("textChanged"));
			
			flash.utils.setTimeout(focus,1);
			
		}
		

	}
}