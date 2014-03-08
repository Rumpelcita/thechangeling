package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class FinalDecitions extends Sprite
	{
		private var opt1:TextDisplay;
		private var opt2:TextDisplay;
		private var opt3:TextDisplay;

		public static var FINAL_ONE:String = "FINAL_ONE";
		public static var FINAL_TWO:String = "FINAL_TWO";
		public static var FINAL_THREE:String = "FINAL_THREE";
		
		public function FinalDecitions()
		{
			super();
			
			opt1 = new TextDisplay();
			opt2 = new TextDisplay();
			opt3 = new TextDisplay();
			
			opt1.text.text = "Kill.";
			opt2.text.text = "Go with the girl.";
			opt3.text.text = "Enter the portal.";
			
			opt1.x = 400;
			opt1.y = 400;
			opt2.x = 400;
			opt2.y = 450;
			opt3.x = 400;
			opt3.y = 500;
			
			opt1.addEventListener(MouseEvent.CLICK, choseOne);
			opt2.addEventListener(MouseEvent.CLICK, choseTwo);
			opt3.addEventListener(MouseEvent.CLICK, choseThree);
			
			addChild(opt1);
			addChild(opt2);
			addChild(opt3);
		}
		
		protected function choseThree(event:MouseEvent):void
		{
			removeOPtions();	
			dispatchEvent(new Event(FINAL_ONE));
		}
		
		private function removeOPtions():void
		{
			removeChild(opt1);
			removeChild(opt2);
			removeChild(opt3);
		}
		
		protected function choseTwo(event:MouseEvent):void
		{
			removeOPtions();	
			dispatchEvent(new Event(FINAL_TWO));
		}
		
		protected function choseOne(event:MouseEvent):void
		{
			removeOPtions();	
			dispatchEvent(new Event(FINAL_THREE));
		}
	}
}