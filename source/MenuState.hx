package;

import nme.geom.Rectangle;
import nme.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;

class MenuState extends FlxState
{
	override public function create():Void
	{
		Registry.init();
		
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		var numLevels:Int = 5;
		var pad:Int = 10;
		var left:Int = Std.int((FlxG.width - 5 * 100 - 4 * pad) / 2);
		for (i in 0...numLevels) {
			add(new LevelBtn(i, left + (100+pad)*i, FlxG.height-150, onStart));
		}
	}
	
	function onStart(btnNum:Int) 
	{
		FlxG.switchState(new PlayState(btnNum));
	}

}