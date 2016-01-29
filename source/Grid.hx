package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
using flixel.util.FlxSpriteUtil;

class Grid extends FlxSprite{

	private var gridCellsX:Int;
	private var gridCellsY:Int;
	private var gridSpanX:Int;
	private var gridSpanY:Int;

	public function new(x:Int, y:Int,gridCellsX:Int,gridCellsY:Int,gridSpanX:Int,gridSpanY:Int) {
		super(x,y);
		this.gridCellsX = gridCellsX;
		this.gridCellsY = gridCellsY;
		this.gridSpanX = gridSpanX;
		this.gridSpanY = gridSpanY;
		makeGraphic(gridSpanX*gridCellsX + 35, gridSpanY*gridCellsY+5,0x00000000);
		var gridSizeX:Int = 10;
		var gridSizeY:Int = 10;
		var cellSize = 40;
		for(i in 0...Math.floor(gridSizeY/2)){
			for(j in 0...gridSizeX){
				if(gridSizeY%2==0 || i+1<gridSizeY/2 || j%2==0){
					var hexagonX:Float = cellSize*j/2;
					var hexagonY:Float = cellSize*i*1.5+(cellSize/4*3)*(j%2);	
					new Hexagon(hexagonX,hexagonY,cellSize);
				}
			}
		}


		//drawGrid(gridCellsX,gridCellsY,gridSpanX,gridSpanY);
		FlxG.state.add(this);
		//fillGridWithBalls();
	}
	public function drawGrid (gridCellsX:Int,gridCellsY:Int,gridSpanX:Int,gridSpanY:Int)
	{
		var gridSizeX = gridSpanX*gridCellsX;
		var gridSizeY = gridSpanY*gridCellsY;
		var lineStyle = { color: 0xFF3F51B5, thickness: 3.0 };
		for (i in 0 ... gridCellsX+1) {
			drawLine(i*gridSpanX,0, 0+ i*gridSpanX,0 + gridSizeY,lineStyle);							
		}
		for (i in 0 ... gridCellsY+1) {
			drawLine(0 ,0 + i*gridSpanY, 0+ gridSizeX,0  + i*gridSpanY,lineStyle);							
		}
	}
	public function fillGridWithBalls ()
	{
		for (i in 0 ... gridCellsX) {
			for (j in 0 ... gridCellsY) {
				if(Math.random()<.3)
					new Ball(x + i*gridSpanX , y + j*gridSpanY , 12,8);
			}
		}
	}
}