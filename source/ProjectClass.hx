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
	
class ProjectClass extends FlxGame
{	
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
	}
}
