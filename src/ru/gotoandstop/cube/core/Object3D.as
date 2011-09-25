package ru.gotoandstop.cube.core{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	
	import ru.gotoandstop.cube.color.RGBColor;
	import ru.gotoandstop.cube.display.ShadingType;
	import ru.gotoandstop.cube.geom.IVector3D;
	import ru.gotoandstop.cube.geom.Matrix3D;
	import ru.gotoandstop.cube.geom.Vector3D;
	
	public class Object3D extends EventDispatcher implements IVector3D{
	//x
		private var _x:Number = 0;
		public function get x():Number{
			return _x;
		}
		public function set x(value:Number):void{
			_x = _position.x = value;
		}
		
	//y
		private var _y:Number = 0;
		public function get y():Number{
			return _y;
		}
		public function set y(value:Number):void{
			_y = _position.y = value;
		}
		
	//z
		private var _z:Number = 0;
		public function get z():Number{
			return _z;
		}
		public function set z(value:Number):void{
			_z = _position.z = value;
		}
		
	//scale
		private var _scale:Number = 1;
		public function get scale():Number{
			return _scale;
		}
		public function set scale(value:Number):void{
			_scale = _scaleX = _scaleY = _scaleZ = value;
		}
		
	//scaleX	
		private var _scaleX:Number = 1;
		public function get scaleX():Number{
			return _scaleX;
		}
		public function set scaleX(value:Number):void{
			_scaleX = value;
		}
		
	//scaleY
		private var _scaleY:Number = 1;
		public function get scaleY():Number{
			return _scaleY;
		}
		public function set scaleY(value:Number):void{
			_scaleY = value;
		}
	
	//scaleZ	
		private var _scaleZ:Number = 1;
		public function get scaleZ():Number{
			return _scaleZ;
		}
		public function set scaleZ(value:Number):void{
			_scaleZ = value;
		}
		
	//rotationX
		private var _rotationX:Number = 0;
		public function get rotationX():Number{
			return _rotationX;
		}
		public function set rotationX(value:Number):void{
			_rotationX = (value > 180) ? value - 360 : (value <= -180) ? value + 360 : value;
		}
		
	//rotationY
		private var _rotationY:Number = 0;
		public function get rotationY():Number{
			return _rotationY;
		}
		public function set rotationY(value:Number):void{
			_rotationY = (value > 180) ? value - 360 : (value <= -180) ? value + 360 : value;
		}
		
	//rotationZ
		private var _rotationZ:Number = 0;
		public function get rotationZ():Number{
			return _rotationZ;
		}
		public function set rotationZ(value:Number):void{
			_rotationZ = (value > 180) ? value - 360 : (value <= -180) ? value + 360 : value;
		}
		
	//visible
		private var _visible:Boolean = true;
		public function get visible():Boolean{
			return _visible;
		}
		public function set visible(value:Boolean):void{
			_visible = value;
		}
		
	//doubleSide
		private var _doubleSide:Boolean = false;
		public function get doubleSide():Boolean{
			return _doubleSide;
		}
		public function set doubleSide(value:Boolean):void{
			this._doubleSide = value;
		}
		
	//position
		private var _position:Vector3D;
		public function get position():Vector3D{
			return _position;
		}
		
	//color
		private var _color:RGBColor;
		public function get color():RGBColor{
			return _color;
		}
		public function set color(value:RGBColor):void{
			_color = value;
		}
		
	//shadingType
		private var _shadingType:String = ShadingType.NONE;
		public function get shadingType():String{
			return _shadingType;
		}
		public function set shadingType(value:String):void{
			_shadingType = value;
		}
		
	//transformMatrix
		private var _transformMatrix:Matrix3D;
		public function get transformMatrix():Matrix3D{
			_transformMatrix.identity();
			_transformMatrix.scale(scaleX, scaleY, scaleZ);
			_transformMatrix.rotate(rotationX*TO_RADIAN, rotationY*TO_RADIAN, rotationZ*TO_RADIAN);
			_transformMatrix.translate(x, y, z);
			return _transformMatrix;
		}
		
		private var _geometry:Geometry3D;
		public function get geometry():Geometry3D{
			return this._geometry;
		}
		public function set geometry(value:Geometry3D):void{
			this._geometry = value;
		}
		
	//name
		private var _name:String;
		public function get name():String{
			return this._name;
		}		
		public function set name(value:String):void{
			this._name = value;
		}
		
		protected const TO_RADIAN:Number = (Math.PI / 180);
		protected const TO_DEGREE:Number = (180 / Math.PI);
	
		public function Object3D(){
			this._geometry = new Geometry3D(this);
			_position = new Vector3D();
			_transformMatrix = new Matrix3D();
			_color = new RGBColor(255, 255, 255);
		}
	}
}