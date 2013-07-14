package tileobjs;

class Lock extends TileObj
{
	public function new(X:Float, Y:Float, TileX:Int, TileY:Int) 
	{
		super(X, Y, TileX, TileY, AssetNames.Lock);
	}
}