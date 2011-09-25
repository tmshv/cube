package ru.gotoandstop.cube.core{
	import ru.gotoandstop.cube.color.RGBColor;
	import ru.gotoandstop.cube.geom.Vector3D;
	
	public class Face3D{
		public function get v1():Vertex3D{
			return this._vertices[0];
		}
		public function get v2():Vertex3D{
			return this._vertices[1];
		}
		public function get v3():Vertex3D{
			return this._vertices[2];
		}
		
		private var _vertices:Array;
		public function get vertices():Array{
			return this._vertices;
		}
		public function set vertices(value:Array):void{
			this._vertices = value;
		}
		
		private var _normal:Vector3D;
		public function get normal():Vector3D{
			return this._normal;
		}
		
		private var _object:Object3D;
		public function get object():Object3D{
			return this._object;
		}
		
		private var _color:RGBColor;
		internal function get color():RGBColor{
			return this._color
		}
		internal function set color(value:RGBColor):void{
			this._color = value;
		}
		
		public function Face3D(object:Object3D, v1:Vertex3D, v2:Vertex3D, v3:Vertex3D, normal:Vector3D){
			this._object = object;
			this._vertices = new Array();
			this._vertices.push(v1);
			this._vertices.push(v2);
			this._vertices.push(v3);
			this._normal = normal;
			this._color = new RGBColor();
		}
		
		public function flip():void{
			var v:Vertex3D = this.v2;
			this._vertices[1] = v3;
			this._vertices[2] = v;
		}
		
		public function clone():Face3D{
			return new Face3D(this._object, this.v1, this.v2, this.v3, this.normal);
		}
		
		public function toString():String{
			return '[object Surface3D]';
		}
	}
}