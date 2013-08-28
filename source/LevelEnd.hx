/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;

import org.flixel.FlxState;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxText;

class LevelEnd extends FlxState
{
	private var levelNum:Int;
	private var numCoins:Int;
	private var numCommands:Int;
	private var challenges:Array<Bool>;

	public function new(LvlNum:Int, NumCoins:Int, NumCommands:Int, 
		Challenge1:Bool, Challenge2:Bool, Challenge3:Bool) 
	{
		super();
		levelNum = LvlNum;
		numCoins = NumCoins;
		numCommands = NumCommands;
		challenges = [Challenge1, Challenge2, Challenge3];
	}

	override public function create():Void 
	{
		add(new FlxSprite(0, 0, AssetNames.Background));
		
		add(new MessageBox("LEVEL " + (levelNum+1) + " WON", 
			numCoins, numCommands, quitFun, replayFun, playNextFun,
			challenges[0], challenges[1], challenges[2]));

		super.create();		
	}

	private function quitFun():Void
	{
		FlxG.switchState(new MenuState());
	}

	private function replayFun():Void
	{
		FlxG.switchState(new PlayState(levelNum));
	}

	private function playNextFun():Void
	{
		levelNum++;
		if (levelNum < Registry.numLevels)
			FlxG.switchState(new PlayState(levelNum));
		else
			FlxG.switchState(new CongratState());
	}
}