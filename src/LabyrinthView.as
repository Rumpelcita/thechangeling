package
{
	import LabyrinthObjects.TiledMazeGen;
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	
	import kEngine.views.View;
	import kEngine.views.ViewInterface;
	
	public class LabyrinthView extends View implements ViewInterface
	{
		private const TOPCAMERASPEED:int = 5;
		
		private var currentCameraSpeed:int;
		private var xMovement:int;
		private var yMovement:int;
		
		private var playerCanMove:Boolean;
		
		private var laby:TiledMazeGen;
		private var player:Player;
		
		public function LabyrinthView()
		{
			super("Labyrinth");
		}
		
		public override function prepare():void
		{
			laby = new TiledMazeGen(15, 15);
			addChild(laby);
			
			player = new Player();
			player.x = 120;
			player.y = 100;
			addChild(player);
			
			playerCanMove = true;
		}
		
		public override function update():void
		{			
			
			
			if(playerCanMove)
			{
				xMovement = 0;
				yMovement = 0;
				
				if(Key.isDown(Keyboard.W) || Key.isDown(Keyboard.A) || Key.isDown(Keyboard.S) || Key.isDown(Keyboard.D))
				{
					currentCameraSpeed++;
					if(currentCameraSpeed > TOPCAMERASPEED)
						currentCameraSpeed = TOPCAMERASPEED
				}
				else
				{
					currentCameraSpeed--;
					if(currentCameraSpeed < 0)
						currentCameraSpeed = 0;
				}
				
				if(Key.isDown(Keyboard.W))
				{
					yMovement += currentCameraSpeed;
					
				}
				if(Key.isDown(Keyboard.A))
				{
					xMovement += currentCameraSpeed;
				}
				if(Key.isDown(Keyboard.S))
				{
					yMovement -= currentCameraSpeed;
				}
				if(Key.isDown(Keyboard.D))
				{
					xMovement -= currentCameraSpeed;
				}
				
				var movePlayerX:Boolean = false;
				
				if(!playerCenteredX()) // && !canMoveMapX(xMovement)
				{
					movePlayerX = true;
				}
				
				if(movePlayerX)
				{
					player.x += xMovement * -1;
					
					if(playerIsColliding())
					{
						player.x -= xMovement * -1;
					}
				}
				else
				{
					laby.x += xMovement;
					
					if(laby.x < -(laby.width - 400))
						laby.x = -(laby.width - 400);
					if(laby.x > 400)
						laby.x = 400;
					
					
					if(playerIsColliding())
					{
						laby.x -= xMovement;
					}
				}
				
				
				/////////////
				
				
				var movePlayerY:Boolean = false;
				
				if(!playerCenteredY()) // && !canMoveMapY(yMovement)
				{
					movePlayerY = true;
				}
				
				if(movePlayerY)
				{
					player.y += yMovement * -1;
					
					if(playerIsColliding())
					{
						player.y -= yMovement * -1;
					}
				}
				else
				{
					laby.y += yMovement;
					
					if(laby.y < -(laby.height - 300))
						laby.y = -(laby.height - 300);
					if(laby.y > 300)
						laby.y = 300;
					
					
					if(playerIsColliding())
					{
						laby.y -= yMovement;
					}
				}
			}
		}
		
		private function canMoveMapY(direction:int):Boolean
		{
			if(laby.y+direction < -(laby.height - 300))
				return false;
			if(laby.y+direction > 300)
				return false;
			return true;
		}
		
		private function playerCenteredY():Boolean
		{
			if(player.y != 600/2)
				return false;
			return true;
		}
		
		private function canMoveMapX(direction:int):Boolean
		{
			if(laby.x+direction < -(laby.width - 400))
				return false;
			if(laby.x+direction > 400)
				return false;
			return true;
		}
		
		private function playerCenteredX():Boolean
		{
			if(player.x != 800/2)
				return false;
			return true;
		}
		
		private function playerIsColliding():Boolean
		{
			for each(var t:MovieClip in laby.getTiles())
			{
				if(t.toString() == "[object DungeonEnd]" && t.hitTestObject(player.getHitBox()))
				{
					playerCanMove = false;
					showFinalDialogue();
					return false;
				}
				else
				if(t.toString() != "[object DungeonFloor]" && t.toString() != "[object DungeonStart]" && t.hitTestObject(player.getHitBox()))
				{
					return true;
				}
			}
			
			return false;
		}
		
		private function showFinalDialogue():void
		{
			
		}
	}
}