package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.addons.display.shapes.FlxShapeLightning;

/**
 * A FlxState which can be used for the actual gameplay.
 */
using flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	 private var bg:FlxSprite ;
	 private var lightnings:Array<FlxShapeLightning>;
	override public function create():Void
	{
		super.create();
		lightnings = new Array<FlxShapeLightning>();
		add(bg = new FlxSprite(0,0).makeGraphic(FlxG.width,FlxG.height,0x0000000));
		
		add(new FlxText(0,0,FlxG.width,"THE").setFormat(null,64,0xFFFFFFFF,"center"));
		add(new FlxSprite(80,120,"assets/images/logo.png"));

		add(new FlxText(0,350,FlxG.width,"tap/Click to start").setFormat(null,24,0xFFFFFFFF,"center"));
		add(new FlxText(0,450,FlxG.width,"a game for GGJ 16 ").setFormat(null,8,0xFFFFFFFF,"center"));
		add(new FlxText(0,470,FlxG.width,"by ali hassan,mohammed hossam , alaa adel").setFormat(null,8,0xFFFFFFFF,"center"));

		drawLine(new FlxPoint(0,0),new FlxPoint(2,0));
		drawLine(new FlxPoint(0,1.5),new FlxPoint(2,1.5));
		drawLine(new FlxPoint(0,3),new FlxPoint(2,3));
		drawLine(new FlxPoint(0,0),new FlxPoint(0,3));
		drawLine(new FlxPoint(3,0),new FlxPoint(6,3));
		drawLine(new FlxPoint(3,3),new FlxPoint(6,0));
		drawLine(new FlxPoint(7,1.5),new FlxPoint(8,0));
		drawLine(new FlxPoint(7,1.5),new FlxPoint(8,3));
		drawLine(new FlxPoint(10,1.5),new FlxPoint(8,0));
		drawLine(new FlxPoint(10,1.5),new FlxPoint(8,3));
		drawLine(new FlxPoint(11,0),new FlxPoint(13,0));
		drawLine(new FlxPoint(11,1),new FlxPoint(13,1));
		drawLine(new FlxPoint(11,0),new FlxPoint(11,3));
		drawLine(new FlxPoint(11,1),new FlxPoint(13,3));
		drawLine(new FlxPoint(13,0),new FlxPoint(13,1));
		drawLine(new FlxPoint(14,0),new FlxPoint(17,0));
		drawLine(new FlxPoint(14,3),new FlxPoint(17,3));
		drawLine(new FlxPoint(14,0),new FlxPoint(14,3));
		drawLine(new FlxPoint(18,0),new FlxPoint(20,0));
		drawLine(new FlxPoint(18,3),new FlxPoint(20,3));
		drawLine(new FlxPoint(19,0),new FlxPoint(19,3));
		drawLine(new FlxPoint(21,0),new FlxPoint(23,0));
		drawLine(new FlxPoint(21,3),new FlxPoint(23,3));
		drawLine(new FlxPoint(21,0),new FlxPoint(21,1));
		drawLine(new FlxPoint(21,1),new FlxPoint(23,2));
		drawLine(new FlxPoint(23,3),new FlxPoint(23,2));
		drawLine(new FlxPoint(24,0),new FlxPoint(26,0));
		drawLine(new FlxPoint(25,0),new FlxPoint(25,3));
	}
	public function drawLine(p1:FlxPoint,p2:FlxPoint):Void
	{
		var lineStyle = { color: FlxColor.RED, thickness: 1.0 };
		var scale:Int = 10;
		var textOffset:FlxPoint = new FlxPoint(35,80);
		//bg.drawLine(p1.x*scale, p1.y*scale,p2.x*scale, p2.y*scale, lineStyle);
		var lightningStyle:LightningStyle = {thickness: 3.0,displacement: 8,detail:2 ,color:0xFFFFFFFF};
		lightnings.push(new FlxShapeLightning(textOffset.x+p1.x*scale,textOffset.y+ p1.y*scale,new FlxPoint(0,0),new FlxPoint(p2.x*scale-p1.x*scale, p2.y*scale-p1.y*scale),lightningStyle));
		FlxG.state.add(lightnings[lightnings.length-1]);	
		
	}
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(t:Float):Void
	{
		super.update(t);
		for (i in 0 ... lightnings.length) {
			lightnings[i].recalculate(lightnings[i].pointA,lightnings[i].pointB,8,0);
		}
		if(FlxG.mouse.justPressed)
		{
			startGame();
		}
	}	
	private function startGame ()
	{
		FlxG.camera.fade(FlxColor.BLACK,.8, false, function() {
			Reg.level = 1;	
			FlxG.switchState(new MenuState());
		});
	}
}