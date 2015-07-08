package com.degrafa.skins
{
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
 
	[Style(name="buttonStyleNameUp")]
	[Style(name="buttonStyleNameDown")]
	[Style(name="buttonStyleNameOver")]
	[Style(name="buttonStyleNameDisabled")]
	[Style(name="buttonStyleNameSelectedUp")]
	[Style(name="buttonStyleNameSelectedDown")]
	[Style(name="buttonStyleNameSelectedOver")]
	[Style(name="buttonStyleNameSelectedDisabled")]
 
	public class CSSButtonSkin extends CSSSkin
	{
		private static const UP_SKIN : String = "upSkin";
		private static const DOWN_SKIN : String = "downSkin";
		private static const OVER_SKIN : String = "overSkin";
		private static const DISABLED_SKIN : String = "disabledSkin";
 
		private static const SELECTED_UP_SKIN : String = "selectedUpSkin";
		private static const SELECTED_DOWN_SKIN : String = "selectedDownSkin";
		private static const SELECTED_OVER_SKIN : String = "selectedOverSkin";
		private static const SELECTED_DISABLED_SKIN : String = "selectedDisabledSkin";
 
		private static const BUTTON_STYLE_NAME_UP : String = "buttonStyleNameUp";
		private static const BUTTON_STYLE_NAME_DOWN : String = "buttonStyleNameDown";
		private static const BUTTON_STYLE_NAME_OVER : String = "buttonStyleNameOver";
		private static const BUTTON_STYLE_NAME_DISABLED : String = "buttonStyleNameDisabled";
 
		private static const BUTTON_STYLE_NAME_SELECTED_UP : String = "buttonStyleNameSelectedUp";
		private static const BUTTON_STYLE_NAME_SELECTED_DOWN : String = "buttonStyleNameSelectedDown";
		private static const BUTTON_STYLE_NAME_SELECTED_OVER : String = "buttonStyleNameSelectedOver";
		private static const BUTTON_STYLE_NAME_SELECTED_DISABLED : String = "buttonStyleNameSelectedDisabled";
 
		override public function getStyle(styleProp : String) : *
	    {
	    	var skinStyleName : String;
	    	var cssStyleDeclaration : CSSStyleDeclaration;
 
	    	switch (name)
	    	{
	    		case UP_SKIN:
	    			skinStyleName = styleName.getStyle(BUTTON_STYLE_NAME_UP);
	    			break;
	    		case DOWN_SKIN:
	    			skinStyleName = styleName.getStyle(BUTTON_STYLE_NAME_DOWN);
	    			break;
	    		case OVER_SKIN:
	    			skinStyleName = styleName.getStyle(BUTTON_STYLE_NAME_OVER);
	    			break;
	    		case DISABLED_SKIN:
	    			skinStyleName = styleName.getStyle(BUTTON_STYLE_NAME_DISABLED);
	    			break;
	    		case SELECTED_UP_SKIN:
	    			skinStyleName = styleName.getStyle(BUTTON_STYLE_NAME_SELECTED_UP);
	    			break;
	    		case SELECTED_DOWN_SKIN:
	    			skinStyleName = styleName.getStyle(BUTTON_STYLE_NAME_SELECTED_DOWN);
	    			break;
	    		case SELECTED_OVER_SKIN:
	    			skinStyleName = styleName.getStyle(BUTTON_STYLE_NAME_SELECTED_OVER);
	    			break;
	    		case SELECTED_DISABLED_SKIN:
	    			skinStyleName = styleName.getStyle(BUTTON_STYLE_NAME_SELECTED_DISABLED);
	    			break;
	    	}
 
	    	if (skinStyleName == null)
	    		return super.getStyle(styleProp);
 
			cssStyleDeclaration = StyleManager.getStyleDeclaration("." + skinStyleName);
 
			if (cssStyleDeclaration.getStyle(styleProp))
				return cssStyleDeclaration.getStyle(styleProp);
			else 
				return super.getStyle(styleProp);
 
	    }
	}
}

