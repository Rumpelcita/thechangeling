package SoundPackages
{
	import treefortress.sound.SoundAS;

	public class WalkSound
	{
		public function WalkSound()
		{
			loadSounds();
		}
		
		public function loadSounds():void
		{
			SoundAS.loadSound("../assets/sound/steps/forest_walk.mp3","forest_walk");
			SoundAS.loadSound("../assets/sound/steps/house_walk.mp3", "town_walk");
			SoundAS.loadSound("../assets/sound/steps/underground_walk.mp3", "underground_walk");
		}
		
		public function playWalkSound(stage:String):void
		{
			switch(stage)
			{
				case "Town":
					SoundAS.playLoop("town_walk", 2);
					break;
				case "Labyrinth":
					SoundAS.playLoop("underground_walk", 2);
					break;
				default:
					SoundAS.playLoop("forest_walk", 2);	
					break;
			}
		}
		
		public function stopWalkSound(stage:String):void
		{
			switch(stage)
			{
				case "Town":
					SoundAS.pause("town_walk");
					break;
				case "Labyrinth":
					SoundAS.pause("underground_walk");
					break;
				default:
					SoundAS.pause("forest_walk");	
					break;
			}
		}
	}
}