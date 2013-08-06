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
import org.flixel.FlxObject;
import flash.ui.Mouse;

class MenuState extends FlxState
{
	override public function create():Void
	{
		#if !mobile
		FlxG.mouse.show();
		#end

		Registry.init();
		
		add(new FlxSprite(0, 0, AssetNames.Background));
		
		// level select window centered on screen
		var window:FlxSprite = new FlxSprite(0,0, AssetNames.LevelSelectWindow);
		window.x = (FlxG.width - window.width)/2;
		window.y = (FlxG.height - window.height)/2;
		add(window);

		// level select title
		add(new FlxText(window.x+30, window.y+10, 200, "LEVEL SELECT")
			.setFormat(AssetNames.LvlBtnFont, 32, 0xd1535e));
		
		// screen navigation buttons
		var leftBtn:FlxButton = new FlxButton(0,0);
		leftBtn.loadGraphic(AssetNames.ScreenNavigationBtn, true, true, 60, 68);
		leftBtn.x = window.x - leftBtn.width/2;
		leftBtn.y = window.y + window.height/2 - leftBtn.height/2;
		add(leftBtn);

		var rightBtn:FlxButton = new FlxButton(0,0);
		rightBtn.loadGraphic(AssetNames.ScreenNavigationBtn, true, true, 60, 68);
		rightBtn.x = window.x + window.width - rightBtn.width/2;
		rightBtn.y = window.y + window.height/2 - rightBtn.height/2;
		rightBtn.facing = FlxObject.LEFT; //TODO update button graphics to match flixel facing
		add(rightBtn);

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

		add(new FlxText(10, 10, 100, "V. 0.2.7").setFormat(null, 16, 0xffffff));
		
		FlxG.camera.antialiasing = true;

		super.create();
	}
	
	function onStart(btnNum:Int) 
	{
		FlxG.switchState(new PlayState(btnNum));
	}

}