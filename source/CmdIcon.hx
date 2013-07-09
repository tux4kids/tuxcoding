package ;

import org.flixel.FlxSprite;

class CmdIcon extends FlxSprite
{
	public inline static var NumCmds:Int = 4;
	public inline static var Size:Int = 40;
	
	public var type(default, set_type) : Int;
	
	private function set_type(t:Int):Int {
		frame = t + 1;		
		return type = t;		
	}
	
	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		loadGraphic(AssetNames.Cmds, true, false);
		type = -1;
	}
	
}