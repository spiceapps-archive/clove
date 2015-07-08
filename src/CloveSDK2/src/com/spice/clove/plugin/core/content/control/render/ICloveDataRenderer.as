package com.spice.clove.plugin.core.content.control.render
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadata;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	
	
	/**
	 * the item renderer for the content controllers used to transform VO data into useable Rendered Data. 
	 * @author craigcondon
	 * 
	 */	
	public interface ICloveDataRenderer extends IProxyOwner
	{
		/**
		 * Transfers data from the VO, to the target CloveData. the ItemRenderer is NOT allowed to create CloveData
		 * because it may be different depending on the type of application. For the desktop app, CloveData is CloveDesktopData. For web, it's
		 * CloveWebData, etc.
		 * @param vo the vo to transfer from
		 * @param target the target to transfer to
		 * 
		 */			
		
		function setCloveData(vo:Object,target:ICloveData):Boolean;
		
		/**
		 * returns the UID of the vo data so we can store it in the database. If the UID exists, then the data is ignored. We have this method so
		 * we don't needlessly instantiate CloveData objects.
		 * @param vo the vo class 
		 * @return 
		 * 
		 */		
		
		function getUID(vo:Object):String;
		
		
		/**
		 * returns the view for the data passed 
		 * @param content the data belonging to this item renderer
		 * @param previousView the previous view used. This is passed so the item renderer can recycle data
		 * @return 
		 * 
		 */		
		
		function setContentView(data:ICloveData,target:ICloveViewTarget):void;
		
		
		
		
		/**
		 *  returns the view controller for the metadata specified. this is for metadata
		 * provided in ICloveData
		 * @param name the name of the metadata
		 * @return the view controller for the metadata provided
		 * 
		 */		
		
		function getMetadataView(metadata:ICloveMetadata):ICloveDataViewController;
		
		
	}
}