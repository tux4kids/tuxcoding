package ;

import org.flixel.FlxSprite;

/**
 * ...
 * @author haden
 */
class Coin extends FlxSprite
{

	public var tileX(default, null):Int;
	public var tileY(default, null):Int;
	
	public function new(X:Float, Y:Float, TileX:Int, TileY:Int) 
	{
		super(X, Y, AssetNames.Coin);
		tileX = TileX;
		tileY = TileY;
	}
	
}