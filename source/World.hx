/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;
import org.flixel.FlxSprite;
import org.flixel.util.FlxPoint;
import tileobjs.Coin;
import tileobjs.TileObj;

/**
 * contains all information needed by a Cmd
 */
class World
{
	private var playState:PlayState;

	public var player (get, null):Player;
	public var startPos (default, null):FlxPoint;
	public var endPos (default, null):FlxPoint;
	public var objects (default, null):Array<TileObj>;
	public var numCoins (default, null):Int;

	public function get_player():Player {
		return playState.player;
	}

	public function new(playState:PlayState, objs:Array<TileObj>, Start:FlxPoint, End:FlxPoint) 
	{
		this.playState = playState;
		startPos = Start;
		endPos = End;
		objects = objs;

		// count number of coins in level
		for (obj in objects)
		{
			if (Std.is(obj, Coin)) numCoins++;
		}
	}
	
	public function restart():Void
	{
		player.setPos(Std.int(startPos.x), Std.int(startPos.y));
		player.restart();
		
		for (obj in objects) 
		{
			obj.visible = true;
		}
	}

	/**
	 * checks if the tile is inside the map boundaries
	 * @param	tileX
	 * @param	tileY
	 * @return true if inside, false otherwise
	 */
	public function insideMap(tileX:Int, tileY:Int):Bool
	{
		if (tileX < 0 || tileX >= playState.mapData[0].length) return false;
		if (tileY < 0 || tileY >= playState.mapData.length) return false;
		return true;
	}
	
	public function isEmpty(tileX:Int, tileY:Int):Bool
	{
		if (playState.mapData[tileY][tileX] != 0 ) return false;
		var obj = getObject(tileX, tileY);
		return obj == null;
	}
	
	public function canWalkOn(tileX:Int, tileY:Int):Bool
	{
		if (playState.mapData[tileY][tileX] != 0 ) return false;
		var obj = getObject(tileX, tileY);
		return obj == null || obj.canBeWalked;
	}
	
	public function insideMapAndEmpty(tileX:Int, tileY:Int):Bool
	{
		return insideMap(tileX, tileY) && isEmpty(tileX, tileY);
	}
	
	public function insideMapAndFull(tileX:Int, tileY:Int):Bool
	{
		return insideMap(tileX, tileY) && !isEmpty(tileX, tileY);
	}
	
	public function getObject(tileX:Int, tileY:Int):TileObj
	{
		for (obj in objects) {
			if (obj.visible && obj.tileX == tileX && obj.tileY == tileY) 
				return obj;
		}
		
		return null;
	}
	
}