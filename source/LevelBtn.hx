/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;
import org.flixel.FlxButton;

/**
 * Level Select Button, displays the level's number
 */
class LevelBtn extends FlxButton
{
	public var num (default, set):Int;

	public var onClick:Int -> Void = null;

	private function set_num(Num:Int):Int
	{
		num = Num;
		label.text = "Level " + (Num + 1);
		return num;
	}

	public function new(Num:Int, X:Float = 0, Y:Float = 0, OnClick:Int -> Void = null) 
	{
		super(X, Y, "", _onClick);
		num = Num;
		onClick = OnClick;
		
		loadGraphic(AssetNames.LvlBtn, true, false, 100, 100);
		label.setFormat(AssetNames.LvlBtnFont, 25, 0, "center");
		labelOffset.y = (100 - 25) / 2;
	}
	
	private function _onClick():Void {
		if (onClick != null) onClick(num);
	}
}