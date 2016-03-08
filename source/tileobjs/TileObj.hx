/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package tileobjs;

import flixel.FlxSprite;

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
		//origin.make();
		tileX = TileX;
		tileY = TileY;
	}

	public function setPos(TileX:Int, TileY:Int, mapX:Float, mapY:Float, tSize:Float) {
		tileX = TileX;
		tileY = TileY;

		x = mapX + tileX*tSize;
		y = mapY + tileY*tSize;
	}
	
}