package com.spice.clove.urlExpander.core.data
{
	public class AddExpandedUrlData
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _originalUrl:String;
		private var _expandedUrl:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AddExpandedUrlData(originalUrl:String,expandedUrl:String)
		{
			this._originalUrl = originalUrl;
			this._expandedUrl = expandedUrl;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getOriginalUrl():String
		{
			return this._originalUrl;
		}
		
		/**
		 */
		
		public function getExpandedUrl():String
		{
			return this._expandedUrl;
		}
	}
}