package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxRandom;
import flixel.math.FlxPoint;
import flixel.input.mouse.FlxMouseEventManager;

using flixel.util.FlxSpriteUtil;

class Tomb extends Ball {
	public function new(x:Float , y:Float , radius:Int,offset:Int,grid:Grid,indexX:Float, indexY:Float) {
		super(x , y , radius,offset,grid,indexX, indexY);
		loadGraphic("assets/images/tombStone.png");
		scale.set(.8,.8);
		centerOffsets();
		this.offset.y += 20;
		color = 0xFFFFFFFF ;
		
	}
	override public function onMouseDown(sprite:FlxSprite) {

	}
	override public function onMouseOver(sprite:FlxSprite) {
	}
	override public function onMouseOut(sprite:FlxSprite) {
	}
	override public function kill() {
		super.kill();
		grid.killTomb(this);
	}
}