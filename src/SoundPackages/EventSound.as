package SoundPackages
{
	import treefortress.sound.SoundAS;

	public class EventSound
	{
		public function EventSound()
		{
			loadSounds();
		}
		
		private function loadSounds():void
		{
			SoundAS.loadSound("sound/event/trunk.mp3","trunk");
			SoundAS.loadSound("sound/event/book.mp3","book");
			SoundAS.loadSound("sound/event/knife.mp3","knife");
		}
		
		public function playEventSounds(event:int):void
		{
			switch(event)
			{
				case 1:
					SoundAS.playFx("trunk", 1);
					break;
				case 2:
					SoundAS.playFx("book", 1);
					break;
				default:
					SoundAS.playFx("knife", 1);	
					break;
			}
		}
		
		public function stopInsanitySounds(insanityLevel:int):void
		{
			switch(insanityLevel)
			{
				case 1:
					SoundAS.pause("trunk");
					break;
				case 2:
					SoundAS.pause("book");
					break;
				default:
					SoundAS.pause("knife");	
					break;
			}
		}
	}
}