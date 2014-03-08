package SoundPackages
{
	import treefortress.sound.SoundAS;

	public class InsanitySound
	{
		public function InsanitySound()
		{
			loadSounds();
		}
		
		private function loadSounds():void
		{
			SoundAS.loadSound("sound/insanity/fastbreath.mp3","breath");
			SoundAS.loadSound("sound/insanity/heartbeat.mp3","heart");
			SoundAS.loadSound("sound/insanity/cultistchant.mp3","cultist");
		}
		
		public function playInsanitySounds(insanityLevel:int):void
		{
			switch(insanityLevel)
			{
				case 1:
					SoundAS.playLoop("breath", 1);
					break;
				case 2:
					SoundAS.playLoop("heart", 1);
					break;
				default:
					SoundAS.playLoop("cultist", 1);	
					break;
			}
		}
		
		public function stopInsanitySounds(insanityLevel:int):void
		{
			switch(insanityLevel)
			{
				case 1:
					SoundAS.pause("breath");
					break;
				case 2:
					SoundAS.pause("heart");
					break;
				default:
					SoundAS.pause("cultist");	
					break;
			}
		}
	}
}