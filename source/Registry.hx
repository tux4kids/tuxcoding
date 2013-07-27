/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;

import openfl.Assets;
import org.flixel.FlxTilemap;

class Registry
{
	private static var initialized:Bool = false;
	
	public static function init() 
	{
		if (initialized) return;
		
		initialized = true;
	}
	
	public static function getTilemap(mapName: String):FlxTilemap
	{
		var tilemap:FlxTilemap = new FlxTilemap();
		var mapData:String = Assets.getText("assets/levels/tuxcoding/mapCSV_levels_" + mapName + ".csv");
		tilemap.loadMap(mapData, AssetNames.Tiles);
		return tilemap;
	}
	
}