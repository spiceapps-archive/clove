package com.spice.clove.plugin.core.content.data
{
	import com.spice.clove.plugin.core.content.control.ICloveServiceContentController;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.core.settings.ISettingFactory;
	import com.spice.vanilla.core.settings.ISettingTable;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	
	/**
	 * the data all info needs to be transformed to 
	 * @author craigcondon
	 * 
	 */	

	public interface ICloveData extends IProxyOwner, IDisposable
	{
		function getUID():String;
		function setUID(value:String):void;
		
		function getIcon():String;
		function setIcon(value:String):void;
		
		function getTitle():String;
		function setTitle(value:String):void;
		
		function getMessage():String;
		function setMessage(value:String):void;
		
		
		function disposed():Boolean;
		
		function getDatePosted():Number;
		function setDatePosted(value:Number):void;
		
		function getItemRenderer():ICloveDataRenderer;
		function setItemRenderer(value:ICloveDataRenderer):void;
		
		
		/**
		 * the item renderer ultimitely controls what other data is stored with the clove data. This
		 * anges everything from attachments, metadata, to information needed to fully interact with the
		 * custom info. 
		 */
		
		
		function registerSettingFactory(value:ISettingFactory):void;
		
		
		/**
		 * the constructed setting based off the ISettingFactory
		 * @return 
		 * 
		 */		
		
		function getSettingTable():ISettingTable;
		
		/**
		 * 
		 * @param uid the uid of the VO data
		 * @param datePosted the date posted for the vo data
		 * @param title the title of the data
		 * @param message the body of the data
		 * @param icon the icon for the data
		 * @param vo additional metadata needed for the item renderer
		 * @return 
		 * 
		 */	
		
		function construct(uid:String      = null,
						   datePosted:Date = null, 
						   title:String    = null,
						   message:String  = null,
						   icon:String 	   = null,
						   settingFactory:ISettingFactory = null):ICloveData;
		
		
		
		
	}
}