package WoodObjects
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import kEngine.utils.Box;
	import kEngine.utils.Color;
	import kEngine.utils.Random;
	
	public class Tree extends Sprite
	{
		private var loader:Loader;

		private var b:Box;
		
		public function Tree()
		{
			super();
			
			var random:int = Random.get(1, 3);
			var url:String = "sprites/tree" + random.toString() + ".png";
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(new URLRequest(url));
		}
		
		protected function loadComplete(event:Event):void
		{
			loader.getChildAt(0).x = -loader.getChildAt(0).width/2;
			loader.getChildAt(0).y = -loader.getChildAt(0).height/4;
			
			b = new Box(loader.getChildAt(0).width/4, loader.getChildAt(0).height/4, Color.Red);
			
			b.x = -b.width;
			b.y = b.height;
			b.alpha = 0;
			
			addChild(b);
			
			addChild(loader.getChildAt(0));
		}
		
		public function getCollider():Box
		{
			return b;
		}
	}
}