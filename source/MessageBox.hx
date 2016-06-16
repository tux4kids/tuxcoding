/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;

import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;

class MessageBox extends FlxGroup
{
	private var quitFun:Dynamic;
	private var replayFun:Dynamic;
	private var playFun:Dynamic;
	private var message:String;

	private var numCoins:Int;
	private var numCommands:Int;

	private var challenges:Array<Bool>;

	public function new(Message:String, NumCoins:Int, NumCommands:Int, 
		QuitFun:Dynamic, ReplayFun:Dynamic, PlayFun:Dynamic, 
		Challenge1:Bool = false, Challenge2:Bool = false, Challenge3:Bool = false) 
	{
		super();
		message = Message;
		quitFun = QuitFun;
		replayFun = ReplayFun;
		playFun = PlayFun;

		numCoins = NumCoins;
		numCommands = NumCommands;

		challenges = [Challenge1, Challenge2, Challenge3];

		init();
	}

	private function init():Void 
	{
		var msgWin:FlxSprite = new FlxSprite(0, 0, AssetNames.MessageWidow);
		msgWin.x = (FlxG.width - msgWin.width)/2;
		msgWin.y = (FlxG.height - msgWin.height)/2;
		add(msgWin);

		for (i in 0...3) {
			var marker:FlxSprite = new FlxSprite(msgWin.x+ 30, msgWin.y+ 100+i*60)
				.loadGraphic(AssetNames.ChallengeMarker, true);
			marker.animation.frameIndex = challenges[i] ? 1:0;
			add(marker);
		}

		add(new FlxText(msgWin.x+ 100, msgWin.y+ 100, Std.int(msgWin.width - 120), 
			"Reach the exit door")
			.setFormat(AssetNames.TextFont, 35, 0x000000));
		add(new FlxText(msgWin.x+ 100, msgWin.y+ 160, Std.int(msgWin.width - 120), "Collect All Coins")
			.setFormat(AssetNames.TextFont, 35, 0x000000));
		add(new FlxText(msgWin.x+ 100, msgWin.y+ 220, Std.int(msgWin.width - 100), 
			"Use "+numCommands+" commands to collect all coins")
			.setFormat(AssetNames.TextFont, 35, 0x000000));

		var quitBtn:FlxButton = new FlxButton(0, 0, "", quitFun);
		quitBtn.loadGraphic(AssetNames.ReturnLevelsBtn, true, 93, 105);
		quitBtn.y = msgWin.y + msgWin.height - quitBtn.height - 50;
		add(quitBtn);

		var replayBtn:FlxButton = new FlxButton(0, 0, "", replayFun);
		replayBtn.loadGraphic(AssetNames.ReplayBtn, true, 93, 105);
		replayBtn.y = msgWin.y + msgWin.height - replayBtn.height - 50;
		add(replayBtn);

		var nextBtn:FlxButton = new FlxButton(0, 0, "", playFun);
		nextBtn.loadGraphic(AssetNames.PlayBtn, true, 93, 105);
		nextBtn.y = msgWin.y + msgWin.height - nextBtn.height - 50;
		add(nextBtn);

		var btnPad:Float = (msgWin.width - quitBtn.width*3)/4;

		quitBtn.x = msgWin.x + btnPad;
		replayBtn.x = quitBtn.x + quitBtn.width + btnPad;
		nextBtn.x = replayBtn.x + replayBtn.width + btnPad;

		add(new FlxText(msgWin.x, msgWin.y+25, Std.int(msgWin.width), message)
			.setFormat(AssetNames.TextFont, 54, 0xd1535e, "center"));
	}
}