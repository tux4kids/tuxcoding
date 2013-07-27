/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;

import org.flixel.FlxObject;
import org.flixel.FlxPath;
import org.flixel.util.FlxPoint;
import org.flixel.FlxSprite;
import tileobjs.Key;
import tileobjs.Lock;
import tileobjs.TileObj;
import tileobjs.Coin;

class Player extends FlxSprite
{
	private var walkingDist:Float;
	
	public var idle(get, null):Bool;
	public var tileX(default, null):Int;
	public var tileY(default, null):Int;
	public var facingLeft(get, null):Bool;
	public var numCoins(default, null):Int;
	public var hasKey(default, null):Bool;
	
	private function get_idle():Bool {
		return curAnim == null;
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
	
	public function new() 
	{
		super();

		loadGraphic(AssetNames.Player, true, true, 35, 47);
		addAnimation("idle", [0]);
		addAnimation("jump", [3]);
		addAnimation("walk", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 15);
		
		maxVelocity.y = 300;
	}
	
	public function setPos(TileX:Int, TileY:Int, Xcenter:Float, Ybottom:Float):Void {
		x = Xcenter - width / 2;
		y = Ybottom - height;
		
		tileX = TileX;
		tileY = TileY;
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
		curAnim = "walk";
		velocity.x = facingLeft ? -50 : 50;
		walkingDist = PlayState.TileSize;
		
		tileX += facingLeft ? -1:1;
	}
	
	public function jumpUp():Void
	{
		curAnim = "jump";
		var ts:Float = PlayState.TileSize;
		followPath(new FlxPath([
			new FlxPoint(x + width * .5 + (facingLeft ? -ts:ts), y + height * .5 - ts)]));

		tileX += facingLeft ? -1:1;
		tileY--;
	}
	
	public function jumpDown():Void
	{
		curAnim = "jump";
		var ts:Float = PlayState.TileSize;
		followPath(new FlxPath([
			new FlxPoint(x + width * .5 + (facingLeft ? -ts:ts), y + height * .5 + ts)]));

		tileX += facingLeft ? -1:1;
		tileY++;
	}
	
	override public function update():Void 
	{
		var oldx:Float = x;
		super.update();
		if (curAnim == "walk")
			walkingDist -= Math.abs(x - oldx);

		if (curAnim == "walk")
		{
			if (walkingDist <= 0) {
				curAnim = "idle";
				velocity.x = 0;
				if (walkingDist < 0)
				{
					// make sure we don't walk more than walkingDist
					x += facing == FlxObject.LEFT ? -walkingDist : walkingDist;
				}
			}
		}
		else if (curAnim == "jump")
		{
			if (pathSpeed == 0) curAnim = "idle";
		}
	}

}