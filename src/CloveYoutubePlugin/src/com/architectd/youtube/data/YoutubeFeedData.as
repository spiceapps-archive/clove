package com.architectd.youtube.data
{
	import com.adobe.xml.syndication.atom.Author;
	import com.adobe.xml.syndication.atom.Category;
	import com.adobe.xml.syndication.atom.Entry;
	import com.architectd.youtube.calls.YoutubeUrls;

	public class YoutubeFeedData
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var categories:Array;
		public var author:YoutubeAuthorData;
		public var title:String;
		public var description:String;
		public var published:Date;
		public var videoUrl:String;
		public var relatedAtomUrl:String;
		public var responsesAtomUrl:String;
		public var embedUrl:String;
		public var uid:String;
		public var smallIcon:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeFeedData(title:String = null,
										description:String = null,
										uid:String		 = null,
										author:YoutubeAuthorData = null,
										categories:Array = null,
										published:Date = null,
										smallIcon:String = null,
										videoUrl:String = null,
										relatedAtomUrl:String = null,
										responsesAtomUrl:String = null,
										embedUrl:String = null)
		{
			this.categories = categories;
			this.uid = uid;
			this.description = description;
			this.author = author;
			this.title = title;
			this.published = published;
			this.smallIcon  = smallIcon;
			this.relatedAtomUrl = relatedAtomUrl;
			this.videoUrl = videoUrl;
			this.responsesAtomUrl = responsesAtomUrl;
			this.embedUrl = embedUrl;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public static function fromEntry(entry:Entry):YoutubeFeedData
		{
			
			
			
			var categories:Array = [];
			
			for each(var cat:Category in entry.categories)
			{
				if(cat.term.indexOf("http://") > -1) continue;
				
				categories.push(new YoutubeCategoryData(cat.term));
			}
			
			
			var author:Author = entry.authors[0];
			
			var authorName:String  = author.name;
			var authorURI:String  = author.uri;
			
			var auth:YoutubeAuthorData = new YoutubeAuthorData(authorName,authorURI);
			
			
			var title:String = entry.title;
			var description:String = entry.content.value;
			
			
			var published:Date = entry.published;
			
			var videoUrl:String     = entry.links[0].href;
			var relatedUrl:String   = entry.links[2].href;
			var responsesUrl:String = entry.links[1].href;
			var uid:String 			= entry.id.match(/(?<=\/)([^\/]*)$/)[0];
			var embedUrl:String 	= YoutubeUrls.GET_EMBED_URL(uid);
			var embedIcon:String	= YoutubeUrls.GET_EMBED_ICON_SMALL(uid);
			
		
			return new YoutubeFeedData(title,
									   description,
									   uid,
									   auth,
									   categories,
									   published,
									   embedIcon,
									   videoUrl,
									   relatedUrl,
									   responsesUrl,
									   embedUrl);
		}
	}
}