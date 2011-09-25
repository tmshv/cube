package ru.gotoandstop.click.bug{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getTimer;
	
	public class Performance extends Sprite{
		private var __bitmap:BitmapData;
		private var __text:TextField;
		private var __total:uint;
		private var __top:uint;
		private var __frame:uint;
		private var __currentFPS:uint;
		
		public function Performance(top:uint=102400, name:String='', active:Boolean=true){
			super.name = name;
			this.__top = top;
			this.__bitmap = new BitmapData(130, 75, true, 0xA8000010);
			super.addChild(new Bitmap(this.__bitmap));
			
			this.__text = new TextField();
			this.__text.selectable = false;
			this.__text.defaultTextFormat = new TextFormat('_typewriter', 10, 0xAAAABB);
			super.addChild(this.__text);
			
			var g:Graphics = super.graphics;
			g.lineStyle(1, 0xEEEEFF, 0.3, false, 'noramal', CapsStyle.SQUARE, JointStyle.MITER);
			g.drawRect(-.5, -.5, 131, 76);
			
			var item:ContextMenuItem = new ContextMenuItem('hide');
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.handlerHideSelect);
			var menu:ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			menu.customItems.push(item);
			super.contextMenu = menu;
			
			if(active) this.activate();
		}
		
		public function activate():void{
			super.addEventListener(Event.ENTER_FRAME, this.handlerEnterFrame);
			super.addEventListener(MouseEvent.MOUSE_DOWN, this.handlerMouseDown);
			super.addEventListener(MouseEvent.MOUSE_UP, this.handlerMouseUp);
		}
		
		public function deacrivate():void{
			super.removeEventListener(Event.ENTER_FRAME, this.handlerEnterFrame);
			super.removeEventListener(MouseEvent.MOUSE_DOWN, this.handlerMouseDown);
			super.removeEventListener(MouseEvent.MOUSE_UP, this.handlerMouseUp);
		}
		
		public function clear():void{
			this.__bitmap.fillRect(this.__bitmap.rect, 0xA8000010);
		}
		
		private function handlerEnterFrame(event:Event):void{
			var previous_elapsed_sec:uint = this.__total/1000;
			this.__total = getTimer();			
			var current_elapsed_sec:uint = this.__total/1000;
			var color:uint = (current_elapsed_sec>previous_elapsed_sec) ? 0xFFFF6666 : 0x54EEEEFF;
			var memory_kb:uint = System.totalMemory/1024;
			var display_memory:uint = 75 - (memory_kb/this.__top*75);
			if(current_elapsed_sec>previous_elapsed_sec){
				this.__currentFPS = this.__frame;
				this.__frame = 0;
			}
			this.__frame ++;
			this.__bitmap.scroll(-1, 0);
			this.__bitmap.setPixel32(128, display_memory, color);
			this.__text.text = this.__currentFPS+' fps\n'+memory_kb+' kb\n'+current_elapsed_sec+' sec';
		}
		
		private function handlerMouseDown(event:MouseEvent):void{
			this.__bitmap.setPixel32(super.mouseX, super.mouseY, 0xFFffff00);
			super.startDrag();
		}
		
		private function handlerMouseUp(event:MouseEvent):void{
			super.stopDrag();
		}
		
		private function handlerHideSelect(event:ContextMenuEvent):void{
			this.deacrivate();
			super.visible = false;
			
			/*var item:ContextMenuItem = new ContextMenuItem('show performance', true);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.handlerShowSelect);
			var menu:ContextMenu = super.parent.contextMenu;
			if(!menu){
				menu = new ContextMenu();
				super.parent.contextMenu = menu;
			}
			menu.customItems.push(item);*/
		}
		
		/*private function handlerShowSelect(event:ContextMenuEvent):void{
			var item:ContextMenuItem = event.target as ContextMenuItem;
			item.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.handlerShowSelect);
			
			this.activate();
			super.visible = true;
		}*/
	}
}