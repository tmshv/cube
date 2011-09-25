package ru.gotoandstop.cube.core{
	import ru.gotoandstop.cube.color.RGBColor;
	import ru.gotoandstop.cube.geom.Vector3D;
	
	public class Light3D extends Vector3D{
		private var _color:RGBColor;
		public function get color():RGBColor{
			return this._color;
		}
		public function set color(value:RGBColor):void{
			this._color = value;
		}
		
		public function Light3D(color:RGBColor, x:Number=0, y:Number=0, z:Number=0){
			super(x, y, z);
			this._color = color;
		}
				
		public override function toString():String{
			return '[object Light3D]';
		}
	}
}