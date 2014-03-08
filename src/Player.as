package
{
	import SoundPackages.WalkSound;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import kEngine.views.ViewManager;
	
	public class Player extends Sprite
	{

		private var instanity:Number;
		private var sprite:PlayerSprite;
		private var viewDistance:BlackFrame;

		private var dollInstance:int;
		
		
		private var isMoving:Boolean = false;
		private var playerSound:WalkSound = new WalkSound();
		private var stagePlayer:String;
		
		public function Player()
		{
			super();
			
			instanity = 0;
			
			sprite = new PlayerSprite();
			sprite.x = -sprite.width/2;
			sprite.y = -sprite.heilength/2;
			addChild(sprite);
			
			viewDistance = new BlackFrame();
			addChild(viewDistance);
			
			dollInstance = 0;
			
			stagePlayer = ViewManager.getInstance().getCurrentView();
		}
		
		public function playerMoves():void
		{
			if (isMoving == false)
			{
				playerSound.playWalkSound(stagePlayer);
				isMoving == true;
			}
			
		}
		
		public function playerStops():void
		{
			if (isMoving == true)
			{
				playerSound.stopWalkSound(stagePlayer);
				isMoving == false;
			}
		}
		
		public function update():void
		{
			
		}
		
		public function getInstanity():Number
		{
			return instanity;
		}
		
		public function getHitBox():Sprite
		{
			return sprite.hit;
		}
		
		public function disableViewDistance():void
		{
			removeChild(viewDistance);
		}
		
		public function getDollInstance():int
		{
			dollInstance++;
			return dollInstance;
		}
	}
}