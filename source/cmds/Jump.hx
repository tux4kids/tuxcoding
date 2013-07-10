package cmds;

/**
 * make the character jump up or down
 */
class Jump extends Cmd
{

	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Void 
	{
		world.player.jumpUp();
	}
	
	override public function canRun():Bool 
	{
		// can jump up if :
		// player faces a filled tile
		// the tile above the filled tile exists and is empty
		var player:Player = world.player;
		var tileX:Int = player.tileX + (player.facingLeft ? -1 : 1); // facing tileX
		
		if (!world.insideMap(tileX, player.tileY - 1)) return false;
		if (!world.isEmpty(tileX, player.tileY - 1)) return false;
		return !world.isEmpty(tileX, player.tileY);
	}
	
}