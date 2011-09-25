package ru.gotoandstop.cube.core{
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import ru.gotoandstop.cube.color.RGBColor;
	import ru.gotoandstop.cube.display.ShadingType;
	import ru.gotoandstop.cube.display.ViewRectangle;
	import ru.gotoandstop.cube.events.RenderEvent;
	import ru.gotoandstop.cube.geom.Matrix3D;
	import ru.gotoandstop.cube.geom.Vector3D;
	
	public class Processing extends EventDispatcher{
		private var _scene:Scene3D;
		public function get scene():Scene3D{
			return this._scene;
		}
		public function set scene(value:Scene3D):void{
			this._scene = value;
			
			this.__camera = value.camera;
			this.__directionalLight = value.directionalLight;
			this.__ambientLight = value.ambientLight;
		}
		
		//props of scene
		private var __camera:Camera3D;
		private var __rect:ViewRectangle;
		private var __directionalLight:Light3D;
		private var __ambientLight:RGBColor;
		
		//raport
		private var __numDrawnPolygons:uint;
		private var __numCulledPolygons:uint;
		
		//canvas
		private var __canvas:Graphics;
		private var __shadeCanvas:Graphics;
		
		private var __vertices:Dictionary;		
		private var __eye:Vector3D;
		
		private var __masterMatrix:Matrix3D;
		private var __cameraMatrix:Matrix3D;
				
		private var __va:Vector3D;
		private var __vb:Vector3D;
		
		private const NUMERIC:uint = Array.NUMERIC;
		private const DESCENDING:uint = Array.DESCENDING;
		
		public function Processing(canvas:Sprite, rect:ViewRectangle, scene:Scene3D):void{
			var container:Shape = canvas.addChild(new Shape()) as Shape;
			this.__canvas = container.graphics;
			
			container = canvas.addChild(new Shape()) as Shape;
			container.blendMode = BlendMode.MULTIPLY;
			this.__shadeCanvas = container.graphics;
			
			this.scene = scene;
			this.__rect = rect;
			this.__eye = new Vector3D(0, 0, 1);
			this.__masterMatrix = new Matrix3D();
			this.__cameraMatrix = new Matrix3D();
			this.__va = new Vector3D();
			this.__vb = new Vector3D();
		}
		
		public function clear():void{
			this.__numDrawnPolygons = 0;
			this.__numCulledPolygons = 0;
			this.__canvas.clear();
			this.__shadeCanvas.clear();
		}
		
		public function draw():void{
			var children:Dictionary = this._scene.children;
			this.__vertices = new Dictionary();
			this.__cameraMatrix.identity();
			this.__cameraMatrix.multiply(this.__camera.getViewMatrix());
			this.__cameraMatrix.multiply(this.__camera.getProjectionMatrix(this.__rect));
			
			var face_list:Array = new Array();
			for each(var obj:Object3D in children){
				if(obj.visible){
					switch(obj.shadingType){
						default:
						case ShadingType.NONE:{
							this.transform(obj);
							break;
						}
						
						case ShadingType.FLAT:{
							this.transformAndLight(obj);
							break;
						}
					}		
					face_list = face_list.concat(obj.geometry.faces);
				}
			}
			
			var triangle_list:Array = new Array();
			for each(var face:Face3D in face_list){
				if(face.object.visible){
					var v1:ScreenVertex3D = this.__vertices[face.v1];
					var v2:ScreenVertex3D = this.__vertices[face.v2];
					var v3:ScreenVertex3D = this.__vertices[face.v3];
					
					var z:Number = (v1.z > v2.z) ? v1.z : v2.z;
					z = (z > v3.z) ? z : v3.z;
					
					triangle_list.push(new Triangle(v1, v2, v3, z, face));
				}
			}
			triangle_list.sortOn('z', NUMERIC | DESCENDING);
			for each (var triangle:Triangle in triangle_list) this.drawTriangle(triangle);
			
			super.dispatchEvent(new RenderEvent(
				RenderEvent.DRAWN_COMPLETE,
				false,
				false,
				this.__numDrawnPolygons,
				this.__numCulledPolygons
			));
		}
		
		private function transform(primitive:Object3D):void{
			this.__masterMatrix.identity();
			this.__masterMatrix.multiply(primitive.transformMatrix);
			this.__masterMatrix.multiply(this.__cameraMatrix);
			
			this.iterateVertices(primitive);
		}
		
		private function transformAndLight(primitive:Object3D):void{
			this.__masterMatrix.identity();
			this.__masterMatrix.multiply(primitive.transformMatrix);
			
			var invertMatrix:Matrix3D = this.__masterMatrix.clone();
			invertMatrix.invert();
			
			var light:Vector3D = invertMatrix.transform(this.__directionalLight);
			light.invert();
			light.normalize();
			
			if(primitive.shadingType == ShadingType.FLAT){
				var a_r:uint = this.__ambientLight.r;
				var a_g:uint = this.__ambientLight.g;
				var a_b:uint = this.__ambientLight.b;
				var d_r:uint = this.__directionalLight.color.r;
				var d_g:uint = this.__directionalLight.color.g;
				var d_b:uint = this.__directionalLight.color.b;
				var face_list:Array = primitive.geometry.faces;
				
				for each (var face:Face3D in face_list){
					var w:Number = face.normal.dot(light);
					if(w < 0) w = 0;
					
					face.color.r = a_r + d_r * w;
					face.color.g = a_g + d_g * w;
					face.color.b = a_b + d_b * w;
				}
			}
			
			this.__masterMatrix.multiply(this.__cameraMatrix);
			this.iterateVertices(primitive);
		}
		
		private function iterateVertices(primitive:Object3D):void{
			var vx:Number = this.__rect.x;
			var vy:Number = this.__rect.y;
			var hw:Number = this.__rect.width / 2;
			var hh:Number = this.__rect.height / 2;
			var vertex_list:Array = primitive.geometry.vertices;
			
			for each (var vertex:Vertex3D in vertex_list){
				var v:Vector3D = this.__masterMatrix.transform(vertex);
				this.__vertices[vertex] = new ScreenVertex3D(
					 v.x / v.z * hw + vx + hw,
					-v.y / v.z * hh + vy + hh,
					v.z,
					(v.z >= this.__camera.near && v.z <= this.__camera.far) ? true : false
				);
			}
		}
		
		private function drawTriangle(triangle:Triangle):void{
			var v1:ScreenVertex3D = triangle.v1;
			var v2:ScreenVertex3D = triangle.v2;
			var v3:ScreenVertex3D = triangle.v3;
			var face:Face3D = triangle.face;
			var object:Object3D = face.object;
			
			this.__va.x = v1.x - v2.x; this.__va.y = v1.y - v2.y; this.__va.z = v1.z - v2.z;
			this.__vb.x = v1.x - v3.x; this.__vb.y = v1.y - v3.y; this.__vb.z = v1.z - v3.z;
			this.__va.cross(this.__vb);
			this.__va.normalize();
			
			var is_visible:Boolean = v1.visible && v2.visible && v3.visible;
			var is_intersects:Boolean = this.__va.dot(this.__eye)>0 && this.__rect.intersectsTriangle(v1, v2, v3);
			if(is_visible && (face.object.doubleSide ? true : is_intersects)){
				this.applyColor(v1, v2, v3, object.color);
				if(object.shadingType == ShadingType.FLAT) this.applyFlatShading(v1, v2, v3, face.color);
				this.__numDrawnPolygons ++;
			}
			
			else this.__numCulledPolygons ++;
		}
		
		private function applyColor(v1:ScreenVertex3D, v2:ScreenVertex3D, v3:ScreenVertex3D, color:RGBColor):void{
			this.__canvas.beginFill(color.hex);
			//this.__canvas.lineStyle(0, 0xFFFFFF);
			this.__canvas.moveTo(v1.x, v1.y);
			this.__canvas.lineTo(v2.x, v2.y);
			this.__canvas.lineTo(v3.x, v3.y);
			this.__canvas.lineTo(v1.x, v1.y);
			this.__canvas.endFill();
		}
		
		private function applyFlatShading(v1:ScreenVertex3D, v2:ScreenVertex3D, v3:ScreenVertex3D, color:RGBColor):void{
			this.__shadeCanvas.beginFill(color.hex);
			this.__shadeCanvas.moveTo(v1.x, v1.y);
			this.__shadeCanvas.lineTo(v2.x, v2.y);
			this.__shadeCanvas.lineTo(v3.x, v3.y);
			this.__shadeCanvas.lineTo(v1.x, v1.y);
			this.__shadeCanvas.endFill();
		}
	}
}

import ru.gotoandstop.cube.core.Object3D;
import ru.gotoandstop.cube.core.Face3D;
import ru.gotoandstop.cube.core.Vertex3D;

internal class Triangle{
	public var v1:ScreenVertex3D;
	public var v2:ScreenVertex3D;
	public var v3:ScreenVertex3D;
	public var z:Number;	
	public var face:Face3D;
	public function Triangle(v1:ScreenVertex3D, v2:ScreenVertex3D, v3:ScreenVertex3D, z:Number, face:Face3D){
		this.v1 = v1;
		this.v2 = v2;
		this.v3 = v3;
		this.z = z;
		this.face = face;
	}
}

internal class ScreenVertex3D extends Vertex3D{
	public var visible:Boolean;
	public function ScreenVertex3D(x:Number=0, y:Number=0, z:Number=0, visible:Boolean=false):void{
		this.x = x;
		this.y = y;
		this.z = z;
		this.visible = visible;
	}
}