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

class CongratState extends FlxState
{
	override public function create() {
		add(new FlxSprite(0, 0, AssetNames.Background));

		var msgWin:FlxSprite = new FlxSprite(0, 0, AssetNames.MessageWidow);
		msgWin.x = (FlxG.width - msgWin.width)/2;
		msgWin.y = (FlxG.height - msgWin.height)/2;
		add(msgWin);

		var quitBtn:FlxButton = new FlxButton(0, 0, "", quit);
		quitBtn.loadGraphic(AssetNames.ReturnLevelsBtn, true, false, 93, 105);
		quitBtn.x = msgWin.x + (msgWin.width - quitBtn.width) / 2;
		quitBtn.y = msgWin.y + msgWin.height - quitBtn.height - 50;
		add(quitBtn);

		var numStars:Int = 0;
		for (level in 0...Registry.numLevels) {
			numStars += ProjectClass.getStars(level);
		}

		add(new FlxText(msgWin.x, msgWin.y+25, Std.int(msgWin.width), 
			"Congratulations\nYou Finished\nAll Levels\nStars Collected:\n"+numStars+"/"+(Registry.numLevels*3))
			.setFormat(AssetNames.TextFont, 54, 0xd1535e, "center"));
	}

	private function quit() {
		FlxG.switchState(new MenuState());
	}
}