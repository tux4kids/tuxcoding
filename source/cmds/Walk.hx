package cmds;

/**
 * make the character walk forward if nothing blocks it's way
 */
class Walk extends Cmd
{

	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Void 
	{
		world.player.walk();
	}
	
}