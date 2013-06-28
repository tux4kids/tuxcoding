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

	private var levelNum:Int;
	private var mapTilemap:FlxTilemap;
	
	private var toolbar:FlxSprite;
	private var selected:Cmd;
	
	private var program:ProgramMem;
	
	public function new(LvlNum:Int) 
	{
		super();
		levelNum = LvlNum;
	}
	
	override public function create():Void 
	{
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xffaaaaaa));
		prepareToolbar();
		add(program = new ProgramMem(430, 100));
		
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
				var cmd:Cmd = program.getSelectedCmd(FlxG.mouse);
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
					var cmd:Cmd = program.getSelectedCmd(FlxG.mouse);
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
		
		if (FlxG.keys.justPressed("R")) program.run();
		
		super.update();
	}

	function onExit() 
	{
		FlxG.switchState(new MenuState());
	}
	
}