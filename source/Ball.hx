package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxRandom;
import flixel.input.mouse.FlxMouseEventManager;

using flixel.util.FlxSpriteUtil;

class Ball extends FlxSprite {
	public function new(x:Float , y:Float , radius:Int,offset:Int) {
		super(x,y);
		makeGraphic(3+2*(radius+offset),3+2*(radius+offset), 0x00000000);
		drawCircle(width/2 ,height/2 , radius, 0xFFFFFFFF);
		color = 0xFFFF5722 ;
		FlxMouseEventManager.add(this, onMouseDown,onMouseUp,onMouseOver,onMouseOut); 
		
		FlxG.state.add(this);
	}
	function onMouseDown(sprite:FlxSprite) {
		//FlxG.switchState(new PlayState());
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