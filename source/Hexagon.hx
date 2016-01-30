package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxRandom;
import flixel.math.FlxPoint;

using flixel.util.FlxSpriteUtil;

class Hexagon extends FlxSprite {
	private var grid:Grid;
	public var indexX:Int;
	public var indexY:Int;
	public function new(x:Float , y:Float , cellSize:Int,grid:Grid,indexX:Float, indexY:Float) {
		super(x,y);
		this.grid = grid;
		this.indexX = Math.floor(indexX);
		this.indexY = Math.floor(indexY);
		makeGraphic(2*cellSize,2*cellSize, 0x00000000);
		var cellSize:Int = 20;
		var vertices = new Array<FlxPoint>();
		for (i in 0 ... 6)
  		{
  			vertices.push(new FlxPoint(cellSize + cellSize * Math.cos(2 * Math.PI * i / 6)*(7/8),cellSize +  cellSize * Math.sin(2 * Math.PI * i / 6)));
		}
		drawPolygon(vertices, 0xFFFFFFFF);
		angle = 90;	
		if(Math.random()<0)
			color = 0xFFFF5722;
		else 
			color = 0xFF004D40;

		FlxG.state.add(this);
	}
}