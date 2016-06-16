/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;

import flixel.FlxObject;
import flixel.util.FlxPath;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import tileobjs.Key;
import tileobjs.Lock;
import tileobjs.TileObj;
import tileobjs.Coin;

class Player extends FlxSprite
{
	private var playState:PlayState;

	private var walkingDist:Float;
	
	public var idle(get, null):Bool;
	public var tileX(default, null):Int;
	public var tileY(default, null):Int;
	public var facingLeft(get, null):Bool;
	public var numCoins(default, null):Int;
	public var hasKey(default, null):Bool;
	
	private function get_idle():Bool {

		return animation.curAnim == null;
	}
	
	private function get_facingLeft():Bool {
		return facing == FlxObject.LEFT;
	}
	
	public function restart():Void
	{
		facing = FlxObject.RIGHT;
		numCoins = 0;
		hasKey = false;
	}
	
	public function new(playState:PlayState) 
	{
		super();
		this.playState = playState;

		loadGraphic(AssetNames.Player, true, 67, 94);
		animation.add("idle", [0]);
		maxVelocity.y = 300;
		//origin.make();
	}
	
	public function setPos(TileX:Int, TileY:Int):Void {
		tileX = TileX;
		tileY = TileY;

		var Xcenter = playState.mapSprite.x + (tileX + .5) * playState.tileSize;
		var Ybottom = playState.mapSprite.y + (tileY + 1) * playState.tileSize;

		x = Xcenter - width*scale.x/2;
		y = Ybottom - height*scale.y;
	}
	
	/**
	 * Change player facing (left/right)
	 */
	public function turn():Void
	{
		facing = facingLeft ? FlxObject.RIGHT : FlxObject.LEFT;
	}
	
	public function take(obj:TileObj):Void
	{
		if (Std.is(obj, Coin)) 
		{
			numCoins++;
			obj.visible = false;
		} else if (Std.is(obj, Key))
		{
			hasKey = true;
			obj.visible = false;
		}
	}
	
	public function unlock(lock:Lock):Void
	{
		hasKey = false;
		lock.visible = false;
	}
	
	public function walk():Void 
	{
		x += facing == FlxObject.LEFT ? -playState.tileSize : playState.tileSize;
		
		tileX += facingLeft ? -1:1;
	}
	
	public function jumpUp():Void
	{
		x += facing == FlxObject.LEFT ? -playState.tileSize*3 : playState.tileSize*3;
		y -= playState.tileSize;

		tileX += facingLeft ? -3:3;
		tileY--;
	}
	
	public function stepUp():Void
	{
		y -= playState.tileSize;
		tileY--;
	}
	
	public function stepDown():Void
	{
		y += playState.tileSize;
		tileY++;
	}
	
	public function jumpDown():Void
	{
		x += facing == FlxObject.LEFT ? -playState.tileSize*3 : playState.tileSize*3;
		y += playState.tileSize;

		tileX += facingLeft ? -3:3;
		tileY++;
	}

}