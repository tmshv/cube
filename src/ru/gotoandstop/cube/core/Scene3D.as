package ru.gotoandstop.cube.core{
	import flash.utils.Dictionary;
	
	import ru.gotoandstop.cube.color.RGBColor;
	
	public class Scene3D{
		private var _children:Dictionary;
		public function get children():Dictionary{
			return this._children;
		}
		
		private var _camera:Camera3D;
		public function get camera():Camera3D{
			return this._camera;
		}
		public function set camera(value:Camera3D):void{
			this._camera = value;
		}
		
		private var _directionalLight:Light3D;
		public function get directionalLight():Light3D{
			return this._directionalLight;
		}
		public function set directionalLight(value:Light3D):void{
			this._directionalLight = value;
		}
		
		private var _ambientLight:RGBColor;
		public function get ambientLight():RGBColor{
			return this._ambientLight;
		}
		public function set ambientLight(value:RGBColor):void{
			this._ambientLight = value;
		}
		
		private var _numChildren:uint;
		public function get numChildren():uint{
			return this._numChildren;
		}
		
		private var _numVertices:uint;
		public function get numVertices():uint{
			return this._numVertices;
		}
		
		private var _numPolygons:uint;
		public function get numPolygon():uint{
			return this._numPolygons;
		}
		
		public function Scene3D(){
			this._children = new Dictionary();
			this._directionalLight = new Light3D(new RGBColor(0xFF, 0xFF, 0xFF), 0, -1, 0);
			this._ambientLight = new RGBColor(0, 0, 0);
		}
		
		public function addChild(child:Object3D):Object3D{
			this._children[child] = child;
			this.adjustChildren();
			return child;
		}
		
		public function removeChild(child:Object3D):Object3D{
			if(this._children[child] != null) delete this._children[child];
			else throw new ArgumentError('Error #2025: Предоставленный Object3D должен быть дочерним элементом вызывающего объекта.');
			this.adjustChildren();
			return child;
		}
		
		public function removeAllChildren():Array{
			this._numChildren = 0;
			this._numVertices = 0;
			this._numPolygons = 0;
			var temp:Array = [];
			for each(var child:Object3D in this._children){
				delete this._children[child];
				temp.push(child);
			}
			return temp;
		}
		
		private function adjustChildren():void{
			this._numChildren = 0;
			this._numVertices = 0;
			this._numPolygons = 0;
			for each(var child:Object3D in this._children){
				this._numChildren ++;
				this._numVertices += child.geometry.vertices.length;
				this._numPolygons += child.geometry.faces.length;
			}
		}
	}
}