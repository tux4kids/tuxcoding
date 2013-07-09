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
	
}