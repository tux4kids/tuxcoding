/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package;

import flash.Lib;
import org.flixel.FlxGame;
import org.flixel.FlxSave;
import haxe.Log;

class ProjectClass extends FlxGame
{	
	private static var save:FlxSave;

	public static var lastUnlocked (get, set):Int;

	private static function get_lastUnlocked():Int {
		return save.data.lastUnlocked;
	}
	private static function set_lastUnlocked(lu:Int):Int {
		save.data.lastUnlocked = lu;
		return lu;
	}

	public function new()
	{
		var Width:Int = Lib.current.stage.stageWidth;
		var Height:Int = Lib.current.stage.stageHeight;
		// game is always in landscape orientation
		var stageWidth:Float = Math.max(Width, Height);
		var stageHeight:Float = Math.min(Width, Height);
		
		var ratioX:Float = stageWidth / 1024;
		var ratioY:Float = stageHeight / 600;
		var ratio:Float = Math.min(ratioX, ratioY);
		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), TitleState, ratio, 30, 30);

		save = new FlxSave();
		save.bind("tuxcoding");
		if (save.data.lastUnlocked == null) {
			// no savegame found, init save date
			save.data.lastUnlocked = 0;
		}

		Log.trace("save.lastUnlocked: "+save.data.lastUnlocked);
	}
}
