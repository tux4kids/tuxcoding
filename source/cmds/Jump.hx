package cmds;

/**
 * make the character jump up or down
 */
class Jump extends Cmd
{
	private var jumpUp:Bool;
	
	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Void 
	{
		if (jumpUp)
			world.player.jumpUp();
		else
			world.player.jumpDown();
	}
	
	override public function canRun():Bool 
	{
		var player:Player = world.player;
		var tileX:Int = player.tileX + (player.facingLeft ? -1 : 1); // facing tileX

		// the player must not face the limit of the map
		if (!world.insideMap(tileX, player.tileY)) return false;
		
		if (!world.isEmpty(tileX, player.tileY) &&
			insideMapAndEmpty(tileX, player.tileY - 1))
		{
			jumpUp = true;
			return true;
		}
		else if (world.isEmpty(tileX, player.tileY) &&
				insideMapAndEmpty(tileX, player.tileY + 1) &&
				insideMapAndFull(tileX, player.tileY + 2))
		{
			jumpUp = false;
			return true;
		}
		
		return false;
	}
	
	private function insideMapAndEmpty(tileX:Int, tileY:Int):Bool
	{
		return world.insideMap(tileX, tileY) && world.isEmpty(tileX, tileY);
	}
	
	private function insideMapAndFull(tileX:Int, tileY:Int):Bool
	{
		return world.insideMap(tileX, tileY) && !world.isEmpty(tileX, tileY);
	}
	
}