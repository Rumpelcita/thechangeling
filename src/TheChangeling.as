package
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import kEngine.views.ViewManager;
	
	[SWF(width="800", height="600", backgroundColor="0x000000")]
	
	public class TheChangeling extends Sprite
	{
		public function TheChangeling()
		{
			ViewManager.getInstance().setup(stage, 800, 600);
			ViewManager.getInstance().add(new WoodsView());
			ViewManager.getInstance().goTo("Woods");
			
			ViewManager.getInstance().addEventListener(Event.EXIT_FRAME, update);
			
			Key.addListeners(stage);
		}
		
		protected function update(event:Event):void
		{
			ViewManager.getInstance().update();
		}
	}
}