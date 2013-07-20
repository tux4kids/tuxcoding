/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package cmds;

import tileobjs.Coin;
import tileobjs.TileObj;

/**
 * take a coin/key if it's in the same tile of the player
 */
class Take extends Cmd
{
	private var obj:TileObj;
	
	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Bool
	{
		world.player.take(obj);
		return false;
	}
	
	override public function canRun():Bool 
	{
		var player:Player = world.player;
		
		obj = world.getObject(player.tileX, player.tileY);
		if (!obj.canBeTaken) obj = null;
		
		return obj != null;
	}
}