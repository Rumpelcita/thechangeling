package SoundPackages
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import kEngine.utils.Random;
	
	import treefortress.sound.SoundAS;
	
	
	public class TownSound
	{
		
		private var keepPlaying:Boolean = false;
		
		public function TownSound()
		{
			loadSounds();
		}
		
		public function playSound():void
		{
			keepPlaying = true;
			
			loadTownMusic();
			loadTownSound();	
		}
			
		public function stopSound():void
		{
			keepPlaying = false;
			
			SoundAS.stopAll();
		}
		
		public function playTownWalk():void
		{
			SoundAS.playFx("town_walk", 1);	
		}
		
		private function loadTownMusic():void
		{
			SoundAS.playLoop("townBg", 1);
		}
		
		private function loadTownSound():void
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
			SoundAS.loadSound("../assets/sound/town/townbg.mp3","townBg");
						
			SoundAS.loadSound("../assets/sound/town/rathouse.mp3", "rat" );			
		}
		
		private function playRandomSound():void
		{
			if (keepPlaying === true)
			{
				SoundAS.playFx("rat", 1);
				
				queueSound();
			}
		}	
	}
}