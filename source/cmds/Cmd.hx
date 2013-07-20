/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package cmds;

class Cmd
{
	public inline static var NumCmds:Int = 6;

	public var active:Bool; // true is this command is part of the program
	
	public var isRunning(get_running, null):Bool;
	
	private var world:World;
	
	public function new(world:World) 
	{
		active = true;
		this.world = world;
	}
	
	/**
	 * @return true if the command is still running (probably a function)
	 */
	public function run():Bool {
		throw "Cmd.run() not implemented";
		return false;
	}
	
	public function canRun():Bool {
		return true;
	}
	
	private function get_running():Bool {
		return !world.player.idle;
	}
		
	public static function getCmdClass(type:Int):Class<Cmd> {
		switch (type) {
			case 0:
				return Walk;
			case 1:
				return Turn;
			case 2:
				return Jump;
			case 3:
				return Take;
			case 4:
				return Unlock;
			case 5:
				return Fun;
			default:
				return null;
		}
	}

}