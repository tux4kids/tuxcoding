/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package cmds;
import tileobjs.Lock;
import tileobjs.TileObj;

/**
 * if the character has a key and the facing tile contains a lock, it will unlock it
 */
class Unlock extends Cmd
{
	private var lock:Lock;
	
	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Void 
	{
		world.player.unlock(lock);
	}
	
	override public function canRun():Bool 
	{
		lock = null;
		
		var player:Player = world.player;
		if (!player.hasKey) return false;
		
		var tileX:Int = player.tileX + (player.facingLeft ? -1 : 1);
		
		if (!world.insideMap(tileX, player.tileY)) return false;
		
		var obj:TileObj = world.getObject(tileX, player.tileY);
		if (obj != null && Std.is(obj, Lock)) 
			lock = cast(obj, Lock);
			
		return lock != null;
	}
}