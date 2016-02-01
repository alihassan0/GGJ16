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
add steps and make them decresse
 */
class MenuState extends FlxState
{
	private var gridSprite:FlxSprite;
	private var grid:Grid;
	private var stepsCounter:FlxText;
	private var levelText:FlxText;
	private var tombsCount:FlxText;

	override public function create():Void
	{
		this.bgColor = 0xFFBBDEFB;
		add(new FlxSprite(0,0,"assets/images/level1/1.png"));
		add(new FlxSprite(0,0,"assets/images/level1/2.png"));
		FlxG.camera.antialiasing = true;
		grid = new Grid(0,100);
		add(stepsCounter = new FlxText(0,10,FlxG.width,"Steps:5").setFormat(null,16,0xFFFF0000,"center"));
		add(levelText = new FlxText(0,10,FlxG.width,"level:"+Reg.level).setFormat(null,16,0xFFFF0000,"left"));
		add(tombsCount = new FlxText(0,10,FlxG.width,"tombs:"+grid.tombs.length).setFormat(null,16,0xFFFF0000,"right"));
		
		grid.loadArray(Reg.levelsData[Reg.level],Reg.levelsMovesData[Reg.level]);
		//var lightningStyle = { color: 0xFFFF0000, thickness: 3.0 };
		add(new FlxSprite(0,0,"assets/images/level1/3.png"));

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
		stepsCounter.text = "Steps:"+grid.steps;
		tombsCount.text = "tombs:"+grid.tombs.length;
		//lightning.recalculate(new FlxPoint(0,0),new FlxPoint(250,250),50,0);
	}
	
}