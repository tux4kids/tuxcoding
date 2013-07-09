package ;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

class ProgramGui extends FlxGroup
{
	private inline static var memory_numRows:Int = 2;
	private inline static var memory_numCols:Int = 5;

	private var memory:FlxSprite;

	private var playState:PlayState;
	private var onEnd:Void -> Void; // callback to be called at the end of the execution of this program
	public var running:Bool;

	private var cmds:Array<CmdIcon>;
	private var curCmd:Int;
	private var curTime:Float;
	
	public function new(playState:PlayState, X:Float = 0, Y:Float = 0) 
	{
		super(memory_numRows * memory_numCols);
		
		this.playState = playState;
		
		// memory is just used to test mouse overlap
		memory = new FlxSprite(X, Y);
		memory.makeGraphic(Std.int(CmdIcon.Size * memory_numCols), Std.int(CmdIcon.Size * memory_numRows), 0x00000000);

		for (r in 0...memory_numRows) {
			for (c in 0...memory_numCols) {
				add(new CmdIcon(memory.x + CmdIcon.Size * c, memory.y + CmdIcon.Size * r));
			}
		}
	}
	
	/**
	 * Finds which program's command is under the mouse
	 * @param	X x-coordinate of the mouse
	 * @param	Y y-coordinate of the mouse
	 * @return overlaped cmd or null if no command found
	 */
	public function getSelectedCmd(point:FlxPoint):CmdIcon
	{
		if (!memory.overlapsPoint(point)) return null;

		var c:Int = Std.int( Math.floor((point.x - memory.x) / CmdIcon.Size));
		var r:Int = Std.int( Math.floor((point.y - memory.y) / CmdIcon.Size));
		var index:Int = (r * memory_numCols + c);
		
		return cast(members[index], CmdIcon);
	}
/*	
	public function run(OnEnd:Void -> Void = null):Void 
	{
		onEnd = OnEnd;
		
		cmds = [];
		for (obj in members) {
			var cmd:Cmd = cast(obj, Cmd);
			if (cmd != null && cmd.type != -1) cmds.push(cmd);
		}
		curCmd = 0;
		runCmd();
		running = true;
	}
	
	function runCmd() 
	{
		if (curCmd == cmds.length)
		{
			// program ended
			running = false;
			if (onEnd != null) onEnd();
		}
		else
		{
			cmds[curCmd].run(playState);
			curCmd++;
			curTime = 1;
		}
	}
*/	
	override public function update():Void
	{
		//if (running)
		//{
			//curTime -= FlxG.elapsed;
			//if (curTime <= 0)
			//{
				// time to run next command
				//runCmd();
			//}
		//}
	}
	
}