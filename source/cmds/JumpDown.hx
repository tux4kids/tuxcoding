/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package cmds;

/**
 * make the character jump down
 */
class JumpDown extends Cmd
{
	
	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Bool
	{
		world.player.jumpDown();
		return false;
	}
	
	override public function canRun():Bool 
	{
		var player:Player = world.player;
		// coordinates of destination of the jump
		var tileX:Int = player.tileX + (player.facingLeft ? -3 : 3); // facing tileX
		var tileY:Int = player.tileY + 1;
		
		return (world.insideMapAndEmpty(tileX, tileY) && world.insideMapAndFull(tileX, tileY+1));
	}
	
	
}