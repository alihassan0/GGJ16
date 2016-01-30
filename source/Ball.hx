package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxRandom;
import flixel.math.FlxPoint;
import flixel.input.mouse.FlxMouseEventManager;

using flixel.util.FlxSpriteUtil;

class Ball extends FlxSprite {
	private var grid:Grid;
	public var indexX:Int;
	public var indexY:Int;
	public function new(x:Float , y:Float , radius:Int,offset:Int,grid:Grid,indexX:Float, indexY:Float) {
		super(x,y);
		this.grid = grid;
		this.indexX = Math.floor(indexX);
		this.indexY = Math.floor(indexY);
		makeGraphic(3+2*(radius+offset),3+2*(radius+offset), 0x00000000);
		drawCircle(width/2 ,height/2 , radius, 0xFFFFFFFF);
		color = 0xFFFF5722 ;
		FlxMouseEventManager.add(this, onMouseDown,onMouseUp,onMouseOver,onMouseOut); 
		
		FlxG.state.add(this);
	}
	function onMouseDown(sprite:FlxSprite) {
		trace(indexX,indexY);
		grid.clearSelection();	
		highLightAdjacents();
		grid.selectBall(this);
	}
	function highLightAdjacents() {
		var adjacentHexagons:Array<Hexagon> = new Array<Hexagon>();
		adjacentHexagons.push(grid.getHexagonWithCoordinates(new FlxPoint(indexX+1,indexY)));
		adjacentHexagons.push(grid.getHexagonWithCoordinates(new FlxPoint(indexX-1,indexY)));
		adjacentHexagons.push(grid.getHexagonWithCoordinates(new FlxPoint(indexX+1-((indexY+1)%2),indexY+1)));
		adjacentHexagons.push(grid.getHexagonWithCoordinates(new FlxPoint(indexX+1-((indexY+1)%2),indexY-1)));		
		adjacentHexagons.push(grid.getHexagonWithCoordinates(new FlxPoint(indexX-((indexY+1)%2),indexY+1)));
		adjacentHexagons.push(grid.getHexagonWithCoordinates(new FlxPoint(indexX-((indexY+1)%2),indexY-1)));
		for (i in 0 ... adjacentHexagons.length) {
			grid.highLight(adjacentHexagons[i]);
		}
	}
	function onMouseUp(sprite:FlxSprite) {
		//FlxG.switchState(new PlayState());
	}
	function onMouseOver(sprite:FlxSprite) {
		color = 0xFFCC4D40;
	}
	function onMouseOut(sprite:FlxSprite) {
		color = 0xFFFF5722 ;
	}

}