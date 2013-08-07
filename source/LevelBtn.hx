/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;
import org.flixel.FlxButton;
import org.flixel.FlxSprite;

/**
 * Level Select Button, displays the level's number
 */
class LevelBtn extends FlxButton
{
	public var num (default, set):Int;
	public var locked (default, set):Bool;
	public var numStars (default, set):Int;

	public var onClick:Int -> Void = null;

	private var stars:FlxSprite;

	private function set_num(Num:Int):Int
	{
		num = Num;
		label.text = "" + (Num + 1);
		return num;
	}

	private function set_locked(Locked:Bool):Bool
	{
		locked = Locked;
		if (locked)
		{
			active = false;
			frame = 3;
			label.text = "";
		}
		else
		{
			active = true;
			frame = 0;
		}

		return locked;
	}

	private function set_numStars(NumStars:Int):Int
	{
		numStars = NumStars;
		stars.frame = numStars;

		return numStars;
	}

	public function new(Num:Int, X:Float = 0, Y:Float = 0, OnClick:Int -> Void = null) 
	{
		super(X, Y, "", _onClick);
		num = Num;
		onClick = OnClick;
		
		loadGraphic(AssetNames.LvlBtn, true, false, 92, 105);
		label.setFormat(AssetNames.LvlBtnFont, 35, 0xd2343f, "center");
		labelOffset.y = 20;

		stars = new FlxSprite().loadGraphic(AssetNames.Stars, true, false, 92, 105);
	}
	
	private function _onClick():Void {
		if (onClick != null) onClick(num);
	}

	override function updateButton():Void
	{
		super.updateButton();
		stars.x = x;
		stars.y = y;
	}

	override public function draw():Void
	{
		super.draw();
		stars.cameras = cameras;
		stars.draw();
	}
}