package
{
	import flash.events.Event;
	
	import kEngine.views.View;
	import kEngine.views.ViewInterface;
	import kEngine.views.ViewManager;
	
	public class CreditsView extends View implements ViewInterface
	{
		
		private var credits:DialogShower;
		
		public function CreditsView()
		{
			super("Credits");
			
			credits = new DialogShower();
			credits.addEventListener(DialogShower.END_DIALOG, finishIt);
			addChild(credits);
		}
		
		protected function finishIt(event:Event):void
		{
			ViewManager.getInstance().goTo("Woods");
		}
		
		public override function start():void
		{
			credits.setText("credits");
		}
	}
}