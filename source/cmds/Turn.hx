package cmds;

/**
 * make the character change it's facing direction
 */
class Turn extends Cmd
{

	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Void 
	{
		world.player.turn();
	}
	
}