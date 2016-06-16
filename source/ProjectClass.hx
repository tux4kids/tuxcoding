/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package;

import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.util.FlxSave;
import haxe.Log;

class ProjectClass extends FlxGame
{	
	public static inline var version:String = "V. 0.2.15";


	private static var save:FlxSave;

	public static var lastUnlocked (get, set):Int;
	
	var gameWidth:Int = 1024; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 600; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var initialState:Class<FlxState> = TitleState; // The FlxState the game starts with.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	

	private static function get_lastUnlocked():Int {
		return save.data.lastUnlocked;
	}
	private static function set_lastUnlocked(lu:Int):Int {
		save.data.lastUnlocked = lu;
		save.flush();
		return lu;
	}

	public static function getStars(levelNum:Int):Int {
		if(save.data.stars[levelNum] == null)
			return 0;
		else 
		return save.data.stars[levelNum];
	}
	public static function setStars(levelNum:Int, numStars:Int) {
		save.data.stars[levelNum] = numStars;
		save.flush();
	}

	public static function getProgram(levelNum:Int):Array<Int> {
		return save.data.programs[levelNum];
	}
	public static function setProgram(levelNum:Int, program:Array<Int>) {
		save.data.programs[levelNum] = program;
		save.flush();
	}

	public static function getFun1(levelNum:Int):Array<Int> {
		return save.data.fun1s[levelNum];
	}
	public static function setFun1(levelNum:Int, fun:Array<Int>) {
		save.data.fun1s[levelNum] = fun;
		save.flush();
	}

	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		// game is always in landscape orientation
		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		//addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
		super(1000, 1000, TitleState, zoom, 30, 30);

		save = new FlxSave();
		save.bind("tuxcoding");

		if (save.data.version == null || save.data.version != version) {
			// no savegame found (or save format changed), init save date
			Log.trace('No SaveGame fo current version found, creating new one');
			save.data.version = version;
			save.data.lastUnlocked = 0;
			save.data.stars = [];
			save.data.programs = [];
			save.data.fun1s = [];
		}
	}
}
