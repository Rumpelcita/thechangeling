package
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class RunesPuzzle extends Runes
	{
		//luna cthullu corazon nada
		
		private var moonC:Boolean;
		private var heartC:Boolean;
		private var nothingC:Boolean;
		private var cthullutC:Boolean;

		public static var OPEN_PORTAL:String = "OPEN_PORTAL";
		
		public function RunesPuzzle()
		{
			super();
			
			this.moon.addEventListener(MouseEvent.CLICK, moonClicked);
			this.heart.addEventListener(MouseEvent.CLICK, heartClicked);
			this.nothing.addEventListener(MouseEvent.CLICK, nothingClicked);
			this.cthullu.addEventListener(MouseEvent.CLICK, cthulluClicked);
			
			this.addEventListener(Event.ADDED_TO_STAGE, addeD);
		}
		
		protected function addeD(event:Event):void
		{
			moonC = false;
			heartC = false;
			nothingC = false;
			cthullutC = false;
		}
		
		protected function cthulluClicked(event:MouseEvent):void
		{
			if(moonC && !heartC && !nothingC)
			{
				cthullutC = true;//luna cthullu corazon nada
			}
			else
			{
				moonC = false;
				heartC = false;
				nothingC = false;
				cthullutC = false;
			}
		}
		
		protected function nothingClicked(event:MouseEvent):void
		{
			if(moonC && heartC && cthullutC)
			{
				nothingC = true;//luna cthullu corazon nada
				
				dispatchEvent(new Event(OPEN_PORTAL));
			}
			else
			{
				moonC = false;
				heartC = false;
				nothingC = false;
				cthullutC = false;
			}
		}
		
		protected function heartClicked(event:MouseEvent):void
		{
			if(moonC && cthullutC && !nothingC)
			{
				heartC = true;//luna cthullu corazon nada
			}
			else
			{
				moonC = false;
				heartC = false;
				nothingC = false;
				cthullutC = false;
			}
		}
		
		protected function moonClicked(event:MouseEvent):void
		{
			if(!cthullutC && !heartC && !nothingC)
			{
				moonC = true;//luna cthullu corazon nada
			}
			else
			{
				moonC = true;
				heartC = false;
				nothingC = false;
				cthullutC = false;
			}
		}
	}
}