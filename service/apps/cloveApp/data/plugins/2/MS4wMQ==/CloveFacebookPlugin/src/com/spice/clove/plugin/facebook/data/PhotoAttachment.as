package com.spice.clove.plugin.facebook.data
{
	import com.facebook.Facebook;
	import com.facebook.commands.photos.GetPhotos;
	import com.facebook.data.photos.GetPhotosData;
	import com.facebook.data.photos.PhotoData;
	import com.facebook.events.FacebookEvent;
	
	
	[Bindable]
	public class PhotoAttachment
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var photoSmall:String;
        public var photoLarge:String;
        public var postID:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PhotoAttachment()
		{
		}
		

	}
}