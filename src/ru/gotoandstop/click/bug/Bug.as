package ru.gotoandstop.click.bug{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Bug extends Sprite{
		private static var __init:Boolean;
		private static var _instance:Bug;
		public static function get instance():Bug{
			if(!Bug.__init){
				Bug._instance = new Bug();
				Bug.__init = true;
			}
			return Bug._instance;			
		}
		public static function panel(arg:*):DisplayObject{
			var result:DisplayObject;
			if(arg is String) result = Bug._instance.getChildByName(arg);
			else if(arg is DisplayObject){
				result = Bug._instance.addChild(arg);
				result.addEventListener(MouseEvent.MOUSE_DOWN, Bug._instance.handlerMouseDown);
				Bug._instance.expose(result);
			}
			return result;
		}
		
		public function Bug(){
			super();
			if(Bug.__init) throw new Error('Use Bug.panel');
		}
		
		private function expose(obj:DisplayObject):void{
			var limit:uint = super.getChildIndex(obj);
			for(var i:uint; i<limit; i++){
				obj.y = 2;
				obj.x += super.getChildAt(i).width + 2;
			}
		}
		
		private function handlerMouseDown(event:MouseEvent):void{
			var current:DisplayObject = event.currentTarget as DisplayObject;
			var upper_index:uint = super.numChildren-1;
			var current_index:uint = super.getChildIndex(current);
			super.swapChildrenAt(upper_index, current_index);
		}
	}
}