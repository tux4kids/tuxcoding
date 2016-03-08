/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	private static inline var numLevels:Int = 10;
	private static inline var numRows:Int = 3;
	private static inline var numCols:Int = 5;

	private var numScreens:Int;
	public var curScreen (default, set):Int;

	private var screenIndicators:FlxGroup;
	private var leftNavigator:FlxButton;
	private var rightNavigator:FlxButton;

	private var levelBtns:FlxGroup;

	private function updateLevelButtons() {
		// update level button numbers
		for (r in 0...numRows) {
			for (c in 0...numCols) {
				var lvlNum = r * numCols + c + curScreen * (numRows*numCols);
				var lvlBtn:LevelBtn = cast(levelBtns.members[r*numCols + c], LevelBtn);
				if (lvlBtn != null) {
					lvlBtn.num = lvlNum;
					lvlBtn.visible = lvlBtn.active = lvlNum < numLevels;
					// locked, numStars should be loaded/saved from player progress
					lvlBtn.locked = lvlNum > ProjectClass.lastUnlocked;
					lvlBtn.numStars = ProjectClass.getStars(lvlNum);
				}
			}
		}
	}

	private function set_curScreen(cs:Int):Int
	{
		cast(screenIndicators.members[curScreen], FlxSprite).animation.frameIndex = 0;
		curScreen = cs;
		cast(screenIndicators.members[curScreen], FlxSprite).animation.frameIndex = 1;

		leftNavigator.visible = leftNavigator.active = curScreen > 0;

		rightNavigator.visible = rightNavigator.active = curScreen < numScreens-1;

		updateLevelButtons();

		return curScreen;
	}

	override public function create():Void
	{
		numScreens = Math.ceil(numLevels/(numRows*numCols));
		
		add(new FlxSprite(0, 0, AssetNames.Background));
		
		// level select window centered on screen
		var window:FlxSprite = new FlxSprite(0,0, AssetNames.LevelSelectWindow);
		window.x = (FlxG.width - window.width)/2;
		window.y = (FlxG.height - window.height)/2;
		add(window);

		// level select title
		add(new FlxText(window.x+30, window.y+10, 200, "LEVEL SELECT")
			.setFormat(AssetNames.TextFont, 32, 0xd1535e));
		
		if (numScreens > 1)
		{
			// screen navigation buttons
			leftNavigator = new FlxButton(0,0, "", onNavigateLeft);
			leftNavigator.loadGraphic(AssetNames.ScreenNavigationBtn, true, 93, 105);
			leftNavigator.x = window.x - leftNavigator.width/2;
			leftNavigator.y = window.y + window.height/2 - leftNavigator.height/2;
			leftNavigator.facing = FlxObject.LEFT;
			add(leftNavigator);

			rightNavigator = new FlxButton(0,0, "", onNavigateRight);
			rightNavigator.loadGraphic(AssetNames.ScreenNavigationBtn, true, 93, 105);
			rightNavigator.x = window.x + window.width - rightNavigator.width/2;
			rightNavigator.y = window.y + window.height/2 - rightNavigator.height/2;

			add(rightNavigator);
		}

		// level buttons
		var pad:Int = 10;
		var allWidth:Int = numCols * 100 + (numCols - 1) * pad;
		var allHeight:Int = numRows * 100 + (numRows - 1) * pad;
		var left:Int = Std.int((FlxG.width - allWidth) / 2);
		var top:Int = Std.int((FlxG.height - allHeight) / 2);
		
		add(levelBtns = new FlxGroup());
		for (r in 0...numRows) {
			for (c in 0...numCols) {
				var lvlNum = r * numCols + c;
				if (lvlNum < numLevels)
					levelBtns.add(new LevelBtn(lvlNum, left + (100 + pad) * c, top + (100 + pad) * r, onStart));
			}
		}

		if (numScreens > 1)
		{
			//screen indicators
			add(screenIndicators = new FlxGroup());
			pad = 13;
			var indWidth:Int = 26;
			var indHeight:Int = 30;
			allWidth = numScreens * indWidth + (numScreens - 1)*pad;
			left = Std.int((FlxG.width - allWidth) / 2);
			top = Std.int(window.y + window.height - indHeight - 50);

			for (screen in 0...numScreens)
			{
				screenIndicators.add(new FlxSprite(left + (indWidth+pad)*screen, top)
					.loadGraphic(AssetNames.LevelScreenIndicator, true, indWidth, indHeight));
			}

			curScreen = 0;
		} else {
			updateLevelButtons();
		}

		super.create();
	}
	
	function onStart(btnNum:Int) 
	{
		FlxG.switchState(new PlayState(btnNum));
	}

	function onNavigateLeft()
	{
		if (curScreen > 0) curScreen--;
	}

	function onNavigateRight()
	{
		if (curScreen < numScreens-1) curScreen++;
	}

}