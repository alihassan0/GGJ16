package;
/*
#TODO : level Array loader
#TODO : Lightining ray
#TODO : 

*/
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
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
	
	public var hexagons:Array<Hexagon>;
	public var balls:Array<Ball>;
	private var linesSprite:FlxSprite;
	private var selectedBalls:Array<Ball>;
	public function new(x:Int, y:Int) {
		super(x,y);
		sectorWidth = hexagonWidth;
		sectorHeight = hexagonHeight/4*3;
		gradient = (hexagonHeight/4)/(hexagonWidth/2);
		makeGraphic(400,400,0x00000000);
		var cellSize = 40;
		columns = [Math.ceil(gridSizeX/2),Math.floor(gridSizeX/2)];
		hexagons = new Array<Hexagon>();
		balls = new Array<Ball>();
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
		selectedBalls = new Array<Ball>();
		linesSprite = new FlxSprite(0,0).makeGraphic(FlxG.width,FlxG.height,0x00000000);
		FlxG.state.add(linesSprite);
	}
	public function loadArray(data:Array<Int>)
	{
		for (i in 0 ... data.length) {
			if(data[i]==1)
			{
				placeMarker(getMidPointFromCoordinates(new FlxPoint(1+i%6,Math.floor(i/6))));
				balls.push(new Ball(-21.25+marker.x+marker.width/2,-21.25+marker.y+marker.height/2,12,8,this,i%6,Math.floor(i/6)));
			}
		}
	}
	public function clearSelection()
	{
		for (i in 0 ... hexagons.length) {
			hexagons[i].color = 0xFF004D40;
		}
	}
	public function selectBall(ball:Ball)
	{

		if (selectedBalls.indexOf(ball) != -1)
			return ;
		else
		{
			if(selectedBalls.length == 0) 
				selectedBalls.push(ball);
			else 
			{
				var lastBall:Ball = selectedBalls[selectedBalls.length-1];
				trace(Math.abs(lastBall.x- ball.x)*1.5,Math.abs(lastBall.y- ball.y));
				//this *1.5 is one of the ugliest hacks i ever used
				if(lastBall.indexY == ball.indexY || 
					Math.abs(Math.abs(lastBall.indexX- ball.indexX)*1.5 - Math.abs(lastBall.indexY- ball.indexY))<2)
				{
					selectedBalls.push(ball);
					var startball:Ball = selectedBalls[selectedBalls.length-1];
					var endBall:Ball = selectedBalls[selectedBalls.length-2];
					//to be refractored later 
					var lineStyle = { color: 0xFFFF0000, thickness: 3.0 };
					var startPoint = new FlxPoint(startball.x + 20, startball.y + 20);
					var endPoint = new FlxPoint(endBall.x + 20, endBall.y + 20);
						linesSprite.drawLine(startPoint.x,startPoint.y,endPoint.x,endPoint.y, lineStyle);
				}
			}

		}
			//trace("found element @ index = " + selectedBalls.indexOf(ball));
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
	public function emptyCellAt(pointX:Float,pointY:Float):Bool
	{
		var found:Bool = false;
		for (i in 0 ... balls.length) {
			if(balls[i].indexX == pointX && balls[i].indexY == pointY)
				found = true;
		}
		//trace(found);
		return !found;
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
				if(emptyCellAt(tileCoordinates.x-1,tileCoordinates.y))
					balls.push(new Ball(-21.25+marker.x+marker.width/2,-21.25+marker.y+marker.height/2,12,8,this,tileCoordinates.x-1,tileCoordinates.y));
			}
		}
		if(FlxG.mouse.justReleased)
		{
			//linesSprite.color = 0x00000000;
		}
	}
}