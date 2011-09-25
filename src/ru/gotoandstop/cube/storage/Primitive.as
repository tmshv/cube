package ru.gotoandstop.cube.storage{
	import ru.gotoandstop.cube.core.Geometry3D;
	import ru.gotoandstop.cube.core.Object3D;
	import ru.gotoandstop.cube.core.Vertex3D;
	
	public class Primitive{
		//куб
		public static function cube(width:Number, name:String=''):Object3D{
			var obj:Object3D = new Object3D();
			obj.name = name;
			var geom:Geometry3D = obj.geometry;
			width /= 2;
			
			geom.addVertex(new Vertex3D( width, -width,  width));
			geom.addVertex(new Vertex3D( width,  width,  width));
			geom.addVertex(new Vertex3D( width,  width, -width));
			geom.addVertex(new Vertex3D( width, -width, -width));
			geom.addVertex(new Vertex3D(-width, -width, -width));
			geom.addVertex(new Vertex3D(-width,  width, -width));
			geom.addVertex(new Vertex3D(-width,  width,  width));
			geom.addVertex(new Vertex3D(-width, -width,  width));
			
			var v:Array = geom.vertices;
			geom.addPlane(v[0], v[1], v[2], v[3], true);
			geom.addPlane(v[4], v[5], v[6], v[7], true);
			geom.addPlane(v[1], v[2], v[5], v[6]);
			geom.addPlane(v[0], v[1], v[6], v[7]);
			geom.addPlane(v[3], v[4], v[7], v[0], true);
			geom.addPlane(v[5], v[4], v[3], v[2], true);
			
			return obj;
		}
		
		//параллелипипед
		public static function box(width:Number, height:Number, length:Number, name:String=''):Object3D{
			var obj:Object3D = new Object3D();
			obj.name = name;
			var geom:Geometry3D = obj.geometry;
			width /= 2;
			height /= 2;
			length /= 2;
			
			geom.addVertex(new Vertex3D( width, -height,  length));
			geom.addVertex(new Vertex3D( width,  height,  length));
			geom.addVertex(new Vertex3D( width,  height, -length));
			geom.addVertex(new Vertex3D( width, -height, -length));
			geom.addVertex(new Vertex3D(-width, -height, -length));
			geom.addVertex(new Vertex3D(-width,  height, -length));
			geom.addVertex(new Vertex3D(-width,  height,  length));
			geom.addVertex(new Vertex3D(-width, -height,  length));
			
			var v:Array = geom.vertices;
			geom.addPlane(v[0], v[1], v[2], v[3], true);
			geom.addPlane(v[4], v[5], v[6], v[7], true);
			geom.addPlane(v[1], v[2], v[5], v[6]);
			geom.addPlane(v[0], v[1], v[6], v[7]);
			geom.addPlane(v[3], v[4], v[7], v[0], true);
			geom.addPlane(v[5], v[4], v[3], v[2], true);
			
			return obj;
		}
		
		//полигон
		public static function plane(width:Number, height:Number, name:String=''):Object3D{
			var obj:Object3D = new Object3D();
			obj.name = name;
			var geom:Geometry3D = obj.geometry;
			width /= 2;
			height /= 2;
			
			var g:Array = geom.vertices;
			geom.addVertex(new Vertex3D(-width, 0,  height));
			geom.addVertex(new Vertex3D( width, 0,  height));
			geom.addVertex(new Vertex3D( width, 0, -height));
			geom.addVertex(new Vertex3D(-width, 0, -height));
			geom.addPlane(g[0], g[1], g[2], g[3]);
			
			return obj;
		}
		
		//цилиндр
		public static function barrel(radius:Number, height:Number, segments:uint=10, centerOffset:Vertex3D=null, name:String=''):Object3D{
			if(!centerOffset) centerOffset = new Vertex3D();
			
			var obj:Object3D = new Object3D();
			obj.name = name;
			var geom:Geometry3D = obj.geometry;
			var v:Array = geom.vertices;
			
			geom.addVertex(new Vertex3D(centerOffset.x, height+centerOffset.y, centerOffset.z));
			geom.addVertex(new Vertex3D(centerOffset.x,        centerOffset.y, centerOffset.z));
			
			var angle:Number = 0;
			var step:Number = 4*Math.PI / segments;
			var i:uint;
			for(i=0; i<segments; ++i, angle+=step){
				var x:Number = centerOffset.x + Math.cos(angle) * radius;
				var z:Number = centerOffset.z + Math.sin(angle) * radius;
				geom.addVertex(new Vertex3D(x, centerOffset.y       , z));
				geom.addVertex(new Vertex3D(x, centerOffset.y+height, z));
			}
			
			var v_up:Vertex3D = v[0];
			var v_down:Vertex3D = v[1];
			for(i=0; i<segments; i+=2){
				var v1:Vertex3D = v[i              + 2];
				var v2:Vertex3D = v[i+1            + 2];
				var v3:Vertex3D = v[(i+2)%segments + 2];
				var v4:Vertex3D = v[(i+3)%segments + 2];
				geom.addPlane(v1, v2, v4, v3);
				geom.addFace(v_down, v1, v3);
				geom.addFace(v_up, v2, v4, true);
			}
			
			return obj;
		}
		
		//public static function truncatedCone():Object3D
		
		public static function cone(radius:Number, height:Number, segments:uint=10, name:String=''):Object3D{
			var obj:Object3D = new Object3D();
			obj.name = name;
			var geom:Geometry3D = obj.geometry;
			
			geom.vertices.push(new Vertex3D(0, height, 0));
			geom.vertices.push(new Vertex3D(0,      0, 0));
			
			var angle:Number = 0;
			var step:Number = 2*Math.PI / segments;
			var i:uint;
			for(i=0; i<segments; ++i, angle+=step){
				var cos:Number = Math.cos(angle);
				var sin:Number = Math.sin(angle);
				
				geom.vertices.push(new Vertex3D(
					cos * radius,
					0,
					sin * radius
				));
			}
			
			var v_up:Vertex3D = geom.vertices[0];
			var v_down:Vertex3D = geom.vertices[1];
			for(i=0; i<segments; ++i){
				var v1:Vertex3D = geom.vertices[(i + 1) % segments + 2];
				var v2:Vertex3D = geom.vertices[i + 2];
				geom.addFace(v_up, v1, v2);
				geom.addFace(v2, v1, v_down);
			}
			
			return obj;
		}
		
		public static function torus(innerRadius:Number, outerRadius:Number, segments:int=10, rings:int=10, name:String=''):Object3D{
			var obj:Object3D = new Object3D();
			obj.name = name;
			var geom:Geometry3D = obj.geometry;
			
			var a:Number = 0;
			var adda:Number = Math.PI * 2 / rings;
			
			var c:Number = 0;
			var addc:Number = Math.PI * 2 / segments;
			
			var i:int;
			var j:int;
			for(i=0; i<segments; ++i, c+=addc){
				var s:Number = Math.sin(c);
				var z:Number = Math.cos(c) * innerRadius;
				var scale:Number = s * innerRadius + outerRadius;
				
				for(j=0; j<rings; ++j, a+=adda){
					var ca:Number = Math.cos(a);
					var sa:Number = Math.sin(a);
					geom.vertices.push(new Vertex3D(
						ca * scale,
						sa * scale,
						z
					));
				}
			}
			
			var n:int = segments * rings;
			for(i=0; i<segments; ++i){
				var off:Number = i * rings;
				for(j=0; j<rings; ++j){
					var v1:Vertex3D = geom.vertices[(off + rings) % n + (j + 1) % rings];
					var v2:Vertex3D = geom.vertices[off + (j + 1) % rings];
					var v3:Vertex3D = geom.vertices[off + j];
					var v4:Vertex3D = geom.vertices[(off + rings) % n + j];
					geom.addFace(v1, v2, v3);
					geom.addFace(v1, v3, v4);
				}
			}
			return obj;
		}
	}
}