package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var gridSprite:FlxSprite;

	override public function create():Void
	{
		gridSprite = new FlxSprite(0,0).makeGraphic(FlxG.width,FlxG.height,0xFFBBDEFB);
		add(gridSprite);

		var lineStyle = { color: 0xFF3F51B5, thickness: 3.0 };
		var gridStartX = 10;
		var gridStartY = 10;
		var gridCellsX = 10;
		var gridCellsY = 10;
		var gridSpanX = 40;
		var gridSpanY = 40;
		var gridSizeX = gridSpanX*gridCellsX;
		var gridSizeY = gridSpanY*gridCellsY;
		for (i in 0 ... gridCellsX+1) {
			gridSprite.drawLine(gridStartX + i*gridSpanX, gridStartY, gridStartX + i*gridSpanX, gridStartY + gridSizeY,lineStyle);							
		}
		for (i in 0 ... gridCellsY+1) {
			gridSprite.drawLine(gridStartX , gridStartY + i*gridSpanY, gridStartX + gridSizeX, gridStartY  + i*gridSpanY,lineStyle);							
		}
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
	}	
}