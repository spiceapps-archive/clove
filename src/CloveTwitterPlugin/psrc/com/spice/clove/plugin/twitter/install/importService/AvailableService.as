package com.spice.clove.plugin.twitter.install.importService
{
	[Bindable] 
	public class AvailableService
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var name:String;
		public var service:ServiceImporter;
		public var selected:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function AvailableService(name:String,service:ServiceImporter)
		{
			this.name = name;
			this.service = service;
		}
	}
}