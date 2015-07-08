package com.spice.clove.sceneSync.core.service.data
{
	public class PluginData
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var name:String;
        public var description:String;
        public var downloadUrl:String;
        public var uid:String;
        public var factory:String;
        public var createdAt:Date;
        public var updatedAt:Date;
        public var updateInfo:String;
        public var version:String;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function PluginData(name:String = null,
								   description:String = null,
								   downloadUrl:String = null,
								   uid:String = null,
								   factory:String = null,
								   createdAt:Number = NaN,
								   updatedAt:Number = NaN,
								   updateInfo:String = null,
								   version:String = null)
		{
			this.name = name;
			this.description = description;
			this.downloadUrl = downloadUrl;
			this.uid = uid;
			this.factory = factory;
			this.createdAt = new Date(createdAt*1000);
			this.updatedAt = new Date(updatedAt*1000);
			this.updateInfo = updateInfo;
			
			this.version = version;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public static function fromXML(xml:*):PluginData
		{
			return new PluginData(xml.name,
								  xml.description,
								  xml.download,
								  xml.uid,
								  xml.factory,
								  xml.created_at,
								  xml.updated_at,
								  xml.version_description,
								  xml.current_version);
		}
	}
}