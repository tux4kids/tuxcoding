/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package tileobjs;

import org.flixel.FlxSprite;

/**
 * basic tile object.
 */
class TileObj extends FlxSprite
{

	public var tileX(default, null):Int;
	public var tileY(default, null):Int;
	public var canBeTaken(default, set):Bool;
	public var canBeWalked(default, set):Bool;
	
	private function set_canBeWalked(walked:Bool):Bool {
		canBeWalked = walked;
		return walked;
	}

	private function set_canBeTaken(taken:Bool):Bool {
		canBeTaken = taken;
		return taken;
	}
	
	public function new(X:Float, Y:Float, TileX:Int, TileY:Int, SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		tileX = TileX;
		tileY = TileY;
	}
	
}