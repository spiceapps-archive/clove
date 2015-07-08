package com.architectd.youtube.dataHandler
{
	import com.adobe.xml.syndication.atom.Atom10;
	import com.adobe.xml.syndication.atom.Entry;

	public class YoutubeAtomHandler extends YoutubeDataHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeAtomHandler()
		{
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getData(data:String):*
		{
			var atom:Atom10 = new Atom10();
			atom.parse(data);
			
			var dat:Array = [];
			
			for each(var entry:Entry in atom.entries)
			{
				dat.push(getEntryData(entry));
			}
			
			return dat;
		}
		
		
		/**
		 */
		
		protected function getEntryData(entry:Entry):*
		{
			//abstract
		}
	}
}