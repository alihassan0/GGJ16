package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxRandom;

using flixel.util.FlxSpriteUtil;

class Ball extends FlxSprite {
	public function new(x:Float , y:Float , radius:Int,offset:Int) {
		super(x,y);
		makeGraphic(3+2*(radius+offset),3+2*(radius+offset), 0x00000000);
		drawCircle(width/2 ,height/2 , radius, 0xFFFFFFFF);
		/*if(Math.random()<.5)
			color = 0xFF004D40;
		else */
			color = 0xFFFF5722 ;

		FlxG.state.add(this);
	}
}