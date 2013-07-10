package ;

import org.flixel.FlxButton;
import org.flixel.FlxG;
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
	public inline static var PlayerTile:Int = 14;
	public inline static var TileSize:Int = 35;
	
	private var levelNum:Int;
	private var mapTilemap:FlxTilemap;
	
	private var toolbar:FlxSprite;
	public var selected:CmdIcon;
	
	private var runBtn:FlxButton;
	
	private var program:ProgramGui;
	
	private var player:Player;
	
	private var world:World;
	
	public function new(LvlNum:Int) 
	{
		super();
		levelNum = LvlNum;
	}
	
	override public function create():Void 
	{
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xffaaaaaa));
		
		var mapName:String = "Map" + (levelNum + 1);

		mapTilemap = Registry.level.getTilemap(mapName);
		mapTilemap.x = 10;
		mapTilemap.y = 10;
		
		add(mapTilemap);

		initPlayer();
		
		world = new World(player, mapTilemap);
		
		var exitBtn:FlxButton;
		add(exitBtn = new FlxButton(FlxG.width/2 - 80, FlxG.height - 110, null, onExit));
		exitBtn.loadGraphic(AssetNames.ExitBtn, true, false, 75, 75);

		add(runBtn = new FlxButton(FlxG.width/2 + 5, FlxG.height - 110, null, onRun));
		runBtn.loadGraphic(AssetNames.RunBtn, true);

		prepareToolbar();
		add(program = new ProgramGui(world, 430, 100));
		
		add(selected = new CmdIcon());
		selected.visible = false;
		
		super.create();
	}
	
	private function initPlayer():Void
	{
		add(player = new Player());
		var startIndex:Int = -1;
		var startR:Int = -1;
		var startC:Int = -1;
		
		// find starting position
		for (r in 0...mapTilemap.heightInTiles) {
			for (c in 0...mapTilemap.widthInTiles) {
				var index = r * mapTilemap.widthInTiles + c;
				if (mapTilemap.getTileByIndex(index) == PlayerTile) {
					startIndex = index;
					startR = r;
					startC = c;
				}
			}
		}
		
		if (startIndex == -1) {
			throw "Error, map doesn't contain a starting position";
			return;
		}

		player.setPos(startC, startR, 
			mapTilemap.x + (startC + .5) * TileSize,
			mapTilemap.y + (startR + 1) * TileSize);
		mapTilemap.setTileByIndex(startIndex, 0);
	}
	
	private function prepareToolbar():Void 
	{
		toolbar = new FlxSprite();
		var cmd:CmdIcon = new CmdIcon();
		
		toolbar.makeGraphic(Std.int(CmdIcon.Size * CmdIcon.NumCmds), Std.int(CmdIcon.Size), 0x00000000);
		for (i in 0...CmdIcon.NumCmds) {
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
		if (!program.running)
		{
			if (selected.visible) 
			{
				if (!FlxG.mouse.pressed()) 
				{
					// did the player drop the command over the program's memory ?
					var cmd:CmdIcon = program.getSelectedCmd(FlxG.mouse);
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
						selected.type = Std.int( (FlxG.mouse.x - toolbar.x) / CmdIcon.Size);
						selected.visible = true;
					}
					else 
					{
						// did the player click over the program's memory
						var cmd:CmdIcon = program.getSelectedCmd(FlxG.mouse);
						if (cmd != null)
						{
							selected.type = cmd.type;
							selected.visible = true;
							cmd.type = -1;
						}
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

	function onExit() 
	{
		FlxG.switchState(new MenuState());
	}
	
	function onRun() 
	{
		if (program.run(onRunEnd)) {
			runBtn.active = false;
			runBtn.frame = 3;
		}
	}
	
	function onRunEnd()
	{
		runBtn.active = true;
		runBtn.frame = 0;
	}
}