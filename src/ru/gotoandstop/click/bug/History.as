package ru.gotoandstop.click.bug{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class History extends Sprite{
		private var __bitmap:BitmapData;
		private var __text:TextField;
		private var __max:Number;
		private var __fillRect:Rectangle;
		private var __message:String;
		public function History(max:Number, message:String, name:String='', active:Boolean=true){
			super.name = name;
			this.__max = max;
			this.__message = message;
			this.__fillRect = new Rectangle(198, 0, 1, 0);
			this.__bitmap = new BitmapData(200, 75, true, 0xA8000010);
			var b:Bitmap = super.addChild(new Bitmap(this.__bitmap)) as Bitmap;
			this.__text = super.addChild(new TextField()) as TextField;
			this.__text.selectable = false;
			this.__text.width = 200;
			this.__text.height = 75;
			this.__text.defaultTextFormat = new TextFormat('_typewriter', 10, 0xAAAABB);
			this.__text.text = this.__message +': ';
			var g:Graphics = super.graphics;
			g.lineStyle(1, 0xEEEEFF, 0.3, false, 'noramal', CapsStyle.SQUARE, JointStyle.MITER);
			g.drawRect(-.5, -.5, 201, 76);
			if(active) this.activate();
		}
		
		public function activate():void{
			super.addEventListener(MouseEvent.MOUSE_DOWN, this.handlerMouseDown);
			super.addEventListener(MouseEvent.MOUSE_UP, this.handlerMouseUp);
		}
		
		public function deactivate():void{
			super.removeEventListener(MouseEvent.MOUSE_DOWN, this.handlerMouseDown);
			super.removeEventListener(MouseEvent.MOUSE_UP, this.handlerMouseUp);
		}
		
		public function add(value:Number):void{
			var ratio:uint = value * (75/this.__max);
			if(ratio){
				this.__fillRect.y = 75-ratio;
				this.__fillRect.height = ratio;
				this.__bitmap.scroll(-1, 0);
				this.__bitmap.fillRect(this.__fillRect, 0x54EEEEFF);
				this.__text.text = this.__message +': '+value.toString();
			}
		}
		
		private function handlerMouseDown(event:MouseEvent):void{
			super.startDrag();
		}
		private function handlerMouseUp(event:MouseEvent):void{
			super.stopDrag();
		}
	}
}