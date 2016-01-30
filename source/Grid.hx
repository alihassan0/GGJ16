package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
using flixel.util.FlxSpriteUtil;

class Grid extends FlxSprite{


	private var hexagonWidth:Int = 40;
	private var hexagonHeight:Int = 40;
	private var sectorWidth:Float ;
	private var sectorHeight:Float ;
	private var gradient:Float;
	private var marker:FlxSprite;
	private var columns:Array<Int>;
	private var gridSizeX:Int = 12;
	private	var gridSizeY:Int = 10;
	
	private var selectedBall:Ball;
	public var hexagons:Array<Hexagon>;
	public function new(x:Int, y:Int) {
		super(x,y);
		sectorWidth = hexagonWidth;
		sectorHeight = hexagonHeight/4*3;
		gradient = (hexagonHeight/4)/(hexagonWidth/2);
		makeGraphic(400,400,0x00000000);

		var cellSize = 40;
		columns = [Math.ceil(gridSizeX/2),Math.floor(gridSizeX/2)];
		hexagons = new Array<Hexagon>();
		for(i in 0...Math.floor(gridSizeY/2)){
			for(j in 0...gridSizeX){
				if(gridSizeY%2==0 || i+1<gridSizeY/2 || j%2==0){
					var hexagonX:Float = cellSize*j/2;
					var hexagonY:Float = cellSize*i*1.5+(cellSize/4*3)*(j%2);
					//trace((i%gridSizeX)*2+j%2,Math.floor((Math.floor(j%gridSizeX)/2)));
					hexagons.push(new Hexagon(hexagonX,hexagonY,cellSize,this,Math.floor((Math.floor(j%gridSizeX)/2)),(i%gridSizeX)*2+j%2));
				}
			}
		}
		FlxG.state.add(this);
		marker = new FlxSprite(0,0).makeGraphic(8,8,0xFFFF0000);
		//drawGrid(gridCellsX,gridCellsY,gridSpanX,gridSpanY);
		FlxG.state.add(marker);
		//fillGridWithBalls();
	}
	public function clearSelection()
	{
		for (i in 0 ... hexagons.length) {
			hexagons[i].color = 0xFF004D40;
		}
	}
	public function selectBall(ball:Ball)
	{
		if (ball == selectedBall)
			return ;
		else 
		{
			selectedBall = ball;
			//code to follow
		}
	}
	public function highLight(hexagon:Hexagon)
	{
		if(hexagon!= null)
			hexagon.color = 0xFFFFFFFF;
	}
	public function getHexagonWithCoordinates(point:FlxPoint):Hexagon
	{
		for (i in 0 ... hexagons.length) {
			if(hexagons[i].indexX == point.x && hexagons[i].indexY == point.y )
				return hexagons[i];
		}
		return null;
	}
	function checkHex(){
	    var candidateX = Math.floor((FlxG.mouse.x-x)/sectorWidth);
	    var candidateY = Math.floor((FlxG.mouse.y-y)/sectorHeight);
	    var deltaX = (FlxG.mouse.x-x)%sectorWidth;
	    var deltaY = (FlxG.mouse.y-y)%sectorHeight; 
	    if(candidateY%2==0){
	         if(deltaY<((hexagonHeight/4)-deltaX*gradient)){
	              candidateX--;
	              candidateY--;
	         }
	         if(deltaY<((-hexagonHeight/4)+deltaX*gradient)){
	              candidateY--;
	         }
	    }    
	    else{
	         if(deltaX>=hexagonWidth/2){
	              if(deltaY<(hexagonHeight/2-deltaX*gradient)){
	                   candidateY--;
	              }
	         }
	         else{
	              if(deltaY<deltaX*gradient){
	                   candidateY--;
	              }
	              else{
	                   candidateX--;
	              }
	         }
	    }
	    if(candidateX<1 || candidateY<0 || candidateY>=gridSizeY || candidateX>columns[Math.floor(candidateY%2)]){
			return null;
		}
		else{
			return new FlxPoint(candidateX,candidateY);
		}
    }
    public function placeMarker(point:FlxPoint)
    {
    	if(point == null)
    		marker.visible = false;
    	else 
    	{
        	marker.reset(point.x,point.y);
    		marker.visible = true;
    	}
	}
	public function getMidPointFromCoordinates(point:FlxPoint)
	{
		if(point == null)
			return null;	
		var p:FlxPoint = new FlxPoint(-4+hexagonWidth*point.x,-4+hexagonHeight/4*3*point.y+hexagonHeight/2);
		if(point.y%2==0){
			p.x += hexagonWidth/2;
		}
		else{
			p.x += hexagonWidth;
		}
		return p;
	}
	/*public function drawGrid (gridCellsX:Int,gridCellsY:Int,gridSpanX:Int,gridSpanY:Int)
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
	}*/
	/*public function fillGridWithBalls ()
	{
		for (i in 0 ... gridCellsX) {
			for (j in 0 ... gridCellsY) {
				if(Math.random()<.3)
					new Ball(x + i*gridSpanX , y + j*gridSpanY , 12,8);
			}
		}
	}*/
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if(FlxG.mouse.pressed)
		{
			//trace("added new FlxSprite @",marker.x+marker.width/2,marker.y+marker.height/2);
			var tileCoordinates:FlxPoint = checkHex();
			if(tileCoordinates != null)
			{
				//trace(tileCoordinates.x,tileCoordinates.y);
				placeMarker(getMidPointFromCoordinates(checkHex()));
				new Ball(-21.25+marker.x+marker.width/2,-21.25+marker.y+marker.height/2,12,8,this,tileCoordinates.x-1,tileCoordinates.y);
			}
		}
	}
}