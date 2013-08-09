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
		
		var msgWin:FlxSprite = new FlxSprite(0, 0, AssetNames.MessageWidow);
		msgWin.x = (FlxG.width - msgWin.width)/2;
		msgWin.y = (FlxG.height - msgWin.height)/2;
		add(msgWin);

		var quitBtn:FlxButton = new FlxButton(0, 0, "", quitFun);
		quitBtn.loadGraphic(AssetNames.ReturnLevelsBtn, true, false, 93, 105);
		quitBtn.y = msgWin.y + msgWin.height - quitBtn.height - 60;
		add(quitBtn);

		var replayBtn:FlxButton = new FlxButton(0, 0, "", replayFun);
		replayBtn.loadGraphic(AssetNames.ReplayBtn, true, false, 93, 105);
		replayBtn.y = msgWin.y + msgWin.height - replayBtn.height - 60;
		add(replayBtn);

		var nextBtn:FlxButton = new FlxButton(0, 0, "", playNextFun);
		nextBtn.loadGraphic(AssetNames.PlayNextBtn, true, false, 93, 105);
		nextBtn.y = msgWin.y + msgWin.height - nextBtn.height - 60;
		add(nextBtn);

		var btnPad:Float = (msgWin.width - quitBtn.width*3)/4;

		quitBtn.x = msgWin.x + btnPad;
		replayBtn.x = quitBtn.x + quitBtn.width + btnPad;
		nextBtn.x = replayBtn.x + replayBtn.width + btnPad;

		add(new FlxText(msgWin.x, msgWin.y+75, Std.int(msgWin.width), "LEVEL " + (levelNum+1) + " WON")
			.setFormat(AssetNames.TextFont, 64, 0xd1535e, "center"));

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