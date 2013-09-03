/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package cmds;

import tileobjs.TileObj;
import tileobjs.Crate;

/**
 * make the character jump up over a crate in the same column
 */
class StepUp extends Cmd
{
	
	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Bool
	{
		world.player.stepUp();
		return false;
	}
	
	override public function canRun():Bool 
	{
		var player:Player = world.player;

		// check the target tile is inside the map and empty
		if (!world.insideMapAndEmpty(player.tileX, player.tileY-1)) return false;
		
		// player's tile must contain a crate
		var obj:TileObj = world.getObject(player.tileX, player.tileY);
		if (obj != null && Std.is(obj, Crate)) return true;
		
		return false;
	}
	
}