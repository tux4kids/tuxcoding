/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package ;

import openfl.Assets;
import haxe.xml.Fast;

class Registry
{
	private static var initialized:Bool = false;
	public static var xmlMaps:Array<Fast>;
	
	public static var numLevels (get, null) : Int;

	private static function get_numLevels():Int {
		return xmlMaps.length;
	}
	
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
	
	public static function getMapDataString(mapNum:Int):String
	{
		// extract map data from xml file
		var map = xmlMaps[mapNum];
		var mapData:String = "";
		for (row in map.nodes.row) {
			mapData += row.innerData + "\n";
		}

		return mapData;
	}
	
	public static function getMapData(mapNum:Int):Array<Array<Int>>
	{
		// extract map data from xml file
		var map = xmlMaps[mapNum];
		var mapData:Array<Array<Int>> = [];

		var rInd = 0;
		for (row in map.nodes.row) {
			var rowData:Array<String> = StringTools.trim(row.innerData).split(",");
			mapData[rInd] = [];

			var cInd = 0;
			for (col in rowData) {
				mapData[rInd][cInd] = Std.parseInt(rowData[cInd]);
				cInd++;
			}

			rInd++;
		}

		return mapData;
	}
	
}