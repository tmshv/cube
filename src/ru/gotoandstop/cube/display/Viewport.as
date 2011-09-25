package ru.gotoandstop.cube.display{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ru.gotoandstop.cube.core.Processing;
	import ru.gotoandstop.cube.core.Scene3D;
	import ru.gotoandstop.cube.events.RenderEvent;
	
	public class Viewport extends Sprite{
		private var _processing:Processing;
		public function get processing():Processing{
			return this._processing;
		}
		
		private var _rect:ViewRectangle;
		public function get rectangle():ViewRectangle{
			return this._rect;
		}
		
		private var _scene:Scene3D;
		public function get scene():Scene3D{
			return this._scene;
		}
		public function set scene(value:Scene3D):void{
			this._scene = value;
			this._processing.scene = value;
		}
		
		public function Viewport(scene:Scene3D, width:Number, height:Number):void{
			this._rect = new ViewRectangle(0, 0, width, height);
			this._scene = scene;
			
			this._processing = new Processing(this, this._rect, this._scene);
		}
		
		public function start():void{
			super.addEventListener(Event.ENTER_FRAME, this.handlerEnterFrame);
		}
		
		public function stop():void{
			super.removeEventListener(Event.ENTER_FRAME, this.handlerEnterFrame);
		}
		
		private function handlerEnterFrame(event:Event):void{
			this._processing.clear();
			this._processing.draw();
		}
	}
}