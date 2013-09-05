/*
 * Copyright 2013 Tux4Kids 
 * Distributed under the terms of the MIT License. 
 * 
 * Author(s): 
 * Abdelhakim Deneche 
 */

package;

import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import haxe.Log;

class TitleState extends FlxState
{

	private var logo:FlxSprite;

	private static inline var credits:String = "A Tux4Kids Game\nGSoC'2013\nProgramming:\nAbdelhakim Deneche\nMentored by:\nScott McCreary";

	override public function create():Void
	{
		#if !mobile
		FlxG.mouse.show();
		#end

		Registry.init();
		
		add(new FlxSprite(0, 0, AssetNames.Background));
		add(logo = new FlxSprite(20, 0, AssetNames.Tux));
		logo.y = FlxG.height - logo.height;
		
		add(new FlxText(0, 20, FlxG.width, credits).setFormat(AssetNames.TextFont, 32, 0xd2343f, "center"));

		var title:FlxSprite = new FlxSprite(0,0, AssetNames.GameTitle);
		title.x = (FlxG.width - title.width)/2;
		title.y = (FlxG.height - title.height)/2;
		add(title);

		var playBtn:FlxButton = new FlxButton(0, 0, "", onStart);
		playBtn.loadGraphic(AssetNames.PlayBtn, true, 93, 105);
		playBtn.x = (FlxG.width - playBtn.width)/2;
		playBtn.y = FlxG.height * 2/3;
		add(playBtn);

		add(new FlxText(10, 10, 100, ProjectClass.version).setFormat(null, 16, 0xffffff));
		
		FlxG.camera.antialiasing = true;

		super.create();
	}
	
	function onStart() 
	{
		FlxG.switchState(new MenuState());
	}

}