/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;

import flixel.FlxSprite;

class CmdIcon extends FlxSprite
{
	public static var Size:Int = 60;
	
	public var type(default, set_type) : Int;
	
	private function set_type(t:Int):Int {
		animation.frameIndex = t + 1;		
		return type = t;		
	}
	
	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		loadGraphic(AssetNames.Cmds, true);
		type = -1;
		scale.x = Size / width;
		scale.y = Size / height;
		//origin.make();
		antialiasing = true;
	}
}