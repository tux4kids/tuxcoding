/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;

import cmds.Cmd;
import cmds.Fun;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTilemap;
import org.flixel.system.input.FlxTouch;
import org.flixel.util.FlxPoint;
import tileobjs.Coin;
import tileobjs.Key;
import tileobjs.Lock;
import tileobjs.TileObj;

/**
 * Main game state
 */
class PlayState extends FlxState
{
	public inline static var PlayerTile:Int = 14;
	public inline static var CoinTile:Int = 15;
	public inline static var KeyTile:Int = 16;
	public inline static var LockTile:Int = 17;
	public inline static var TileSize:Int = 35;
	
	private var levelNum:Int;
	private var mapTilemap:FlxTilemap;
	private var objects:FlxGroup;
	
	private var toolbar:FlxSprite;
	public var selected:CmdIcon;
	
	private var runBtn:FlxButton;
	
	private var program:ProgramGui;
	private var fun1:ProgramGui;
	
	private var player:Player;
	
	private var world:World;
	
	private var _point:FlxPoint;
	
	public function new(LvlNum:Int) 
	{
		super();
		levelNum = LvlNum;
		_point = new FlxPoint();
	}
	
	override public function create():Void 
	{
		add(new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xffaaaaaa));
		
		var mapName:String = "Map" + (levelNum + 1);

		mapTilemap = Registry.getTilemap(mapName);
		mapTilemap.x = (FlxG.width - mapTilemap.width) / 2;
		mapTilemap.y = 10;
		
		add(mapTilemap);
		add(player = new Player());
		add(objects = new FlxGroup());

		initWorld();
		
		var exitBtn:FlxButton;
		add(exitBtn = new FlxButton(FlxG.width - 100, 350, null, onExit));
		exitBtn.loadGraphic(AssetNames.ExitBtn, true, false, 75, 75);

		add(runBtn = new FlxButton(FlxG.width - 100, 450, null, onRun));
		runBtn.loadGraphic(AssetNames.RunBtn, true);

		prepareToolbar(10, 310);
		
		add(new FlxText(10, 360, 100, "Main:").setFormat(null, 16, 0));
		add(program = new ProgramGui(world, 3, 8, 10, 380));

		add(new FlxText(400, 360, 110, "Function 1:").setFormat(null, 16, 0));
		add(fun1 = new ProgramGui(world, 3, 8, 400, 380));
		fun1.active = false; // don't call update() automatically
		
		add(selected = new CmdIcon());
		selected.visible = false;
		
		Fun.program = fun1;
		
		super.create();
	}
	
	private function initWorld():Void
	{
		var startR:Int = -1;
		var startC:Int = -1;
		var objs:Array<TileObj> = [];
		
		// find starting position and coins
		for (r in 0...mapTilemap.heightInTiles) {
			for (c in 0...mapTilemap.widthInTiles) {
				var index = r * mapTilemap.widthInTiles + c;
				var tile = mapTilemap.getTileByIndex(index);
				var clean = false;
				if (tile == PlayerTile) {
					startR = r;
					startC = c;
					clean = true;
				} else if (tile == CoinTile) {
					var coin = new Coin(mapTilemap.x + c * TileSize, mapTilemap.y + r * TileSize, c, r);
					objects.add(coin);
					objs.push(coin);
					clean = true;
				} else if (tile == KeyTile) {
					var key = new Key(mapTilemap.x + c * TileSize, mapTilemap.y + r * TileSize, c, r);
					objects.add(key);
					objs.push(key);
					clean = true;
				} else if (tile == LockTile) {
					var lock = new Lock(mapTilemap.x + c * TileSize, mapTilemap.y + r * TileSize, c, r);
					objects.add(lock);
					objs.push(lock);
					clean = true;
				}
				
				if (clean)
					mapTilemap.setTileByIndex(index, 0);
			}
		}
		
		if (startR == -1) {
			throw "Error, map doesn't contain a starting position";
			return;
		}

		world = new World(player, mapTilemap, objs, startC, startR);
		world.restart();
	}
	
	private function prepareToolbar(X:Float, Y:Float):Void 
	{
		toolbar = new FlxSprite(X, Y);
		var cmd:CmdIcon = new CmdIcon();
		
		toolbar.makeGraphic(Std.int(CmdIcon.Size * Cmd.NumCmds), Std.int(CmdIcon.Size), 0x00000000);
		for (i in 0...Cmd.NumCmds) {
			cmd.type = i;
			toolbar.stamp(cmd, Std.int(i * cmd.width), 0);
		}

		add(toolbar);
	}
	
	override public function destroy():Void 
	{
		remove(mapTilemap);
		super.destroy();
	}
	
	override public function update():Void 
	{
		var mp:Bool = false;
		var mjp:Bool = false;
		
		#if mobile
			var touch:FlxTouch = FlxG.touchManager.getFirstTouch();
			if (touch != null) {
				mp = touch.pressed();
				mjp = touch.justPressed();
				_point.copyFrom(touch);
			}
		#else
			mp = FlxG.mouse.pressed();
			mjp = FlxG.mouse.justPressed();
			_point.copyFrom(FlxG.mouse);
		#end
		
		if (!program.running)
		{
			if (selected.visible) 
			{
				if (!mp) 
				{
					var cmd:CmdIcon = program.getSelectedCmd(_point);
					if (cmd == null)
						cmd = fun1.getSelectedCmd(_point);
					
					// did the player drop the command over a program or a function ?
					if (cmd != null) 
					{
						cmd.type = selected.type;
					}

					selected.visible = false;
				}
			} 
			else 
			{
				if (mjp) 
				{
					// did the player click over the toolbar ?
					if (toolbar.overlapsPoint(_point))
					{
						// find which command was selected
						selected.type = Std.int( (_point.x - toolbar.x) / CmdIcon.Size);
						selected.visible = true;
					}
					else 
					{
						// did the player click over the program's memory
						var cmd:CmdIcon = program.getSelectedCmd(_point);
						if (cmd == null)
							cmd = fun1.getSelectedCmd(_point);
							
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
			selected.x = _point.x - selected.width / 2;
			selected.y = _point.y - selected.height / 2;
		}
		
		super.update();
	}

	function onExit() 
	{
		FlxG.switchState(new MenuState());
	}
	
	function onRun() 
	{
		world.restart();

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