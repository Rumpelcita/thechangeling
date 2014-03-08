package
{
	
	import SoundPackages.WoodSound;
	
	import WoodObjects.Floor;
	import WoodObjects.FloorGenerator;
	import WoodObjects.Tree;
	import WoodObjects.TreeGenerator;
	
	import flash.media.Camera;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	
	import kEngine.utils.Box;
	import kEngine.utils.Color;
	import kEngine.utils.MultiArray;
	import kEngine.views.View;
	import kEngine.views.ViewInterface;
	import kEngine.views.ViewManager;
	
	public class WoodsView extends View implements ViewInterface
	{
		private const TOPCAMERASPEED:int = 5;
		
		private var currentCameraSpeed:int;
		private var xMovement:int;
		private var yMovement:int;
		
		private const MOVING_THRESHOLD:int = 5000;
		
		private var floorTile:FloorGenerator;
		private var treeTile:TreeGenerator;

		private var redFrame:Box;
		private var blackFrame:BlackFrame;

		private var player:Player;

		

		private var backgroundMovementLocked:Boolean = false;

		private var moved:int;

		private var woodSound:WoodSound;
		
		public function WoodsView()
		{
			super("Woods");
		}
		
		public override function prepare():void
		{
			currentCameraSpeed = 0;
			
			floorTile = new FloorGenerator();
			addChild(floorTile);
			
			player = new Player();
			player.x = 800/2;
			player.y = 600/2;
			player.disableViewDistance();
			addChild(player);
			
			treeTile = new TreeGenerator();
			addChild(treeTile);
			
			redFrame = new Box(802, 602, Color.Red);
			redFrame.alpha = player.getInstanity()*0.005;
			redFrame.x = -1;
			redFrame.y = -1;
			addChild(redFrame);
			
			blackFrame = new BlackFrame();
			blackFrame.x = 399;
			blackFrame.y = 299
			addChild(blackFrame);
			
			woodSound= new WoodSound();
		}
		
		public override function start():void
		{
			moved = 0;
			woodSound.playSound();
		}
		
		public override function end():void
		{
			woodSound.stopSound();
		}
		
		private function lockMovement():void
		{
			backgroundMovementLocked = true;
		}
		
		private function gotoTown():void
		{
			ViewManager.getInstance().add(new TownView());
			ViewManager.getInstance().goTo("Town");
		}
		
		public override function update():void
		{
			xMovement = 0;
			yMovement = 0;
			
			if(Key.isDown(Keyboard.UP) || Key.isDown(Keyboard.LEFT) || Key.isDown(Keyboard.DOWN) || Key.isDown(Keyboard.RIGHT))
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
			
			if(Key.isDown(Keyboard.UP))
			{
				yMovement += currentCameraSpeed;
				
			}
			if(Key.isDown(Keyboard.LEFT))
			{
				xMovement += currentCameraSpeed;
			}
			if(Key.isDown(Keyboard.DOWN))
			{
				yMovement -= currentCameraSpeed;
			}
			if(Key.isDown(Keyboard.RIGHT))
			{
				xMovement -= currentCameraSpeed;
			}
			
			moved += Math.abs(xMovement) + Math.abs(yMovement);
			
			if(moved >= MOVING_THRESHOLD)
			{
				lockMovement();
				gotoTown();
			}
			
			if(!backgroundMovementLocked)
			{
				backgroundMovement();
			}
			else
			{
				xMovement *= -1;
				yMovement *= -1;
				movePlayer();
			}
		}
		
		private function movePlayer():void
		{
			player.x += xMovement;
			player.y += yMovement;
			blackFrame.x += xMovement;
			blackFrame.y += yMovement;
			
			for each(var t:Tree in treeTile.getTrees())
			{
				if(t.getCollider() != null && t.getCollider().hitTestObject(player))
				{
					player.x -= xMovement;
					player.y -= yMovement;
					blackFrame.x -= xMovement;
					blackFrame.y -= yMovement;
				}
			}
		}
		
		private function backgroundMovement():void
		{
			
			floorTile.move(xMovement, yMovement);
			treeTile.move(xMovement, yMovement);
			
			for each(var t:Tree in treeTile.getTrees())
			{
				if(t.getCollider() != null && t.getCollider().hitTestObject(player))
				{
					floorTile.move(-xMovement, -yMovement);
					treeTile.move(-xMovement, -yMovement);
				}
			}
		}
	}
}