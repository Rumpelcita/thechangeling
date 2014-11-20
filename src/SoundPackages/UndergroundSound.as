package SoundPackages
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import kEngine.utils.Random;
	
	import treefortress.sound.SoundAS;
	
	
	public class UndergroundSound
	{
		
		private var keepPlaying:Boolean = false;
		
		public function UndergroundSound()
		{
			loadSounds();
		}
		
		public function playSound():void
		{
			keepPlaying = true;
			
			loadUndergroundMusic();
			loadUndergroundSound();	
		}
		
		public function playFinalMusic():void
		{
			keepPlaying = false;
			
			SoundAS.stopAll();
			SoundAS.playLoop("portal");			
		}
		
		public function playEvilSound():void
		{
			SoundAS.playFx("final_laugh");
		}
		
		public function stopSound():void
		{
			keepPlaying = false;
			
			SoundAS.stopAll();
		}
		
		public function playUndergroundWalk():void
		{
			SoundAS.playFx("undergroundWalk", 1);	
		}
		
		private function loadUndergroundMusic():void
		{
			SoundAS.playLoop("undergroundBg", 1);
		}
		
		private function loadUndergroundSound():void
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
			SoundAS.loadSound("../assets/sound/underground/underground_bg.mp3","undergroundBg");
					
			SoundAS.loadSound("../assets/sound/underground/evil_laugh.mp3", "evil_laugh" );
			SoundAS.loadSound("../assets/sound/underground/batcave.mp3", "batcave");
			SoundAS.loadSound("../assets/sound/underground/waterdrops.mp3", "waterdrops");
			
			SoundAS.loadSound("../assets/sound/underground/portal.mp3", "portal");
			SoundAS.loadSound("../assets/sound/underground/finallaugh.mp3", "final_laugh");
			
		}
		
		private function playRandomSound():void
		{
			var soundPick:int = Random.get(1,3);
			
			if (keepPlaying === true)
				{		
				switch(soundPick)
				{
					case 1:
						SoundAS.playFx("evil_laugh", 1);
						break;
					case 2:
						SoundAS.playFx("batcave", 1);
						break;
					default:
						SoundAS.playFx("waterdrops", 1);	
						break;
				}
				
				queueSound();
			}
		}	
	}
}