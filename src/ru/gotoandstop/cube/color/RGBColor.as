package ru.gotoandstop.cube.color{
	public class RGBColor{
		private var _r:uint;
		public function get r():uint{
			return this._r;
		}		
		public function set r(value:uint):void{
			this._r = (value > 0xFF) ? 0xFF : (value < 0) ? 0 : value;
		}
		
		private var _g:uint;
		public function get g():uint{
			return this._g;
		}
		public function set g(value:uint):void{
			this._g = (value > 0xFF) ? 0xFF : (value < 0) ? 0 : value;
		}
		
		private var _b:uint;
		public function get b():uint{
			return this._b;
		}		
		public function set b(value:uint):void{
			_b = (value > 0xFF) ? 0xFF : (value < 0) ? 0 : value;
		}
				
		public function RGBColor(r:uint=0, g:uint=0, b:uint=0){
			this.r = r;
			this.g = g;
			this.b = b;
		}
		
		public static function hexColor(value:uint):RGBColor{
			var r:uint = value >> 16;
			var g:uint = value >> 8 & 0xFF;
			var b:uint = value & 0xFF;
			return new RGBColor(r, g, b);
		}
		
		public function get hex():uint{
			return this._r << 16 | this._g << 8 | this._b;
		}
		public function set hex(value:uint):void{
			this._r = value >> 16;
			this._g = value >> 8 & 0xFF;
			this._b = value & 0xFF;
		}
		
		public function clone():RGBColor{
			return new RGBColor(this._r, this._g, this._b);
		}
		
		public function toString():String{
			return (
				'r:' + this._r + ', ' +
				'g:' + this._g + ', ' +
				'b:' + this._b
			);
		}
	}
}