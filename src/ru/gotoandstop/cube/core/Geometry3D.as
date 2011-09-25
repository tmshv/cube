package ru.gotoandstop.cube.core{
	import flash.events.EventDispatcher;
	
	import ru.gotoandstop.cube.geom.Vector3D;
	
	public class Geometry3D extends EventDispatcher{
		private var _va:Vector3D;
		private var _vb:Vector3D;
		
		private var _object:Object3D;
		public function get object():Object3D{
			return this._object;
		}
		
		//массив, содержащий точки
		private var _vertices:Array;
		public function get vertices():Array{
			return this._vertices;
		}
		
		//массив, содержащий грани
		private var _faces:Array;
		public function get faces():Array{
			return this._faces;
		}
		
		public function Geometry3D(obj:Object3D){
			super();
			this._object = obj;
			this._vertices = new Array();
			this._faces = new Array();
			this._va = new Vector3D();
			this._vb = new Vector3D();
		}
		
		//добавляет точку в массив
		public function addVertex(v:Vertex3D):Vertex3D{
			this._vertices.push(v);
			return v;
		}
		
		public function getVertexAt(index:int):Vertex3D{
			return this._vertices[index];
		}
		
		public function getFaceAt(index:int):Face3D{
			return this._faces[index];
		}
		
		public function flip():void{
			for each(var face:Face3D in this._faces) face.flip();
		}
		
		public function addFace(v1:Vertex3D, v2:Vertex3D, v3:Vertex3D, flip:Boolean=false):Face3D{
			_va.x = v1.x - v2.x;
			_va.y = v1.y - v2.y;
			_va.z = v1.z - v2.z;
			_vb.x = v1.x - v3.x;
			_vb.y = v1.y - v3.y;
			_vb.z = v1.z - v3.z;
			_va.cross(_vb);
			_va.normalize();
			var face:Face3D = new Face3D(this._object, v1, v2, v3, _va.clone());
			if(flip) face.flip();
			this._faces.push(face);
			return face;
		}
		
		public function addPlane(v1:Vertex3D, v2:Vertex3D, v3:Vertex3D, v4:Vertex3D, flip:Boolean=false):Array{
			var f1:Face3D = this.addFace(v1, v2, v3);
			var f2:Face3D = this.addFace(v1, v3, v4);
			if(flip){
				f1.flip();
				f2.flip();
			}
			return [f1, f2];
		}
	}
}