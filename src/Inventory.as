package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Inventory extends Sprite
	{
		public static var WATCH_DOLL:String = "WATCH_DOLL";
		public static var WATCH_KNIFE:String = "WATCH_KNIFE";
		public static var WATCH_BOOK:String = "WATCH_BOOK";
		public static var READ_BOOK:String = "READ_BOOK";
		
		private var doll:MovieClip;
		private var knife:Sprite;
		private var book:Sprite;
		
		private var canReadBook:Boolean;
		
		public function Inventory()
		{
			super();
			doll = new DollBig();
			doll.x = 10;
			doll.y = 30;
			doll.scaleX = 0.75;
			doll.scaleY = 0.75;
			
			knife = new KnifeBig();
			knife.x = doll.width + 40;
			knife.y = 40;
			knife.scaleX = 0.75;
			knife.scaleY = 0.75;
			
			book = new BookBig();
			book.x = knife.x + 30 + knife.width;
			book.y = 10;
			book.scaleX = 0.75;
			book.scaleY = 0.75;
			
			canReadBook = false;
			
			doll.addEventListener(MouseEvent.CLICK, showDollInfo);
			knife.addEventListener(MouseEvent.CLICK, showKnifeInfo);
			book.addEventListener(MouseEvent.CLICK, showBookInfo);
		}
		
		public function readBook():void
		{
			canReadBook = true;
			showBookInfo(null);
		}
		
		protected function showBookInfo(event:MouseEvent):void
		{
			if(!canReadBook)
				dispatchEvent(new Event(WATCH_BOOK));
			else
				dispatchEvent(new Event(READ_BOOK));
		}
		
		protected function showKnifeInfo(event:MouseEvent):void
		{
			dispatchEvent(new Event(WATCH_KNIFE));
		}
		
		protected function showDollInfo(event:MouseEvent):void
		{
			dispatchEvent(new Event(WATCH_DOLL));
		}
		
		public function add(item:String):void
		{
			switch(item)
			{
				case "doll":
				{
					addChild(doll);
					break;
				}
					
				case "knife":
				{
					addChild(knife);
					break;
				}
					
				case "book":
				{
					addChild(book);
					break;
				}
			}
		}
		
		public function hasBook():Boolean
		{
			return contains(book);
		}
		
		public function readBookEnabe():void
		{
			canReadBook = true;
		}
		
		public function setDollStatus(i:int):void
		{
			//doll.gotoAndStop(i);
		}
	}
}