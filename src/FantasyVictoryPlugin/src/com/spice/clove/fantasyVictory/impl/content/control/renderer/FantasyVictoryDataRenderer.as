package com.spice.clove.fantasyVictory.impl.content.control.renderer
{
	import com.spice.clove.fantasyVictory.impl.content.control.FantasyVictoryContentController;
	import com.spice.clove.fantasyVictory.impl.service.data.FVVideoData;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.content.control.render.AbstractCloveDataRenderer;
	import com.spice.clove.plugin.impl.content.data.CloveMetadataType;
	import com.spice.vanilla.core.proxy.IProxyMediator;

	public class FantasyVictoryDataRenderer extends AbstractCloveDataRenderer
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FantasyVictoryDataRenderer(controller:FantasyVictoryContentController,mediator:IProxyMediator)
		{
			super(controller,mediator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function getUID(vo:Object):String
		{
			return FVVideoData(vo).playerName;
		}
		/**
		 */
		
		override public function setCloveData(vo:Object, data:ICloveData):Boolean
		{
			super.setCloveData(vo,data);
			
			var fv:FVVideoData = FVVideoData(vo);
			
			data.setTitle(fv.playerName);
			data.setMessage(fv.description);
			data.setIcon(fv.teamIconUrl);
			data.setUID(fv.playerName);
			data.setDatePosted(new Date().time);
			  
			  
			
			var embedHtml:String = '<object width="320" height="280"><param name="movie" value="'+fv.videoUrl+'"></param><param="wmode" value="opaque"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="'+fv.videoUrl+'" wmode="opaque" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="320" height="280"></embed></object>';
			
			//the embed video we use inside Clove
			this.addMetadata(CloveMetadataType.AUTO_EXPANDED_EMBEDDABLE_HTML,embedHtml,"View Video");
			
			//the html url to go to
			this.addMetadata(CloveMetadataType.HTML_URL,fv.detailsUrl,"Read More...");
			
			this.setMessageReplacements(vo,data);
				
			return this.filterText(data.getTitle().toLowerCase());//this.filterCloveData(data);
		}
	}
}