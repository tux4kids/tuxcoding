package ;
import org.flixel.FlxButton;

/**
 * Level Select Button, displays the level's number
 * 
 * @author haden
 */
class LevelBtn extends FlxButton
{
	public var num:Int;
	public var onClick:Int -> Void = null;
	public function new(Num:Int, X:Float = 0, Y:Float = 0, OnClick:Int -> Void = null) 
	{
		super(X, Y, "Level " + (Num + 1), _onClick);
		num = Num;
		onClick = OnClick;
		
		loadGraphic(AssetNames.LvlBtn, true, false, 100, 100);
		label.setFormat(AssetNames.LvlBtnFont, 25, 0, "center");
		labelOffset.y = (100 - label.height) / 2;
	}
	
	private function _onClick():Void {
		if (onClick != null) onClick(num);
	}
}