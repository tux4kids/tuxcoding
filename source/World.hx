package ;
import org.flixel.FlxTilemap;

/**
 * contains all information needed by a Cmd
 */
class World
{
	public var player(default, null):Player;
	public var map(default, null):FlxTilemap;
	
	public function new(player:Player, map:FlxTilemap) 
	{
		this.player = player;
		this.map = map;
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