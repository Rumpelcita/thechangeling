package
{
	import SoundPackages.EventSound;
	import SoundPackages.TownSound;
	import SoundPackages.UndergroundSound;
	
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	import kEngine.views.View;
	import kEngine.views.ViewInterface;
	import kEngine.views.ViewManager;
	
	public class TownView extends View implements ViewInterface
	{
		private var village:Village;
		private var player:Player;
		
		private const TOPCAMERASPEED:int = 5;
		
		private var currentCameraSpeed:int;
		private var xMovement:int;
		private var yMovement:int;
		
		private var playerCanMove:Boolean;

		private var dialog:DialogShower;
		
		private var inventory:Inventory;
		
		private var runes:RunesPuzzle;
		
		private var townSound:TownSound;
		private var itemSound:EventSound;

		private var undergroundSound:UndergroundSound;

		private var portalOpened:Boolean;

		private var finalDecition:FinalDecitions;

		private var endGame:Boolean;
		
		public function TownView()
		{
			super("Town");
		}
		
		public override function prepare():void
		{
			village = new Village();
			village.scaleX = 1;
			village.scaleY = 1;
			village.x = -150;
			village.y = -2500;
			addChild(village);
			
			player = new Player();
			player.x = 400;
			player.y = 300;
			addChild(player);
			
			playerCanMove= true;
			
			dialog = new DialogShower();
			dialog.addEventListener(DialogShower.END_DIALOG, dialogCompleted);
			addChild(dialog);
			
			inventory = new Inventory();
			inventory.addEventListener(Inventory.READ_BOOK, readBook);
			inventory.addEventListener(Inventory.WATCH_BOOK, watchBook);
			inventory.addEventListener(Inventory.WATCH_DOLL, watchDoll);
			inventory.addEventListener(Inventory.WATCH_KNIFE, watchKnife);
			addChild(inventory);
			
			runes = new RunesPuzzle();	
			runes.addEventListener(RunesPuzzle.OPEN_PORTAL, openPortal);
			runes.x = 400;
			runes.y = 300;
			
			townSound = new TownSound();
			undergroundSound = new UndergroundSound();
			itemSound = new EventSound();
			
			portalOpened = false;
			endGame = false;
			finalDecition= new FinalDecitions();
		}
		
		protected function openPortal(event:Event):void
		{
			TweenLite.to(village.portalClip, 0.5, {alpha : 1});
			TweenLite.to(runes, 0.5, {alpha : 0});
			playerCanMove = true;
			
			village.portalClip.play();
			townSound.stopSound();
			undergroundSound.playFinalMusic();
			
			portalOpened = true;
		}
		
		protected function watchKnife(event:Event):void
		{
			showDialog("dialogKnifeFind");
			itemSound.playEventSounds(3);
		}
			
		protected function watchBook(event:Event):void
		{
			showDialog("dialogBookFind");
			itemSound.playEventSounds(2);
		}
		
		protected function readBook(event:Event):void
		{
			showDialog("dialogReadBook");
			itemSound.playEventSounds(2);
		}
		
		protected function watchDoll(event:Event):void
		{
			var i:int = player.getDollInstance();
			showDialog("dialogDollWatch" + i);
			
			inventory.setDollStatus(i);

		}
		
		protected function dialogCompleted(event:Event):void
		{
			playerCanMove = true;
			
			
			if(endGame)
			{
				ViewManager.getInstance().goTo("Woods");
			}
		}
		
		public override function start():void
		{
			townSound.playSound();
		}
		
		public override function end():void
		{
			townSound.stopSound();
			undergroundSound.stopSound();
		}
		
		public override function update():void
		{		
			if(playerCanMove)
			{
				xMovement = 0;
				yMovement = 0;
				
				if(Key.isDownOnce(Keyboard.Z))
				{
					playerInteraction();
				}
				
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
						player.playerStops();
					}
					else
					{
						player.playerMoves();
					}
				}
				else
				{
					village.x += xMovement;
					
					
					if(playerIsColliding())
					{
						village.x -= xMovement;
						player.playerStops();
					}
					else
					{
						player.playerMoves();
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
						player.playerStops();
					}
					else
					{
						player.playerMoves();
					}
				}
				else
				{
					
					village.y += yMovement;					
					
					if(playerIsColliding())
					{
						village.y -= yMovement;
						player.playerStops();
					}
					else
					{
						player.playerMoves();
					}
				}
			}
		}
		
		private function playerInteraction():void
		{
			if(village.dialogFoodRats.hitTestObject(player.getHitBox()))
			{
				showDialog("dialogFoodRats");
			}
			if(village.dialogFoodOld.hitTestObject(player.getHitBox()))
			{
				showDialog("dialogFoodOld");
			}
			
			if(village.triggerBook.hitTestObject(player.getHitBox()))
			{
				village.book.alpha = 0;
				inventory.add("book");
				showDialog("dialogBookFind");
			}
			
			if(village.triggerDoll.hitTestObject(player.getHitBox()))
			{
				village.doll.alpha = 0;
				inventory.add("doll");
				showDialog("dialogDollFind");
			}
			
			if(village.triggerKnife.hitTestObject(player.getHitBox()))
			{
				village.knife.alpha = 0;
				inventory.add("knife");
				showDialog("dialogKnifeFind");
			}
			
			if(village.dialogOldOne.hitTestObject(player.getHitBox()))
			{
				if(inventory.hasBook())
				{
					inventory.readBookEnabe();
					showDialog("dialogBook");
					trace("dialogBook");
				}
				else
				{
					trace("dialogNoBook");
					showDialog("dialogNoBook");
				}
			}
			
			if(!portalOpened && village.triggerRune.hitTestObject(player.getHitBox()))
			{
				playerCanMove = false;
				addChild(runes);
			}
			
			if(portalOpened)
			{
				if(village.portal.hitTestObject(player.getHitBox()))
				{
					playerCanMove = false;
					finalDecition.addEventListener(FinalDecitions.FINAL_ONE, gotoFInalOne);
					finalDecition.addEventListener(FinalDecitions.FINAL_TWO, gotoFInalTwo);
					finalDecition.addEventListener(FinalDecitions.FINAL_THREE, gotoFInalThree);
					addChild(finalDecition);
				}
			}
		}		
		
		protected function gotoFInalThree(event:Event):void
		{
			dialog.setText("dialogFinal3");
			endGame = true;
		}
		
		protected function gotoFInalTwo(event:Event):void
		{
			dialog.setText("dialogFinal2");
			endGame = true;
		}
		
		protected function gotoFInalOne(event:Event):void
		{
			dialog.setText("dialogFinal1");
			endGame = true;
		}
		
		private function showDialog(text:String):void
		{
			playerCanMove = false;
			dialog.setText(text);
		}		
		
		private function canMoveMapY(direction:int):Boolean
		{
			if(village.y+direction < -(village.height - 300))
				return false;
			if(village.y+direction > 300)
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
			if(village.x+direction < -(village.width - 400))
				return false;
			if(village.x+direction > 400)
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
			for(var i:int = 0; i < village.hit.numChildren; i++)
			{
				if(village.hit.getChildAt(i).hitTestObject(player.getHitBox()))
				{
					return true;
				}
			}
			
			return false;
		}
	}
}