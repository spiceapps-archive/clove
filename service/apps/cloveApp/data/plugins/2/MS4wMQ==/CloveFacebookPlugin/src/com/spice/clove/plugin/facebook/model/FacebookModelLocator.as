package com.spice.clove.plugin.facebook.model
{
	import com.facebook.Facebook;
	import com.facebook.data.stream.StreamFilterData;
	import com.spice.clove.plugin.facebook.CloveFacebookSettings;
	import com.spice.model.Singleton;
	
	[Bindable] 
	public class FacebookModelLocator extends Singleton
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookModelLocator()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public static function getInstance():FacebookModelLocator
		{
			return Singleton.getInstance(FacebookModelLocator);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public var connection:Facebook;
		
		/**
		 * the facebook ID assigned to the user
		 */
		
		public var facebookID:*;
		
		
		public var filters:Array;
		
		/**
		 */
		
		public var settings:CloveFacebookSettings = new CloveFacebookSettings();
		
		public function getFilterKeyByName(name:String):String
		{
			for each(var filt:StreamFilterData in this.filters)
			{
				if(filt.name == name)
				{
					return filt.filter_key;
				}
			}
			
			return null;
		}
		
		
		/**
		 * loads friend info
		 */
		
		public var friendModel:FriendModel = new FriendModel();

	}
}