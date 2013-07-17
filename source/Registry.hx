/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;
import org.ivar.leveltools.DameLevel;
import nme.Assets;

class Registry
{
	private static var initialized:Bool = false;
	
	public static var level:DameLevel;
	
	public static function init() 
	{
		if (initialized) return;
		
		reloadLevels();
		
		initialized = true;
	}
	
	public static function reloadLevels():Void
	{
		level = DameLevel.loadLevel(
			Assets.getText(AssetNames.LevelsXML), // XML file exported from DAME
			"assets/levels/", // directory where we saved .dam
			false // add the level to the state when loaded
		);
	}
	
}