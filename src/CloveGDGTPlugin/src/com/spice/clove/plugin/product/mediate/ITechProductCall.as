package com.spice.clove.plugin.product.mediate
{
	
	public interface ITechProductCall extends IProductCall
	{
		function get manufacturer():String;
		function get price():Number;
	}
}