/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package;

import flash.geom.Rectangle;
import flash.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import flash.ui.Mouse;

class MenuState extends FlxState
{
	override public function create():Void
	{
		Registry.init();
		
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		
		#if !mobile
		FlxG.mouse.show();
		#end
		
		var numLevels:Int = 10;
		var numRows:Int = 2;
		var numCols:Int = 5;
		var pad:Int = 10;

		var allWidth:Int = numCols * 100 + (numCols - 1) * pad;
		var allHeight:Int = numRows * 100 + (numRows - 1) * pad;
		var left:Int = Std.int((FlxG.width - allWidth) / 2);
		var top:Int = Std.int((FlxG.height - allHeight) / 2);
		
		for (r in 0...numRows) {
			for (c in 0...numCols) {
				var lvlNum = r * numCols + c;
				if (lvlNum < numLevels)
					add(new LevelBtn(lvlNum, left + (100 + pad) * c, top + (100 + pad) * r, onStart));
			}
		}

		add(new FlxText(10, 10, 100, "Version 0.2.7").setFormat(null, 16, 0xffffff));
		
		FlxG.camera.antialiasing = true;

		super.create();
	}
	
	function onStart(btnNum:Int) 
	{
		FlxG.switchState(new PlayState(btnNum));
	}

}