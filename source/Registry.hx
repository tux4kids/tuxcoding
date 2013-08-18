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
import haxe.xml.Fast;

class Registry
{
	private static var initialized:Bool = false;
	public static var xmlMaps:Array<Fast>;
	
	public static function init() 
	{
		if (initialized) return;

		var xml = Xml.parse(Assets.getText("assets/levels/tuxcoding.dam"));

		var fast = new Fast(xml.firstElement());
		var group = fast.node.layers.node.group;
		xmlMaps = new Array<Fast>();
		for (map in group.nodes.maplayer) {
			xmlMaps.push(map);
		}
		
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