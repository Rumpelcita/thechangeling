package LabyrinthObjects
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class TiledMazeGen extends Sprite
	{
		//constants
		private var MAZE_WIDTH		: uint = 5;
		private var MAZE_HEIGHT		: uint = 5;
		private const TILE_SIZE			: uint = 80;
		
		//directions
		private const NORTH				: String = "N";
		private const SOUTH				: String = "S";
		private const EAST				: String = "E";
		private const WEST				: String = "W";
		
		//variables
		private var _width		: uint;
		private var _height		: uint;
		private var _maze		: Array;
		private var _moves		: Array;
		private var _start		: Point;
		private var _finish		: Point;
		private var _container	: Sprite;
		
		private var tiles:Array;
		
		public function TiledMazeGen (sizeX:int, sizeY:int) : void
		{
			MAZE_WIDTH = sizeX;
			MAZE_HEIGHT = sizeY;
			
			_width	= sizeX * 2 + 1;
			_height	= sizeY * 2 + 1;
			
			_container = new Sprite();
			
			_generate();
		}
		
		public function getTiles():Array
		{
			return tiles;
		}
		
		private function _generate ( event : MouseEvent = null ) : void
		{
			_start	= new Point(1, 1);
			_finish = new Point(_height - 2, _width - 2);
			_initMaze();
			_createMaze();
			_drawMaze();
		}
		
		private function _initMaze () : void
		{
			_maze	= new Array(_width);
			
			for ( var x : int = 0; x < _height; x++ )
			{
				_maze[x] = new Array(_height);
				
				for ( var y : int = 0; y < _width; y++ )
				{
					_maze[x][y] = true;
				}
			}
			
			_maze[_start.x][_start.y] = false;
		}
		
		private function _createMaze () : void
		{
			var back				: int;
			var move				: int;
			var possibleDirections	: String;
			var pos					: Point = _start.clone();
			
			_moves = new Array();
			_moves.push(pos.y + (pos.x * _width));
			
			while ( _moves.length )
			{
				possibleDirections = "";
				
				if ((pos.x + 2 < _height ) && (_maze[pos.x + 2][pos.y] == true) && (pos.x + 2 != false) && (pos.x + 2 != _height - 1) )
				{
					possibleDirections += SOUTH;
				}
				
				if ((pos.x - 2 >= 0 ) && (_maze[pos.x - 2][pos.y] == true) && (pos.x - 2 != false) && (pos.x - 2 != _height - 1) )
				{
					possibleDirections += NORTH;
				}
				
				if ((pos.y - 2 >= 0 ) && (_maze[pos.x][pos.y - 2] == true) && (pos.y - 2 != false) && (pos.y - 2 != _width - 1) )
				{
					possibleDirections += WEST;
				}
				
				if ((pos.y + 2 < _width ) && (_maze[pos.x][pos.y + 2] == true) && (pos.y + 2 != false) && (pos.y + 2 != _width - 1) )
				{
					possibleDirections += EAST;
				}
				
				if ( possibleDirections.length > 0 )
				{
					move = _randInt(0, (possibleDirections.length - 1));
					
					switch ( possibleDirections.charAt(move) )
					{
						case NORTH: 
							_maze[pos.x - 2][pos.y] = false;
							_maze[pos.x - 1][pos.y] = false;
							pos.x -=2;
							break;
						
						case SOUTH: 
							_maze[pos.x + 2][pos.y] = false;
							_maze[pos.x + 1][pos.y] = false;
							pos.x +=2;
							break;
						
						case WEST: 
							_maze[pos.x][pos.y - 2] = false;
							_maze[pos.x][pos.y - 1] = false;
							pos.y -=2;
							break;
						
						case EAST: 
							_maze[pos.x][pos.y + 2] = false;
							_maze[pos.x][pos.y + 1] = false;
							pos.y +=2;
							break;        
					}
					
					_moves.push(pos.y + (pos.x * _width));
				}
				else
				{
					back = _moves.pop();
					pos.x = int(back / _width);
					pos.y = back % _width;
				}
			}
		}
		
		private function _drawMaze () : void
		{
			tiles = new Array;
			var tile : Sprite;
			
			if ( contains(_container) )
			{
				removeChild(_container)
			}
			
			_container = new Sprite();
			addChild(_container);
			
			for ( var x : int = 0; x < _height; x++ )
			{
				for ( var y : int = 0; y < _width; y++ )
				{
					if(x == _start.x && y == _start.y)
					{
						tile = new DungeonStart();
					}
					else
						if(x == _finish.x && y == _finish.y)
						{
							tile = new DungeonEnd();
						}
						else
							if(_maze[x][y])
							{
								if((x-1) > 0 && _maze[x-1][y] || (x+1) < MAZE_WIDTH && _maze[x+1][y])
								{
									tile = new DungeonWallHorizontal();
								}
								else
									if((y-1) > 0 && _maze[x][y-1] || (y+1) < MAZE_HEIGHT && _maze[x][y+1])
									{
										tile = new DungeonWallVertical();
									}
							}
							else
							{
								tile = new DungeonFloor();
							}
					
					tile.x	= x * TILE_SIZE;
					tile.y	= y * TILE_SIZE;
					
					tile.scaleX = 2;
					tile.scaleY = 2;
					
					tile.addEventListener(MouseEvent.MOUSE_OVER, overTile);
					tile.addEventListener(MouseEvent.MOUSE_OUT, outTile);
					tiles.push(tile);
					
					_container.addChild(tile);
					
					trace("" + x.toString() + "-" + y.toString() + " value " + _maze[x][y] + " type " + tile);
				}
			}
		}
		
		protected function outTile(event:MouseEvent):void
		{
			event.target.alpha = 1;
		}
		
		protected function overTile(event:MouseEvent):void
		{
			event.target.alpha = 0.5;
			trace(event.target);
		}
		
		private function _randInt ( min : int, max : int ) : int 
		{
			return int((Math.random() * (max - min + 1)) + min);
		}
	}
}