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
	
}