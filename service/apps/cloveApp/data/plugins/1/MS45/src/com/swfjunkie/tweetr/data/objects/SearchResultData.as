package com.swfjunkie.tweetr.data.objects
{
	import com.swfjunkie.tweetr.Tweetr;
		
    /*
      Search Results Data Object
      @author Sandro Ducceschi [swfjunkie.com, Switzerland]
     */
   
    public class SearchResultData
    {
        //--------------------------------------------------------------------------
        //
        //  Class variables
        //
        //--------------------------------------------------------------------------
		
		
        //--------------------------------------------------------------------------
        //
        //  Initialization
        //
        //--------------------------------------------------------------------------
        public function SearchResultData(
                                         id:Number = 0, 
                                         link:String = null, 
                                         text:String = null, 
                                         createdAt:String = null, 
                                         userProfileImage:String = null, 
                                         user:String = null, 
                                         userLink:String = null) 
        {
            this.id = id;
            this.link = link;
            this.text = text;
            this.createdAt = createdAt;
            
            var screenName:String   = user.match(/\w+/is)[0];
            var username:String 	= user.match(/(?<=\().*?(?=\))/is)[0];
            
            
            this.user = new UserData(-1,
            						 username,
            						 screenName,
            						 null,
            						 null,
            						 userProfileImage,
            						 userLink);
        }
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        public var id:Number;
        public var link:String;
        public var text:String;
        public var createdAt:String;
        public var user:UserData;
        //--------------------------------------------------------------------------
        //
        //  API
        //
        //--------------------------------------------------------------------------
    }
}