package WoodObjects
{
	import flash.display.Sprite;
	import flash.ui.Keyboard;

	public class FloorGenerator extends Sprite
	{
		private var floorTile:Floor;
		
		public function FloorGenerator()
		{
			floorTile = new Floor();
			addChild(floorTile);
		}
		
		public function move(xMovement:int, yMovement:int):void
		{
			this.y += yMovement;
			this.x += xMovement;
			
			checkTilePosition();
		}
		
		private function checkTilePosition():void
		{
			if(this.x > 0)
			{
				this.x -= 548;
			}
			
			if(this.x < -548)
			{
				this.x += 548;
			}
			
			if(this.y > 0)
			{
				this.y -= 548;
			}
			
			if(this.y < -548)
			{
				this.y += 548;
			}
		}
	}
}