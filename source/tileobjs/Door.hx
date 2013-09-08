/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package tileobjs;

class Door extends TileObj
{
	public function new(X:Float, Y:Float, TileX:Int, TileY:Int) 
	{
		super(X, Y-35, TileX, TileY, AssetNames.Exit);
		this.canBeWalked = true;
	}

	override public function setPos(TileX:Int, TileY:Int, mapX:Float, mapY:Float, tSize:Float) {
		super.setPos(TileX, TileY, mapX, mapY, tSize);
		y -= tSize;
	}
}