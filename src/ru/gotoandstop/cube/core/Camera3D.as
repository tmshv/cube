package ru.gotoandstop.cube.core{
	import ru.gotoandstop.cube.display.ViewRectangle;
	import ru.gotoandstop.cube.geom.IVector3D;
	import ru.gotoandstop.cube.geom.Matrix3D;
	import ru.gotoandstop.cube.geom.Vector3D;
	
	public class Camera3D implements IVector3D{
		private var _x:Number;
		public function get x():Number{
			return this._x;
		}		
		public function set x(value:Number):void{
			this._x = value;
			this._position.x = value;
		}
		
		private var _y:Number;
		public function get y():Number{
			return this._y;
		}		
		public function set y(value:Number):void{
			this._y = value;
			this._position.y = value;
		}
		
		private var _z:Number;
		public function get z():Number{
			return this._z;
		}		
		public function set z(value:Number):void{
			this._z = value;
			this._position.z = value;
		}
		
		private var _fov:Number;
		public function get fov():Number{
			return this._fov;
		}		
		public function set fov(value:Number):void{
			this._fov = value;
		}
		
		private var _near:Number;
		public function get near():Number{
			return this._near;
		}
		public function set near(value:Number):void{
			this._near = value;
		}
		
		private var _far:Number;
		public function get far():Number{
			return this._far;
		}
		public function set far(value:Number):void{
			this._far = value;
		}
		
		private var _target:Vector3D;
		public function get target():Vector3D{
			return this._target;
		}
		public function set target(value:Vector3D):void{
			this._target = value;
		}
		
		private var _position:Vector3D;		
		public function get position():Vector3D{
			return this._position;
		}
		
		private var __up:Vector3D = new Vector3D(0, 1, 0);
		
		private const TO_RADIAN:Number = (Math.PI / 180);
		private const TO_DEGREE:Number = (180 / Math.PI);
		
		public function Camera3D(x:Number=0, y:Number=0, z:Number=0):void{
			this._x = x;
			this._y = y;
			this._z = z;
			this._fov = 90;
			this._near = 0;
			this._far = 1000;
			this._position = new Vector3D(x, y, z);
			this._target = new Vector3D();
		}		
		
		public function getDirection():Vector3D{
			var dir:Vector3D = new Vector3D(
				this._target.x - this._x,
				this._target.y - this._y,
				this._target.z - this._z
			);
			
			dir.normalize();
			return dir;
		}
		
		public function getViewMatrix():Matrix3D{
			var z_axis:Vector3D = this.getDirection();			
			var x_axis:Vector3D = this.__up.getCrossProduct(z_axis);
			x_axis.normalize();
			var y_axis:Vector3D = z_axis.getCrossProduct(x_axis);
			
			var m:Matrix3D = new Matrix3D(
				                   x_axis.x,                    y_axis.x,                    z_axis.x, 0,
				                   x_axis.y,                    y_axis.y,                    z_axis.y, 0,
				                   x_axis.z,                    y_axis.z,                    z_axis.z, 0,
				-this._position.dot(x_axis), -this._position.dot(y_axis), -this._position.dot(z_axis), 1
			);
			
			return m;
		}
		
		public function getProjectionMatrix(rect:ViewRectangle):Matrix3D{
			var hf:Number = this._fov * TO_RADIAN / 2;
			var sy:Number = Math.cos(hf) / Math.sin(hf);
			var sx:Number = sy * rect.aspectRatio;
			var sz:Number = this._far / (this._far - this._near);
			
			var m:Matrix3D = new Matrix3D(
				sx,  0,              0, 0,
				 0, sy,              0, 0,
				 0,  0,             sz, 1,
				 0,  0, -sz*this._near, 0
			);
			
			return m;
		}
		
		public function toString():String{
			return '[object Camera3D]';
		}
	}
}