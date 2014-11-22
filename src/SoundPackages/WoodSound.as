package SoundPackages
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import kEngine.utils.Random;
	
	import treefortress.sound.SoundAS;
	

	public class WoodSound
	{
		
		private var keepPlaying:Boolean = false;
		
		public function WoodSound()
		{
			loadSounds();
		}
		
		public function playSound():void
		{
			keepPlaying = true;
			
			loadForestMusic();
			loadForestSound();	
		}
		
		public function stopSound():void
		{
			keepPlaying = false;
			
			SoundAS.stopAll();
		}
		
		private function loadForestMusic():void
		{
			SoundAS.playLoop("forestBg", 1);
		}
		
		private function loadForestSound():void
		{
			queueSound();
		}
		
		private function queueSound():void
		{
			if (keepPlaying === true)
			{
				var fxSound:int = Random.get(2500, 5000);
				setTimeout(playRandomSound, fxSound);
			}
		}
		
		private function loadSounds():void
		{
			SoundAS.loadSound("../assets/sound/forest/st-forest.mp3","forestBg");
						
			SoundAS.loadSound("../assets/sound/forest/batsflap.mp3", "batsflap" );
			SoundAS.loadSound("../assets/sound/forest/night_crickets.mp3", "crickets");
			SoundAS.loadSound("../assets/sound/forest/owl.mp3", "owl");
			SoundAS.loadSound("../assets/sound/forest/wolves_howl.mp3", "wolves");					
			
		}
		
		private function playRandomSound():void
		{
			var soundPick:int = Random.get(1,4);
			if (keepPlaying === true)
			{		
				switch(soundPick)
				{
					case 1:
						SoundAS.playFx("batsflap", 1);
						break;
					case 2:
						SoundAS.playFx("crickets", 1);
						break;
					case 3:
						SoundAS.playFx("owl", 1);
						break;
					default:
						SoundAS.playFx("wolves", 1);	
						break;
				}
				
				queueSound();
			}
		}
		
	}
}