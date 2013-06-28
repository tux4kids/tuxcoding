package ;

import org.flixel.FlxGroup;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

/**
 * ...
 * @author haden
 */
class ProgramMem extends FlxGroup
{
	private inline static var memory_numRows:Int = 2;
	private inline static var memory_numCols:Int = 5;

	private var memory:FlxSprite;

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(memory_numRows * memory_numCols);
		
		// memory is just used to test mouse overlap
		memory = new FlxSprite(X, Y);
		memory.makeGraphic(Std.int(Cmd.Size * memory_numCols), Std.int(Cmd.Size * memory_numRows), 0x00000000);

		for (r in 0...memory_numRows) {
			for (c in 0...memory_numCols) {
				add(new Cmd(memory.x + Cmd.Size * c, memory.y + Cmd.Size * r));
			}
		}
	}
	
	/**
	 * Finds which program's command is under the mouse
	 * @param	X x-coordinate of the mouse
	 * @param	Y y-coordinate of the mouse
	 * @return overlaped cmd or null if no command found
	 */
	public function getSelectedCmd(point:FlxPoint):Cmd 
	{
		if (!memory.overlapsPoint(point)) return null;

		var c:Int = Std.int( Math.floor((point.x - memory.x) / Cmd.Size));
		var r:Int = Std.int( Math.floor((point.y - memory.y) / Cmd.Size));
		var index:Int = (r * memory_numCols + c);
		
		return cast(members[index], Cmd);
	}
	
	public function run():Void 
	{
		for (obj in members) {
			var cmd:Cmd = cast(obj, Cmd);
			if (cmd != null && cmd.type != -1) cmd.run();
		}
	}
	
}