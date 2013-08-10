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

	public function new(LvlNum:Int) 
	{
		super();
		levelNum = LvlNum;
	}

	override public function create():Void 
	{
		add(new FlxSprite(0, 0, AssetNames.Background));
		
		add(new MessageBox("LEVEL " + (levelNum+1) + " WON", quitFun, replayFun, playNextFun));

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