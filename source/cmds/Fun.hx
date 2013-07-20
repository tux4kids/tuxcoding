/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package cmds;
import org.flixel.FlxG;

/**
 * calls another function (multiple commands)
 */
class Fun extends Cmd
{
	public static var program:ProgramGui;
	
	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Bool
	{
		if (!program.running)
		{
			program.run();
		} 
		else
		{
			program.runCmd();
		}
		
		return program.running;
	}
	
}