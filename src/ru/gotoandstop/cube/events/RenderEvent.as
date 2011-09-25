package ru.gotoandstop.cube.events{
	import flash.events.Event;
	
	public class RenderEvent extends Event{
		public static const DRAWN_COMPLETE:String = 'drawnComplete';
		
		private var _numDrawnPolygons:uint;
		public function get numDrawnPolygons():uint{
			return this._numDrawnPolygons;
		}
		
		private var _numCulledPolygons:uint;
		public function get numCulledPolygons():uint{
			return this._numCulledPolygons;
		}
		
		public function RenderEvent(
			type:String,
			bubbles:Boolean=false,
			cancelable:Boolean=false,
			numDrawnPolygons:uint=0,
			numCulledPolygons:uint=0
		):void{
			super(type, bubbles, cancelable);
			
			this._numDrawnPolygons = numDrawnPolygons;
			this._numCulledPolygons = numCulledPolygons;
		}
	}
}