package;
/*
#TODO : calculate hit tiles
#TODO : enhancing the loading functionaity 
#TODO : calculating steps 
#TODO : Lightining ray

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
	public var tombs:Array<Tomb>;
	private var linesSprite:FlxSprite;
	private var selectedBalls:Array<Ball>;
	public var steps:Int;
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
		tombs = new Array<Tomb>();
		for(i in 0...Math.floor(gridSizeY/2)){
			for(j in 0...gridSizeX){
				if(gridSizeY%2==0 || i+1<gridSizeY/2 || j%2==0){
					var hexagonX:Float = cellSize*j/2;
					var hexagonY:Float = cellSize*i*1.5+(cellSize/4*3)*(j%2);
					//trace((i%gridSizeX)*2+j%2,Math.floor((Math.floor(j%gridSizeX)/2)));
					hexagons.push(new Hexagon(x+hexagonX,y+hexagonY,cellSize,this,Math.floor((Math.floor(j%gridSizeX)/2)),(i%gridSizeX)*2+j%2));
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
		for (i in 0 ... hexagons.length) {
			if(PointInTriangle(getMidPointFromCoordinates(new FlxPoint(hexagons[i].indexX,hexagons[i].indexY)),
				getMidPointFromCoordinates(new FlxPoint(0,5)),
				getMidPointFromCoordinates(new FlxPoint(3,0)),
				getMidPointFromCoordinates(new FlxPoint(5,5))))
			{
				hexagons[i].color = 0xFF00FF00;
			}
			if(PointInLine(getMidPointFromCoordinates(new FlxPoint(hexagons[i].indexX,hexagons[i].indexY)),
				getMidPointFromCoordinates(new FlxPoint(3,2)),
				getMidPointFromCoordinates(new FlxPoint(5,5))))
			{
				hexagons[i].color = 0xFF00FFFF;
			}/*
			if(PointInLine(getMidPointFromCoordinates(new FlxPoint(hexagons[i].indexX,hexagons[i].indexY)),
				getMidPointFromCoordinates(new FlxPoint(1,1)),
				getMidPointFromCoordinates(new FlxPoint(5,5))))
			{
				hexagons[i].color = 0xFF00FFFF;
			}*/
		}
		if(PointInLine(getMidPointFromCoordinates(new FlxPoint(3,3)),
			getMidPointFromCoordinates(new FlxPoint(0,5)),
			getMidPointFromCoordinates(new FlxPoint(5,5))))
		{
			getHexagonWithCoordinates(new FlxPoint(3,3)).color = 0xFF00FFFF;
		}
		getHexagonWithCoordinates(new FlxPoint(0,5)).color = 0xFF000000;
		getHexagonWithCoordinates(new FlxPoint(3,0)).color = 0xFF000000;
		getHexagonWithCoordinates(new FlxPoint(5,5)).color = 0xFF000000;
		getHexagonWithCoordinates(new FlxPoint(1,1)).color = 0xFF000000;

	}
	public function loadArray(data:Array<Int>,steps:Int)
	{
		this.steps = steps;
		for (i in 0 ... data.length) {
			if(data[i]!=0)
			{
				placeMarker(getMidPointFromCoordinates(new FlxPoint(1+i%6,Math.floor(i/6))));
				if(data[i]==1)
					balls.push(new Ball(-21.25+marker.x+marker.width/2,-21.25+marker.y+marker.height/2,12,8,this,i%6,Math.floor(i/6)));
				else if(data[i]==2)
					tombs.push(new Tomb(-21.25+marker.x+marker.width/2,-21.25+marker.y+marker.height/2,12,8,this,i%6,Math.floor(i/6)));
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
	public function getMidPointFromCoordinates(point:FlxPoint):FlxPoint
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
		p.x += x;
		p.y += y;
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
				tileCoordinates.x--;
				placeMarker(getMidPointFromCoordinates(checkHex()));
				if(emptyCellAt(tileCoordinates.x,tileCoordinates.y) 
					&& getHexagonWithCoordinates(tileCoordinates).color == 0xFFFFFFFF)
				{
					selectedBalls[selectedBalls.length-1].reset(-21.25+marker.x+marker.width/2,-21.25+marker.y+marker.height/2);
					selectedBalls[selectedBalls.length-1].indexX = Math.floor(tileCoordinates.x);
					selectedBalls[selectedBalls.length-1].indexY = Math.floor(tileCoordinates.y);
					selectedBalls.splice(0,selectedBalls.length);
					clearSelection();
					linesSprite.fill(0x00000000);
					steps--;
					//balls.push(new Ball(,12,8,this,tileCoordinates.x,tileCoordinates.y));
					//clear selected
				}
			}
		}
		if(FlxG.mouse.justReleased)
		{
			//linesSprite.color = 0x00000000;
		}
	}
	
	private function sign ( p1:FlxPoint,  p2:FlxPoint,  p3:FlxPoint):Float
	{
		var p2p3:FlxPoint = new FlxPoint(p2.x-p3.x,p2.y-p3.y);  
		var p1p3:FlxPoint = new FlxPoint(p1.x-p3.x,p1.y-p3.y);  
		trace(p2p3,p1p3);
		//var s1:Float = p1p3.x*p2p3.x + p1p3.y*p2p3.y ; 
		//var s2:Float = p2p3.x*p1p3.x + p2p3.y*p1p3.y ; 
		var s1:Float = p1p3.x*p2p3.y - p1p3.y*p2p3.x ; 
		var s2:Float = p2p3.x*p1p3.y - p2p3.y*p1p3.x ; 
		var s12:Float = s1-s2;
		trace(s1,s2);
		return s12;
	    //return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
	}

	/*private function pointInTriangle (pt:FlxPoint, v1:FlxPoint, v2:FlxPoint, v3:FlxPoint):Bool
	{
	    trace(pt,v1,v2,v3);
	    var b1:Bool;
	    var b2:Bool;
	    var b3:Bool;
	    b1 = sign(pt, v1, v2) < 0.0;
	    b2 = sign(pt, v2, v3) < 0.0;
	    b3 = sign(pt, v3, v1) < 0.0;
	    trace(sign(pt, v1, v2),sign(pt, v2, v3),sign(pt, v3, v1));
	    return ((b1 == b2) && (b2 == b3));
	}*/
	public function PointInTriangle( p:FlxPoint,  p0:FlxPoint,  p1:FlxPoint,  p2:FlxPoint):Bool
	{
	    var s:Float = p0.y * p2.x - p0.x * p2.y + (p2.y - p0.y) * p.x + (p0.x - p2.x) * p.y;
	    var t:Float = p0.x * p1.y - p0.y * p1.x + (p0.y - p1.y) * p.x + (p1.x - p0.x) * p.y;

	    if ((s < 0) != (t < 0))
	        return false;

	    var a:Float = -p1.y * p2.x + p0.y * (p2.x - p1.x) + p0.x * (p1.y - p2.y) + p1.x * p2.y;
	    if (a < 0.0)
	    {
	        s = -s;
	        t = -t;
	        a = -a;
	    }
	    //changed <= a to < a
	    return s > 0 && t > 0 && (s + t) < a;
	}
	public function PointInLine( p:FlxPoint,  p0:FlxPoint,  p1:FlxPoint) 
	{
		var tx:Float = (p.x-p0.x)/(p1.x-p0.x);
		var ty:Float = (p.y-p0.y)/(p1.y-p0.y);
		trace(tx,ty);
		if((p.y == p0.y && p0.y == p1.y)||(tx == ty && tx > 0 && tx < 1))
			{
				trace("Btngan");
				return true;
			}
		else
			return false;

	}
}