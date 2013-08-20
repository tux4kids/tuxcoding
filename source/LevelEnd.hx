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
	private var msgBox:MessageBox;


	public function new(LvlNum:Int, NumCoins:Int, NumCommands:Int, 
		Challenge1:Bool, Challenge2:Bool, Challenge3:Bool) 
	{
		super();
		levelNum = LvlNum;
		this.msgBox = new MessageBox("LEVEL " + (levelNum+1) + " WON", 
			NumCoins, NumCommands, quitFun, replayFun, playNextFun,
			Challenge1, Challenge2, Challenge3);
	}

	override public function create():Void 
	{
		add(new FlxSprite(0, 0, AssetNames.Background));
		
		add(msgBox);

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
		FlxG.switchState(new PlayState(levelNum+1));
	}
}