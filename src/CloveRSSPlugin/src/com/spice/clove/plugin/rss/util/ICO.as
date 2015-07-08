package com.spice.clove.plugin.util{
	
	import flash.events.EventDispatcher;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;	
	import flash.net.URLRequest;
	import flash.events.Event;
	public class ICO extends EventDispatcher{
		var data : ByteArray;   
		var reserved;
		var type;
		var len;
		private var iconData;
		public var formats:Array;
		public var paletteBmp;
	   
		public function ICO(path:String = '') {
			if (path.length > 0) {
				var urlRequest = new URLRequest(path);
				var loader = new URLLoader(urlRequest);
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				loader.addEventListener(Event.COMPLETE, LoadFile);
			}
		}

        function LoadFile(e) {
			data = e.target.data;
			data.endian = Endian.LITTLE_ENDIAN;
            this.LoadData(data);
        }
		public function iconInfo(){
			
			var info = '';
			for(var i = 0; i < formats.length; i++){
			for (var key in formats[i]){
				//iconEntry header size
			data.readUnsignedInt();//w
			data.readUnsignedInt();//h
			data.readUnsignedShort();//planes
			var bitCount = formats[i].bitCount || data.readUnsignedShort();
			data.position = formats[i].FileOffset + fileOffset;
			var length = formats[i].byteSize - fileOffset;			
			
			var offsetdata:ByteArray = new ByteArray();
			offsetdata.endian = Endian.LITTLE_ENDIAN;
			switch ( bitCount ){
                case 32:
                case 24:						
					data.readBytes(offsetdata, 0, length);
					break;
				case 8:
				var tmp = new ByteArray();
					data.readBytes(tmp, 0, formats[i].colorCount * 4);
					tmp.endian = Endian.LITTLE_ENDIAN;			
					var palette = new Array();
					paletteBmp = new BitmapData(10*formats[i].colorCount, 10*formats[i].colorCount, false, 0xFF000000);
					d = 0;
					for(var p = 0; p < formats[i].colorCount; p++){
						palette[p] = tmp.readUnsignedInt();
						paletteBmp.fillRect(new Rectangle((p%16)*10, int(p/16)*10, 10, 10), palette[p]);
						d += 4;
					}
                    /*
					  8 bits: 1 byte per pixel [ COLOR INDEX ]
					*/ 
					var offset = data.position;
					var k = 0;
					for (var h = 0; h < formats[i].height; h++) {
						for (var w = 0; w < formats[i].width; w++) {
							offsetdata.writeUnsignedInt(palette[data[offset]] | 0xFF000000);
							k++;
							offset++;
						}							
					}
					offsetdata.position = 0;
					break;
				case 4:
					tmp = new ByteArray();
					data.readBytes(tmp, 0, formats[i].colorCount  4);
					tmp.endian = Endian.LITTLE_ENDIAN;
					palette = new Array();						
					var d = 0;
					paletteBmp = new BitmapData(10formats[i].colorCount, 10, false, 0xFF000000);

					for(p = 0; p < formats[i].colorCount; p++){
						palette[p] = (tmp[d] << 16 | tmp[d+1]<<8 | tmp [d+2]);
						paletteBmp.fillRect(new Rectangle(p10, 0, 10, 10), palette[p]);
						d += 4;
					}
					offset = data.position;
					k = 0;
					
					for (h = 0; h < formats[i].height  formats[i].height/2; h++) {
							var c1 = (data[offset]& 0xF0) >> 4;
							var c2 = data[offset]& 0x0F;
							offsetdata.writeUnsignedInt(palette[c1] | 0xFF000000);
							offsetdata.writeUnsignedInt(palette[c2] | 0xFF000000);
							k++;
							offset++;
					}
					
					offsetdata.position = 0;
					break;
				case 1:
					new Error('not support');
					break;
			}
			offsetdata.position = 0;
			iconData = offsetdata;
			return iconData;
		}
		
        function LoadData(data:ByteArray) {           
            /*
             ICO header
            */		
			reserved 	= data.readUnsignedShort();
			type 		= data.readUnsignedShort();
			len  		= data.readUnsignedShort();
			
			for (var i = 0; i < len; i ++) {
				var icodata = new Object();
				icodata.width 			= data.readUnsignedByte();
				icodata.height 			= data.readUnsignedByte();
				icodata.colorCount 		= data.readUnsignedByte();
				icodata.reserved 		= data.readUnsignedByte();
				icodata.planes 			= data.readUnsignedShort();
				icodata.bitCount 		= data.readUnsignedShort();
				icodata.byteSize 		= data.readUnsignedInt();
				icodata.FileOffset 		= data.readUnsignedInt();
				
				if (icodata.colorCount == 0) icodata.colorCount = 256;				
				formats[i] = icodata;				
            }
            /*
              Extract aditional headers for each extracted icon header
             */
            dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}

*/