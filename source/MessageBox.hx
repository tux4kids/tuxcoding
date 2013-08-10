/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;

import org.flixel.FlxGroup;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxText;

class MessageBox extends FlxGroup
{
	private var quitFun:Dynamic;
	private var replayFun:Dynamic;
	private var playFun:Dynamic;
	private var message:String;

	public function new(Message:String, QuitFun:Dynamic, ReplayFun:Dynamic, PlayFun:Dynamic) 
	{
		super();
		message = Message;
		quitFun = QuitFun;
		replayFun = ReplayFun;
		playFun = PlayFun;

		init();
	}

	private function init():Void 
	{
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

		var nextBtn:FlxButton = new FlxButton(0, 0, "", playFun);
		nextBtn.loadGraphic(AssetNames.PlayBtn, true, false, 93, 105);
		nextBtn.y = msgWin.y + msgWin.height - nextBtn.height - 60;
		add(nextBtn);

		var btnPad:Float = (msgWin.width - quitBtn.width*3)/4;

		quitBtn.x = msgWin.x + btnPad;
		replayBtn.x = quitBtn.x + quitBtn.width + btnPad;
		nextBtn.x = replayBtn.x + replayBtn.width + btnPad;

		add(new FlxText(msgWin.x, msgWin.y+75, Std.int(msgWin.width), message)
			.setFormat(AssetNames.TextFont, 64, 0xd1535e, "center"));
	}
}