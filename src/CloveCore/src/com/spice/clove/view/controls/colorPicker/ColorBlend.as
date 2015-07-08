package com.spice.clove.view.controls.colorPicker
{
    import flash.display.*;
    import flash.geom.*;
    
    import mx.controls.Alert;

    public class ColorBlend extends Object
    {
        public var bmp:BitmapData;
        private var matrix:Matrix;
        private var colorTransform:ColorTransform;
        private var bmpB:BitmapData;
        public var bmp_end:BitmapData;
        private var bmpA:BitmapData;
        public var end_rgb:Number;
        public var start_rgb:Number;
        private var Blend:Array;

        public function ColorBlend(param1:Array) : void
        {
            Blend = param1;
            bmpA = new BitmapData(1, 1, true);
            bmpB = new BitmapData(1, 1, true);
            matrix = new Matrix();
            colorTransform = new ColorTransform();
            return;
        }// end function

        private function _blendedRGB(param1:Number, param2:Number, param3:Number) : Number
        {
            bmpA.setPixel(0, 0, param2);
            bmpB.setPixel(0, 0, param3);
            colorTransform.alphaMultiplier = param1;
            bmpA.draw(bmpB, matrix, colorTransform);
            return bmpA.getPixel32(0, 0);
        }// end function

        public function getArrayOfLength(param1:Number) : Array
        {
            var _loc_2:Array;
            var _loc_3:uint;
            _loc_2 = new Array();
            _loc_3 = 0;
            while (_loc_3++ <= param1)
            {
                // label
                _loc_2.push(getBlendedPoint(param1, _loc_3));
            }// end while
            return _loc_2;
        }// end function

        public function getRGBAt(param1:Number) : Number
        {
            bmp.setPixel(0, 0, start_rgb);
            bmp_end.setPixel(0, 0, end_rgb);
            colorTransform.alphaMultiplier = param1;
            bmp.draw(bmp_end, matrix, colorTransform);
            return bmp.getPixel32(0, 0);
        }// end function

        public function getArraysOfLength(param1:Number, param2:uint = 1) : Array
        {
        	
            var _loc_3:Array;
            var _loc_4:Array;
            var _loc_5:Array;
            var _loc_6:Array;
            var _loc_7:Array;
            var _loc_8:Boolean;
            var _loc_9:uint;
            var _loc_10:uint;
            var _loc_11:uint;
            var _loc_12:uint;
            var _loc_13:uint;
            var _loc_14:uint;
            var _loc_15:uint;
            _loc_3 = new Array();
            _loc_4 = new Array();
            _loc_5 = new Array();
            _loc_6 = new Array();
            _loc_7 = new Array();
            _loc_8 = param2 == 1;
            _loc_9 = 0;
            _loc_10 = 0;
            while (_loc_10 < param1)
            {
                // label
                if (++_loc_9 >= param2)
                {
                    _loc_8 = true;
                    _loc_9 = 0;
                }
                else
                {
                    _loc_8 = false;
                }// end else if
                _loc_11 = getBlendedPoint(param1, _loc_10);
                _loc_12 = _loc_11 >> 24 & 255;
                _loc_13 = _loc_11 >> 16 & 255;
                _loc_14 = _loc_11 >> 8 & 255;
                _loc_15 = _loc_11 & 255;
                _loc_4.push(Number("0x00" + _loc_13.toString(16) + "0000"));
                _loc_5.push(Number("0x0000" + _loc_14.toString(16) + "00"));
                _loc_6.push(Number("0x000000" + _loc_15.toString(16)));
                _loc_7.push(_loc_12);
                _loc_10 = _loc_10 + (_loc_8 ? (param2) : (0));
            }// end while
            _loc_3.push(_loc_4);
            _loc_3.push(_loc_5);
            _loc_3.push(_loc_6);
            _loc_3.push(_loc_7);
            return _loc_3;
        }// end function

        public function getBlendedPoint(param1:Number, param2:Number) : Number
        {
            var _loc_3:Number;
            var _loc_4:Number;
            var _loc_5:Number;
            _loc_3 = Math.ceil(param1 / Blend.length--);
            _loc_4 = Math.floor(param2 / _loc_3);
            _loc_5 = (param2 - _loc_4 * _loc_3) / _loc_3;
            return _blendedRGB(_loc_5, Blend[_loc_4], Blend[_loc_4 + 1]);
        }// end function

    }
}
