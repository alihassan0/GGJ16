package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxPoint;
import flixel.addons.display.shapes.FlxShapeLightning;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var gridSprite:FlxSprite;
	private var grid:Grid;
	private var lightning:FlxShapeLightning;

	override public function create():Void
	{
		this.bgColor = 0xFFBBDEFB;
		FlxG.camera.antialiasing = true;
		grid = new Grid(0,100);
		var level1Data:Array<Int> = [0,0,0,0,0,0,
									  0,0,0,0,0,0,
									 0,0,0,0,0,0,
									  0,0,0,0,0,0,
									 1,0,0,2,0,1,
									  0,0,0,0,0,0,
									 0,0,0,0,0,0,
									  0,0,0,0,0,0,
									 0,0,0,0,0,0,
									  0,0,0,0,0,0];
		grid.loadArray(level1Data);
		//var lightningStyle = { color: 0xFFFF0000, thickness: 3.0 };
		var lightningStyle:LightningStyle = {thickness: 3.0,displacement: 150,detail:2 ,color:0xFFFFFFFF};
		add(lightning = new FlxShapeLightning(0,0,new FlxPoint(0,0),new FlxPoint(250,250),lightningStyle));
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
		lightning.recalculate(new FlxPoint(0,0),new FlxPoint(250,250),50,0);
	}	
}