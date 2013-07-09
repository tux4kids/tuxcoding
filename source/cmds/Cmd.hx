package cmds;
import org.flixel.FlxG;

/**
 * ...
 * @author haden
 */
class Cmd
{
	public var active:Bool; // true is this command is part of the program
	
	public var isRunning(get_running, null):Bool;
	
	private var world:World;
	
	public function new(world:World) 
	{
		active = true;
		this.world = world;
	}
	
	public function run():Void {
		throw "Cmd.run() not implemented";
	}
	
	public function get_running():Bool {
		return !world.player.idle;
	}
		
	public static function getCmdClass(type:Int):Class<Cmd> {
		FlxG.log("cmd type: " + type);
		switch (type) {
			case 0:
				return Walk;
			case 1:
				return Turn;
			case 2:
				return Jump;
			default:
				return null;
		}
	}

}