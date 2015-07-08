package com.spice.clove.model
{
	import com.spice.utils.lang.ApplicationTranslator;
	import com.spice.utils.lang.TranslateUtil;
	
	/*
	  the purpose of having  ALL english strings in this file is to enable an array
	  of languages to support. 
	  @author Craig
	  
	 */	
	 
	[Bindable]
	public class LangModel
	{
		
		[Translatable] public var APPLICATION_TITLE:String = "Clove";
		
		/*
		  Queue Window 
		 */		
		[Translatable] public var PROCESS_WINDOW_TITLE:String = "Processes";
		[Translatable] public var ACTIONS_IN_CUE:String 	   = "Actions in Cue:";
		
		
		/*
		  CloveAlert 
		 */		
		
		[Translatable] public var DONT_SHOW_AGAIN:String	   = "Don't show me this message again.";
		[Translatable] public var YES:String    = "Yes";
		[Translatable] public var NO:String     = "No";
		[Translatable] public var CANCEL:String = "Cancel";
		
		/*
		  Prefeences 
		 */		
		[Translatable] public var PREF_UNINSTALL_PLUGIN:String = "Uninstall this Plugin";
		
		
		//avail columns
		[Translatable] public var COLUMN_NAME:String = "Column Name";
		[Translatable] public var ADD_COLUMN:String  = "Add Column";
		
		//pref refreshing
		[Translatable] public var MINUTES:String = "Minutes";
		
		//UI Prerences
		[Translatable] public var UI_FONT_SIZE:String = "Font Size:";
		[Translatable] public var UI_TITLE_FONT_SIZE:String = "Title Font Size:";
		[Translatable] public var UI_ICON_SIZE:String = "Icon Size:";
		[Translatable] public var UI_ROW_PADDING:String = "Row Padding:";
		[Translatable] public var UI_ROW_GAP:String     = "Row Gap:";

		/*
		  File Dropper 
		 */		
		 
		[Translatable] public var UI_ADD_THESE_FILES:String = "Add these Files";
		[Translatable] public var UI_ADD_THIS_FILE:String   = "Add this File";
		
		/*
		  Drop Menu at the top 
		 */
		
				
		[Translatable] public var DROP_WINDOW:String = "Window";
		
		
		
		public var translator:ApplicationTranslator = ApplicationTranslator.getInstance();
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function LangModel():void
		{
			TranslateUtil.bindLang(this);
		}
		
	}
}