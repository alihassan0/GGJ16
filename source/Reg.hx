package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 1;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];

	public static var levelsMovesData:Array<Int> = [100,1,1,9,10,12];  
	public static var levelsData:Array<Array<Int>> = 
	[
	[1,1,1,1,1,1,
	  1,1,1,1,1,1,
	 1,1,1,1,1,1,
	  1,1,1,1,1,1,
	 1,1,1,2,1,1,
	  1,1,1,1,1,1,
	 1,1,1,1,1,1,
	  1,1,1,1,1,1,
	 1,1,1,1,1,1,
	  1,1,1,1,1,1],

	  [0,0,0,0,0,0,
	  0,0,0,0,0,0,
	 0,0,0,0,0,0,
	  0,0,0,0,0,0,
	 1,0,0,2,0,1,
	  0,0,0,0,0,0,
	 0,0,0,0,0,0,
	  0,0,0,0,0,0,
	 0,0,0,0,0,0,
	  0,0,0,0,0,0],// Moves 1

	  [0,0,0,0,0,0,
	  0,0,1,0,0,0,
	 0,0,0,0,0,0,
	  0,0,0,0,0,0,
	 0,0,0,2,0,0,
	  0,0,0,0,0,0,
	 1,0,0,0,0,1,
	  0,0,0,0,0,0,
	 0,0,0,0,0,0,
	  0,0,0,0,0,0],

	  [0,0,0,0,0,0,
	    0,0,0,0,0,0,
	   0,0,0,0,0,0,
	    0,0,0,2,0,0,
	   0,0,0,0,0,1,
	    0,0,0,2,0,0,
	   0,0,0,0,0,1,
	    0,0,2,0,0,0,
	   0,0,0,0,1,0,
	    0,0,0,0,0,0],	//Moves 10

	[0,0,0,0,0,0,
	  0,0,0,0,0,0,
	 0,1,0,0,0,0,
	  0,0,0,0,0,1,
	 0,2,2,0,2,0,
	  0,1,0,1,0,0,
	 0,2,2,0,0,0,
	  0,0,0,0,0,0,
	 0,0,0,0,0,0,
	  0,0,0,0,0,0], // Moves 14

	[0,0,2,0,0,0,
	  0,0,0,0,2,0,
	 0,0,0,0,1,0,
	  0,0,0,2,0,0,
	 0,0,0,0,0,0,
	  1,0,2,0,0,0,
	 0,0,0,0,0,0,
	  0,0,0,2,0,1,
	 0,0,0,0,0,0,
	  0,0,0,0,2,0]
  ];
}