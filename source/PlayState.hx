package ;

import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxTilemap;

/**
 * Main game state
 * @author haden
 */
class PlayState extends FlxState
{
	private inline static var memory_numRows:Int = 2;
	private inline static var memory_numCols:Int = 5;

	private var levelNum:Int;
	private var mapTilemap:FlxTilemap;
	
	private var program:FlxGroup;
	private var memory:FlxSprite;
	private var toolbar:FlxSprite;
	private var selected:Cmd;
	
	public function new(LvlNum:Int) 
	{
		super();
		levelNum = LvlNum;
	}
	
	override public function create():Void 
	{
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xffaaaaaa));
		prepareToolbar();
		prepareMemory();
		
		add(selected = new Cmd());
		selected.visible = false;
		
		var mapName:String = "Map" + (levelNum + 1);

		mapTilemap = Registry.level.getTilemap(mapName);
		mapTilemap.x = 10;
		mapTilemap.y = 10;
		
		add(mapTilemap);
		
		var exitBtn:FlxButton;
		add(exitBtn = new FlxButton((FlxG.width-75)/2, FlxG.height - 110, null, onExit));
		exitBtn.loadGraphic(AssetNames.ExitBtnBg, true, false, 75, 75);
		
		super.create();
	}
	
	private function prepareToolbar():Void 
	{
		toolbar = new FlxSprite();
		var cmd:Cmd = new Cmd();
		
		toolbar.makeGraphic(Std.int(cmd.width * Cmd.NumCmds), Std.int(cmd.height), 0x00000000);
		for (i in 0...Cmd.NumCmds) {
			cmd.type = i;
			toolbar.stamp(cmd, Std.int(i * cmd.width), 0);
		}
		
		toolbar.x = FlxG.width - toolbar.width - 10;
		toolbar.y = 10;
		add(toolbar);
	}
	
	private function prepareMemory():Void 
	{
		memory = new FlxSprite();
		program = new FlxGroup();
		
		memory.makeGraphic(Std.int(Cmd.Size * memory_numCols), Std.int(Cmd.Size * memory_numRows), 0x00000000);
		memory.x = FlxG.width - memory.width - 10;
		memory.y = toolbar.y + toolbar.height + 50;
		add(memory);

		for (r in 0...memory_numRows) {
			for (c in 0...memory_numCols) {
				program.add(new Cmd(memory.x + Cmd.Size * c, memory.y + Cmd.Size * r));
			}
		}
		
		
		add(program);
	}
	
	override public function destroy():Void 
	{
		remove(mapTilemap);
		super.destroy();
	}
	
	override public function update():Void 
	{
		if (selected.visible) 
		{
			if (!FlxG.mouse.pressed()) 
			{
				// did the player drop the command over the program's memory ?
				var cmd:Cmd = getOverlappedProgramCmd(FlxG.mouse);
				if (cmd != null) 
				{
					cmd.type = selected.type;
				}

				selected.visible = false;
			}
		} 
		else 
		{
			if (FlxG.mouse.justPressed()) 
			{
				// did the player click over the toolbar ?
				if (toolbar.overlapsPoint(FlxG.mouse))
				{
					// find which command was selected
					selected.type = Std.int( (FlxG.mouse.x - toolbar.x) / Cmd.Size);
					selected.visible = true;
				}
				else 
				{
					// did the player click over the program's memory
					var cmd:Cmd = getOverlappedProgramCmd(FlxG.mouse);
					if (cmd != null)
					{
						selected.type = cmd.type;
						selected.visible = true;
						cmd.type = -1;
					}
				}
			}
		}
		
		if (selected.visible) {
			selected.x = FlxG.mouse.x - selected.width / 2;
			selected.y = FlxG.mouse.y - selected.height / 2;
		}
		super.update();
	}
	
	/**
	 * Finds which program's command is under the mouse
	 * @param	X x-coordinate of the mouse
	 * @param	Y y-coordinate of the mouse
	 * @return overlaped cmd or null if no command found
	 */
	private function getOverlappedProgramCmd(point:FlxPoint):Cmd 
	{
		
		if (!memory.overlapsPoint(point)) return null;

		var c:Int = Std.int( Math.floor((point.x - memory.x) / Cmd.Size));
		var r:Int = Std.int( Math.floor((point.y - memory.y) / Cmd.Size));
		var index:Int = (r * memory_numCols + c);
		
		return cast(program.members[index], Cmd);
	}
	
	function onExit() 
	{
		FlxG.switchState(new MenuState());
	}
	
}