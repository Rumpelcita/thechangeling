package WoodObjects
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class Floor extends Sprite
	{
		private var loader:Loader;
		
		public function Floor()
		{
			super();
			
			var url:String = "sprites/tiles-forest.png";
			
			trace("loading floor tile", url);
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCoplete);
			loader.load(new URLRequest(url));
		}
		
		protected function loadCoplete(event:Event):void
		{
			addChild(loader.getChildAt(0));
		}
	}
}