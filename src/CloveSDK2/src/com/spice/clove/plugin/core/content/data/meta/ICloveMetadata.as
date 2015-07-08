package com.spice.clove.plugin.core.content.data.meta
{
	public interface ICloveMetadata
	{
		
		/**
		 * the type of metadata 
		 * @return 
		 * 
		 */		
		function getType():String;
		
		/**
		 * the metadata inline data 
		 * @return 
		 * 
		 */		
		
		function getData():String;
		
		
		/**
		 * the label for the metadata
		 */
		
		function getLabel():String;
		
		
	}
}