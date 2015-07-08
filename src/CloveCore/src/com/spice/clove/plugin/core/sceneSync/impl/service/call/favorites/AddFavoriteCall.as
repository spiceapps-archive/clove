package com.spice.clove.plugin.core.sceneSync.impl.service.call.favorites
{
	import com.adobe.serialization.json.JSON;
	import com.spice.clove.plugin.core.content.data.CloveDataSettingName;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveDataHandler;
	import com.spice.clove.plugin.impl.content.data.CloveDataSettingType;
	import com.spice.clove.plugin.impl.content.data.CloveHashTableSetting;
	import com.spice.clove.plugin.impl.content.data.CloveMetadataType;
	
	import flash.net.URLRequestMethod;
	
	import mx.utils.ObjectUtil;

	public class AddFavoriteCall extends CloveServiceCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		[Setting]
		public var name:String;
		
		[Bindable] 
		[Setting]
		public var description:String;
		
		[Bindable] 
		[Setting]
		public var datePosted:String;
		
		[Bindable] 
		[Setting]
		public var groupName:String;
		
		[Bindable] 
		[Setting]
		public var uid:String;
		
		[Bindable] 
		[Setting]
		public var metadata:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AddFavoriteCall(category:String,data:ICloveData)
		{
			this.groupName = category;
			this.name = data.getTitle();
			this.description = "";
			this.uid = data.getUID();
			this.datePosted = new Date(data.getDatePosted()).toDateString();
			
			
			  
			var metadata:CloveHashTableSetting = CloveHashTableSetting(data.getSettingTable().getNewSetting(CloveDataSettingType.HASH,CloveDataSettingName.HASH_TABLE));
			
			
			
		
			var meta:Array = ObjectUtil.copy(metadata.getHashTable()) as Array;
			
			var obj:Object = {};
			obj[CloveMetadataType.CONTENT] = data.getMessage();
			meta.push(obj);
			
			obj = {};
			obj[CloveMetadataType.ICON] = data.getIcon();
			meta.push(obj);
			
			//add extra slashes, because the server needs to perform a stripslashes
			this.metadata = escape(JSON.encode(meta));//.replace(/(\\)+/igs,"\\\\");
			
			
			
			super(CloveUrls.FAVORITES_ADD_URL,new CloveDataHandler(),URLRequestMethod.POST);
		}
	}
}