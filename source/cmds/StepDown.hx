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
 * make the character jump down from a crate in the same column
 */
class StepDown extends Cmd
{
	
	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Bool
	{
		world.player.stepDown();
		return false;
	}
	
	override public function canRun():Bool 
	{
		var player:Player = world.player;

		// player must be standing over a crate
		var obj:TileObj = world.getObject(player.tileX, player.tileY+1);
		if (obj == null || !Std.is(obj, Crate)) return false;

		// on the target tile, the player shouldn't be over an empty tile
		if (!world.insideMapAndFull(player.tileX, player.tileY+2)) return false;

		return true;
	}
	
}