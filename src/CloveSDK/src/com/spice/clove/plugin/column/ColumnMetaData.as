package com.spice.clove.plugin.column
{
	
	/*
	   
	  @author craigcondon
	  
	 */	
	public class ColumnMetaData
	{
		[PrivateMetaData]
		public static const TITLE:String	   		= "title";
		
		public static const NOT_ADDABLE:String 		= "notAddable";
		public static const COLUMN_WIDTH:String 	= "hColumnWidth";
		
		//side bar
		public static const COLUMN_ICON:String		= "columnIcon";
		
		//per column
		public static const ROW_COLOR:String  		= "rowColor";  
		public static const ROW_ALPHA:String  		= "rowAlpha"; 
		public static const ROW_FONT_COLOR:String 	= "rowFontColor";
		public static const COLUMN_FILTERS:String   = "columnFilters";
		
		
		
		//per popup (away from current view)
		public static const ROW_GAP:String	    	= "rowGap";
		public static const HIDE_CHROME:String  	= "showChrome";
		public static const ROW_PADDING:String  	= "rowPadding";
		public static const TITLE_SIZE:String   	= "titleSize";
		public static const MESSAGE_SIZE:String		= "messageSize";	
		public static const ICON_SIZE:String		= "iconSize";   	
		public static const POPUP_X:String		 	= "popupX";   	
		public static const POPUP_Y:String			= "popupY";   	
		public static const POPUP_WIDTH:String		= "popupWidth";   	
		public static const POPUP_HEIGHT:String		= "iconSize";   	
		public static const ALWAYS_IN_FRONT:String	= "alwaysInFront";   
		public static const LOCK_POPUP_SIZE:String  = "lockPopupSize";
		
		//set when the column is installed
		public static const COLUMN_INFO:String  	= "columnInfo";
		
		//installing a column
		public static const COLUMN_CONTROLLER:String = "columnController";
		public static const COLUMN_COLOR:String      = "columnColor";
		
		
		//maximum number of rows before the SQLList dumps
		public static const MAX_ROWS:String = "maxRows";
		
		//used for selecting the name for the items (editing)
		public static const EDIT_TITLE:String = "editTitle";
		
		
		
		
		public static const NUM_SUM_UNREAD:String = "numSumUnreaddd";
		public static const GROUP_EXPANDED:String = "dockGroupExpandeddd";
		
		
		//for the column view controller (store current view state)
		public static const CURRENT_COLUMN_VIEW:String = "currentColumnView";
		
		
	}
}