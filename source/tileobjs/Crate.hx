/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package tileobjs;

class Crate extends TileObj
{
	public function new(X:Float, Y:Float, TileX:Int, TileY:Int) 
	{
		super(X, Y, TileX, TileY, AssetNames.Crate);
		this.canBeWalked = true;
	}
}