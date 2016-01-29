package;

import flixel.FlxSprite;
import flixel.FlxG;

using flixel.util.FlxSpriteUtil;

class Grid extends FlxSprite{

	private var gridCellsX:Int;
	private var gridCellsY:Int;
	private var gridSpanX:Int;
	private var gridSpanY:Int;

	public function new(x:Int, Y:Int,gridCellsX:Int,gridCellsY:Int,gridSpanX:Int,gridSpanY:Int) {
		super(x,y);
		this.gridCellsX = gridCellsX;
		this.gridCellsY = gridCellsY;
		this.gridSpanX = gridSpanX;
		this.gridSpanY = gridSpanY;
		makeGraphic(FlxG.width,FlxG.height,0xFFBBDEFB);
		drawGrid(gridCellsX,gridCellsY,gridSpanX,gridSpanY);
		FlxG.state.add(this);
	}
	public function drawGrid (gridCellsX:Int,gridCellsY:Int,gridSpanX:Int,gridSpanY:Int)
	{
		var gridSizeX = gridSpanX*gridCellsX;
		var gridSizeY = gridSpanY*gridCellsY;
		var lineStyle = { color: 0xFF3F51B5, thickness: 3.0 };
		for (i in 0 ... gridCellsX+1) {
			drawLine(x + i*gridSpanX, y, x + i*gridSpanX, y + gridSizeY,lineStyle);							
		}
		for (i in 0 ... gridCellsY+1) {
			drawLine(x , y + i*gridSpanY, x + gridSizeX, y  + i*gridSpanY,lineStyle);							
		}
	}
}