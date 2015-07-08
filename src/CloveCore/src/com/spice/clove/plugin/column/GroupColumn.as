package com.spice.clove.plugin.column
{
	
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.core.root.impl.settings.RootPluginSettingType;
	import com.spice.clove.view.column.BandedClovePluginColumnDataView;
	import com.spice.utils.EmbedUtil;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.NumberSetting;
	
	
	/*
	  GroupColumns are the items tyou see on the left side 
	  @author craigcondon
	  
	 */
	public class GroupColumn extends ClovePluginColumn
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function GroupColumn(controller:ICloveContentController = null)
		{
			super(controller,RootPluginSettingType.GROUP_COLUMN);
			
			if(!title)
			{
				
				this.title = "Untitled Group";
			}
			
			
			//groups are NOT color coded.
			NumberSetting(this.metadata.getNewSetting(BasicSettingType.NUMBER,ColumnMetaData.COLUMN_COLOR)).setData(0x888888);
		}
		
		
		/*
		 */
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/*
		 */
		
		override public function get viewClass() : Class
		{
			return BandedClovePluginColumnDataView;
		}
		
		/*
		 */
		
		override public function set title(value:String) : void
		{
			if(value == "" || value == "null" || !value)
				value = "Untitled Group";
			
			super.title = value;
			
			
		}
		
		
		
	}
}