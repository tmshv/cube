package ru.gotoandstop.cube.core{
	import ru.gotoandstop.cube.geom.IVector3D;
	import ru.gotoandstop.cube.geom.Vector3D;
	
	public class Vertex3D implements IVector3D{
		private var _x:Number;
		public function get x():Number{
			return this._x;
		}
		public function set x(value:Number):void{
			this._x = value;
		}
		
		private var _y:Number;
		public function get y():Number{
			return this._y;
		}
		public function set y(value:Number):void{
			this._y = value;
		}
		
		private var _z:Number;
		public function get z():Number{
			return this._z;
		}
		public function set z(value:Number):void{
			this._z = value;
		}
		
		public function Vertex3D(x:Number=0, y:Number=0, z:Number=0){
			this._x = x;
			this._y = y;
			this._z = z;
		}
		
		public function clone():Vertex3D{
			return new Vertex3D(this._x, this._y, this._z);
		}
		
		public function toString():String{
			return (
				'x:' + this._x + ', ',
				'y:' + this._y + ', ',
				'z:' + this._z
			);
		}
	}
}