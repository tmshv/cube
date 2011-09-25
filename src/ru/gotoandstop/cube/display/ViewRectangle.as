package ru.gotoandstop.cube.display{
	import flash.geom.Rectangle;
	
	import ru.gotoandstop.cube.geom.IVector3D;
	
	public class ViewRectangle extends Rectangle{
		private var _aspectRatio:Number;
		public function get aspectRatio():Number{
			return this._aspectRatio;
		}
		
		public function ViewRectangle(x:Number=0, y:Number=0, width:Number=640, height:Number=480):void{
			super(x, y, width, height);
			this.calculateAspectRatio();
		}
		
		public function calculateAspectRatio():void{
			this._aspectRatio = super.height / super.width;
			this._aspectRatio = (this._aspectRatio > 0) ? this._aspectRatio : 0;
		}
		
		public function intersectsTriangle(v1:IVector3D, v2:IVector3D, v3:IVector3D):Boolean{
			var minX:Number = (v1.x < v2.x) ? v1.x : v2.x;
			minX = (minX < v3.x) ? minX : v3.x;
			var maxX:Number = (v1.x > v2.x) ? v1.x : v2.x;
			maxX = (maxX > v3.x) ? maxX : v3.x;
			
			var minY:Number = (v1.y < v2.y) ? v1.y : v2.y;
			minY = (minY < v3.y) ? minY : v3.y;
			var maxY:Number = (v1.y > v2.y) ? v1.y : v2.y;
			maxY = (maxY > v3.y) ? maxY : v3.y;
			
			return super.contains(minX, minY) || super.contains(maxX, minY) || super.contains(minX, maxY) || super.contains(maxX, maxY);
		}
		
		public override function toString():String{
			return '[object ViewRectangle]';
		}
	}
}