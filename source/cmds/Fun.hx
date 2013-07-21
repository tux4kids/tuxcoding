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

	private var cmds:Array<Cmd>;
	private var curCmd:Int;
	private var running:Bool;
	
	public function new(world:World) 
	{
		super(world);
	}
	
	override public function run():Bool
	{
		if (!running)
		{
			cmds = program.getCommands();
			curCmd = 0;
			if (cmds.length > 0) {
				runCmd();
				running = true;
			}
		} 
		else
		{
			runCmd();
		}
		
		return running;
	}
	
	function runCmd() 
	{
		var canRun:Bool = cmds[curCmd].canRun();
		if (canRun)
		{
			if (!cmds[curCmd].run())
				curCmd++;
		}
		
		if (!canRun || curCmd == cmds.length)
		{
			// program ended
			running = false;
		}
	}
	
}