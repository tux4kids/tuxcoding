/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package;

import nme.Lib;
import org.flixel.FlxGame;
	
class ProjectClass extends FlxGame
{	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		var ratioX:Float = stageWidth / 1024;
		var ratioY:Float = stageHeight / 600;
		var ratio:Float = Math.min(ratioX, ratioY);
		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), MenuState, ratio, 30, 30);
	}
}
