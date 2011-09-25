package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import ru.gotoandstop.click.bug.Bug;
	import ru.gotoandstop.click.bug.History;
	import ru.gotoandstop.click.bug.Performance;
	import ru.gotoandstop.cube.core.Camera3D;
	import ru.gotoandstop.cube.core.Geometry3D;
	import ru.gotoandstop.cube.core.Light3D;
	import ru.gotoandstop.cube.core.Object3D;
	import ru.gotoandstop.cube.core.Scene3D;
	import ru.gotoandstop.cube.core.Vertex3D;
	import ru.gotoandstop.cube.display.ShadingType;
	import ru.gotoandstop.cube.display.Viewport;
	import ru.gotoandstop.cube.events.RenderEvent;
	
	[SWF(width=800, height=600, backgroundColor=0x000000, frameRate=31)]
	
	public class capital extends Sprite{
		public function capital(){
			super();
			super.stage.align = StageAlign.TOP_LEFT;
			super.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var capital:Object3D = this.getCapital(50, 20, -40);
			capital.shadingType = ShadingType.FLAT;
			capital.color.hex = 0xffefe7;
			
			var camera:Camera3D = new Camera3D(0, 0, 100);
			camera.target = capital.position;
			
			var scene:Scene3D = new Scene3D();
			scene.addChild(capital);
			scene.camera = camera;
			scene.ambientLight.hex = 0x474a5b;
			
			var light:Light3D = scene.directionalLight;
			light.color.hex = 0xa7ccdb;
			light.z = -0.7;
			
			var angle:Number = 0;
			super.addEventListener(Event.ENTER_FRAME, function(event:Event):void{
				var cos:Number = Math.cos(angle);
				var sin:Number = Math.sin(angle);
				angle += .1;////.025;
				
				capital.rotationY ++;
				//capital.rotationX = cos*5;
				
				light.x = sin;
			});
			
			var viewport:Viewport = new Viewport(scene, 800, 600);
			super.addChild(viewport);
			viewport.start();
			
			super.addChild(Bug.instance);
			Bug.panel(new Performance(50000));
			Bug.panel(new History(400, 'poly', 'drawnpoly'));
			
			viewport.processing.addEventListener(RenderEvent.DRAWN_COMPLETE, function(event:RenderEvent):void{
				(Bug.panel('drawnpoly') as History).add(event.numDrawnPolygons);
			});
		}
		
		private function getCapital(modul:Number, segments:uint=10, offset:Number=0):Object3D{
			var obj:Object3D = new Object3D();
			var geom:Geometry3D = obj.geometry;
			var v_down:Vertex3D = geom.addVertex(new Vertex3D(0, offset, 0));
			var delta:Number = modul * 0.11;
			var modul_delta_plus:Number = modul + delta;
			var modul_delta_minus:Number = modul - delta;
			var half:Number = modul_delta_plus / 2;
			var delta_half:Number  = delta  / 2;
			var height:Number;
			var radius:Number;
			var circle:Array;
			var circle_prev:Array;
			var i:uint;
			var loop_length:uint;
			var angle:Number;
			var angle_step:Number;
			var circle_center:Number;
			var cos:Number;
			var sin:Number;
			
			height = offset;
			radius = modul;
			circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
			
			height += half - delta_half;
			//radius const
			circle_prev = circle;
			circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
			
			this.join(geom, circle_prev, circle);
			
			//height const;
			radius += delta_half;
			circle_prev = circle;
			circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
			
			this.join(geom, circle_prev, circle);
			
			height += delta_half;
			//radius const;
			circle_prev = circle;
			circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
			
			this.join(geom, circle_prev, circle);
			
			loop_length = 4;//4
			angle = Math.PI + Math.PI/2;
			angle_step = Math.PI / loop_length;
			circle_center = height + delta_half;//offset + half+ delta_half;
			for(i=0; i<loop_length; i++){
				angle += angle_step;
				
				cos = Math.cos(angle);
				sin = Math.sin(angle);
				
				height = circle_center + sin*delta_half;
				radius = modul+delta_half + cos*delta_half;
				circle_prev = circle;
				circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
				
				this.join(geom, circle_prev, circle);
			}
			
			//height const
			radius -= delta_half;
			circle_prev = circle;
			circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
				
			this.join(geom, circle_prev, circle);
			
			height += delta * 3;
			//radius const
			circle_prev = circle;
			circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
				
			this.join(geom, circle_prev, circle);
			
			loop_length = 3;
			angle = 0;
			angle_step = 0.5*Math.PI / loop_length;
			circle_center = height;
			for(i=0; i<loop_length; i++){
				angle += angle_step;
				
				cos = Math.cos(angle);
				sin = Math.sin(angle);
				
				height = circle_center + sin*delta;
				radius = modul + (1-cos)*delta;
				circle_prev = circle;
				circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
				
				this.join(geom, circle_prev, circle);
			}
			
			height += delta;
			//radius const
			circle_prev = circle;
			circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
			
			this.join(geom, circle_prev, circle);
			
			loop_length = 4;
			angle = Math.PI + Math.PI/2;
			angle_step = 0.5*Math.PI / loop_length;
			circle_center = height + (half - delta*3);
			for(i=0; i<loop_length; i++){
				angle += angle_step;
				
				cos = Math.cos(angle);
				sin = Math.sin(angle);
				
				height = circle_center + sin*(half-delta*3);
				radius = modul+delta + cos*(half-delta*3);
				circle_prev = circle;
				circle = this.getCircle(geom, radius, segments, new Vertex3D(0, height, 0));
				
				this.join(geom, circle_prev, circle);
			}
			
			var w:Number = radius + delta_half;
			var h:Number = half-delta*3;
			
			//height const
			//radius += delta_half;
			//circle_prev = circle;
			//circle = this.getCircle(geom, radius, 4, new Vertex3D(0, height, 0));
			
			//this.join(geom, circle_prev, circle);
						
//			var block:Object3D = Primitive.box(w*2, h, w*2);
//			loop_length = block.geometry.vertices.length;
//			for(i=0; i<loop_length; i++){
//				var v:Vertex3D = block.geometry.vertices[i] as Vertex3D;
//				v.y += height + h;
//				geom.addVertex(v);
//			}
//			
//			loop_length = block.geometry.faces.length;
//			for(i=0; i<loop_length; i++) geom.faces.push(block.geometry.faces[i]);
			
			return obj;
		}
		
		private function getCircle(geom:Geometry3D, radius:Number, num:Number, center:Vertex3D):Array{
			var list:Array = new Array();
			var angle:Number = 0;
			var angle_step:Number = 2*Math.PI / num;
			for(var i:uint; i<num; i++){
				var cos:Number = Math.cos(angle);
				var sin:Number = Math.sin(angle);
				var vertex:Vertex3D = new Vertex3D(
					center.x + cos*radius,
					center.y,
					center.z + sin*radius);
				list.push(vertex);
				geom.addVertex(vertex);
				angle += angle_step;
			}
			return list;
		}
		
		private function join(geom:Geometry3D, list1:Array, list2:Array):void{
			var length:uint = Math.min(list1.length, list2.length);
			for(var i:uint; i<length; i++){
				var v1:Vertex3D = list1[i];
				var v2:Vertex3D = list2[i];
				var v3:Vertex3D = list1[(i+1)%length];
				var v4:Vertex3D = list2[(i+1)%length];
				geom.addPlane(v1, v2, v4, v3);
			}
		}
	}
}