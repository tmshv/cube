package ru.gotoandstop.cube.geom{
	public class Vector3D implements IVector3D{
	//x
		private var _x:Number;
		public function get x():Number{
			return this._x;
		}
		public function set x(value:Number):void{
			this._x = value;
		}
		
	//y
		private var _y:Number;
		public function get y():Number{
			return this._y;
		}
		public function set y(value:Number):void{
			this._y = value;
		}
	
	//z	
		private var _z:Number;
		public function get z():Number{
			return this._z;
		}		
		public function set z(value:Number):void{
			this._z = value;
		}
		
	//Vector3D
		public function Vector3D(x:Number=0, y:Number=0, z:Number=0){
			this._x = x;
			this._y = y;
			this._z = z;
		}
		
		public function normalize():void{
			var length:Number = Math.sqrt(this._x * this._x + this._y * this._y + this._z * this._z);
			if(length!=0 && length!=1){
				this._x /= length;
				this._y /= length;
				this._z /= length;
			}
		}
		
		public function invert():void{
			this._x *= -1;
			this._y *= -1;
			this._z *= -1;
		}
		
		public function length():Number{
			return Math.sqrt(this._x*this._x + this._y*this._y + this._z*this._z);
		}
		
		public function distance(v:IVector3D):Number{
			var dx:Number = this._x - v.x;
			var dy:Number = this._y - v.y;
			var dz:Number = this._z - v.z;
			return Math.sqrt(dx*dx + dy*dy + dz*dz);
		}
		
		public function add(v:IVector3D):void{
			this._x += v.x;
			this._y += v.y;
			this._z += v.z;
		}
		
		public function getAddition(v:IVector3D):Vector3D{
			return new Vector3D(
				this._x + v.x,
				this._y + v.y,
				this._z + v.z
			);
		}
		
		public function sub(v:IVector3D):void{
			this._x -= v.x;
			this._y -= v.y;
			this._z -= v.z;
		}
		
		public function getSubtraction(v:IVector3D):Vector3D{
			return new Vector3D(
				this._x - v.x,
				this._y - v.y,
				this._z - v.z
			);
		}
		
		public function cross(v:IVector3D):void{
			var tx:Number = this._x;
			var ty:Number = this._y;
			var tz:Number = this._z;			
			x = ty*v.z - tz*v.y;
			y = tz*v.x - tx*v.z;
			z = tx*v.y - ty*v.x;
		}
		
		public function getCrossProduct(v:IVector3D):Vector3D{
			return new Vector3D(
				this._y*v.z - this._z*v.y,
				this._z*v.x - this._x*v.z,
				this._x*v.y - this._y*v.x
			);
		}
		
		public function dot(v:IVector3D):Number{
			return this._x*v.x + this._y*v.y + this._z*v.z;
		}
		
		public function clone():Vector3D{
			return new Vector3D(this._x, this._y, this._z);
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