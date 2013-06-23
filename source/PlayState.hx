package ;

import org.flixel.FlxButton;
import org.flixel.FlxState;
import org.flixel.FlxTilemap;
import org.ivar.leveltools.DameLevel;
import nme.Assets;
import org.flixel.FlxG;
import nme.Lib;

/**
 * ...
 * @author haden
 */
class PlayState extends FlxState
{
	private var levelNum:Int;
	private var mapTilemap:FlxTilemap;
	
	public function new(LvlNum:Int) {
		super();
		
		levelNum = LvlNum;
	}
	
	override public function create():Void 
	{
		var mapName:String = "Map" + (levelNum + 1);

		mapTilemap = Registry.level.getTilemap(mapName);
		mapTilemap.x = (FlxG.width - mapTilemap.width) / 2;
		mapTilemap.y = 10;
		
		add(mapTilemap);
		
		var exitBtn:FlxButton;
		add(exitBtn = new FlxButton((FlxG.width-75)/2, FlxG.height - 110, null, onExit));
		exitBtn.loadGraphic(AssetNames.ExitBtnBg, true, false, 75, 75);
		
		super.create();
	}
	
	override public function destroy():Void 
	{
		remove(mapTilemap);
		super.destroy();
	}
	
	function onExit() 
	{
		FlxG.switchState(new MenuState());
	}
	
}