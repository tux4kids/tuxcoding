package cmds;

/**
 * take a coin/key if it's in the same tile of the player
 */
class Take extends Cmd
{
	private var coin:Coin;
	
	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Void 
	{
		world.player.take(coin);
	}
	
	override public function canRun():Bool 
	{
		var player:Player = world.player;
		
		coin = world.getCoin(player.tileX, player.tileY);
		return coin != null;
	}
}