package com.spice.clove.model
{
	import mx.collections.ArrayList;
	import mx.core.UIComponent;
	
	
	/*
	  NavModel contains UI elements that can be swapped out by any plugin 
	  @author craigcondon
	  
	 */	
	 
	[Bindable] 
	public class NavModel
	{
		
		//the base header that goes above all others. This is the swap-out out header 
		public var baseHeader:UIComponent
		
		
		//the footer nav that's replaceable
		public var footer:UIComponent;
		
		
		//any additional footers to add 
		public var additionalFooters:ArrayList = new ArrayList();

	}
}