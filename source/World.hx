/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;
import org.flixel.FlxTilemap;
import org.flixel.util.FlxPoint;
import tileobjs.Coin;
import tileobjs.TileObj;

/**
 * contains all information needed by a Cmd
 */
class World
{
	public var player(default, null):Player;
	public var map(default, null):FlxTilemap;
	public var startPos(default, null):FlxPoint;
	public var endPos(default, null):FlxPoint;
	public var objects(default, null):Array<TileObj>;
	public var numCoins (default, null):Int;

	public function new(player:Player, map:FlxTilemap, objs:Array<TileObj>, Start:FlxPoint, End:FlxPoint) 
	{
		this.player = player;
		this.map = map;
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
		player.setPos(Std.int(startPos.x), Std.int(startPos.y), 
			map.x + (startPos.x + .5) * PlayState.TileSize,
			map.y + (startPos.y + 1) * PlayState.TileSize);	
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
		if (tileX < 0 || tileX >= map.widthInTiles) return false;
		if (tileY < 0 || tileY >= map.heightInTiles) return false;
		return true;
	}
	
	public function isEmpty(tileX:Int, tileY:Int):Bool
	{
		if (map.getTile(tileX, tileY) != 0 ) return false;
		var obj = getObject(tileX, tileY);
		return obj == null;
	}
	
	public function canWalkOn(tileX:Int, tileY:Int):Bool
	{
		if (map.getTile(tileX, tileY) != 0 ) return false;
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