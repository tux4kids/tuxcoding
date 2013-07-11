package ;
import org.flixel.FlxObject;
import org.flixel.FlxTilemap;
import org.flixel.FlxPoint;

/**
 * contains all information needed by a Cmd
 */
class World
{
	public var player(default, null):Player;
	public var map(default, null):FlxTilemap;
	public var startPos(default, null):FlxPoint;
	
	public function new(player:Player, map:FlxTilemap, startX:Int, startY:Int) 
	{
		this.player = player;
		this.map = map;
		startPos = new FlxPoint(startX, startY);
	}
	
	public function reset():Void
	{
		player.setPos(Std.int(startPos.x), Std.int(startPos.y), 
			map.x + (startPos.x + .5) * PlayState.TileSize,
			map.y + (startPos.y + 1) * PlayState.TileSize);	
		player.facing = FlxObject.RIGHT;
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
		return map.getTile(tileX, tileY) == 0;
	}
	
}