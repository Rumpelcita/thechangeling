package WoodObjects
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import kEngine.utils.Random;
	
	public class TreeGenerator extends Sprite
	{
		private const tileValue:int = 548;
		
		private var nextTreeInX:int;
		private var nextTreeInY:int;
		
		private var treeList:Array;

		private var nextTreeInThresholdX:int = 20;
		private var nextTreeInThresholdY:int = 20;
		
		public function TreeGenerator()
		{
			super();
			
			treeList = new Array();
			
			var forest:int = Random.get(30,100);
			for (var i:int = 0; i < forest; i++)
			{
				var t:Tree = new Tree();
				t.scaleX = 1.5;
				t.scaleY = 1.5;
				t.x = Random.get(0, tileValue *2);
				t.y = Random.get(0, tileValue *2);
				
				if(t.x < 450 && t.x > 350 && t.y > 250 || t.y < 350)
				{
					
				}
				else
				{
				addChild(t);	
				treeList.push(t);
				}
			}
			
			nextTreeInX = 0;
			nextTreeInX = 0;
		}	
		
		public function move(moveX:int, moveY:int):void
		{
			for each(var t:Tree in treeList)
			{
				t.y += moveY;
				t.x += moveX;
			}
			
			nextTreeInY += moveY;
			nextTreeInX += moveX;
			
			checkNextTreeTime();
		}
		
		private function checkNextTreeTime():void
		{
			xThreshold();
			yThreshold();
			
			cleanTrees();
		}
		
		private function xThreshold():void
		{
			if(Math.abs(nextTreeInX) >= nextTreeInThresholdX)
			{
				trace("nextTreeInX", nextTreeInX);
				
				var toAdd:int = Random.get(1,4);
				
				for (var i:int = 0; i < toAdd; i++)
				{
					var t:Tree = new Tree();
					t.scaleX = 1.5;
					t.scaleY = 1.5;
					
					if(nextTreeInX > 0)
					{
						t.x = Random.get(0, 50);
					}
					else
					{
						t.x = Random.get(750, 800);
					}
					
					t.y = Random.get(0, tileValue);
					addChild(t);
					
					treeList.push(t);
				}
				
				nextTreeInThresholdX = Random.get(50, 75);
				nextTreeInX = 0;
				
				trace("added tress", toAdd);
				trace("next thresthold x", nextTreeInThresholdX);
			}
		}
		
		private function yThreshold():void
		{
			if(Math.abs(nextTreeInY) >= nextTreeInThresholdY)
			{
				trace("nextTreeInY", nextTreeInY);
				
				var toAdd:int = Random.get(1,4);
				
				for (var i:int = 0; i < toAdd; i++)
				{
					var t:Tree = new Tree();
					t.scaleX = 1.5;
					t.scaleY = 1.5;
					
					if(nextTreeInY > 0)
					{
						t.y = Random.get(0, 10);
						
						addChildAt(t, 0);
					}
					else
					{
						t.y = Random.get(590, 600);
						addChildAt(t, numChildren-1);
					}
					
					t.x = Random.get(0, 800);
					
					treeList.push(t);
				}
				
				nextTreeInThresholdY = Random.get(50, 75);
				nextTreeInY = 0;
				
				trace("added tress", toAdd);
				trace("next thresthold y", nextTreeInThresholdY);
			}
		}
		
		private function cleanTrees():void
		{
			for(var i:int = 0; i < treeList.length; i++)
			{
				var t:Tree = treeList[i];
				if(t.x < 0 || t.x > 800 || t.y < 0 || t.y > 800)
				{
					removeChild(t);
					treeList.splice(i, 1);
				}
			}
		}
		
		public function getTrees():Object
		{
			return treeList;
		}
	}
}