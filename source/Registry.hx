package ;
import org.ivar.leveltools.DameLevel;
import nme.Assets;

/**
 * ...
 * @author haden
 */
class Registry
{
	private static var initialized:Bool = false;
	
	public static var level:DameLevel;
	
	public static function init() 
	{
		if (initialized) return;
		
		level = DameLevel.loadLevel(
			Assets.getText(AssetNames.LevelsXML), // XML file exported from DAME
			"assets/levels/", // directory where we saved .dam
			false // add the level to the state when loaded
		);
		
		initialized = true;
	}
	
}