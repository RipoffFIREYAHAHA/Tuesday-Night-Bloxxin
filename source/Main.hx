package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
#if sys
import flixel.system.FlxSound;
import sys.io.File;
import haxe.io.Path;
import openfl.utils.ByteArray;
import lime.media.AudioBuffer;
import flash.media.Sound;
import sys.FileSystem;
import Song.SwagSong;
#end
#if typebuild
import plugins.ExamplePlugin;
import plugins.ExamplePlugin.ExampleCharPlugin;
#end
class Main extends Sprite
{
	#if sys
	public static var cwd:String;
	#end
	
	var CustomOptions = CoolUtil.parseJson(FNFAssets.getJson("Options"));
	var allowShitTexts:Bool = true;
	
	public function new()
	{
		allowShitTexts = CustomOptions.ShowFPSandAllThatStuff;
		
		#if typebuild
			// god is dead
			ExamplePlugin;
			ExampleCharPlugin;
		#end
		super();
		#if sys
		cwd = Sys.getCwd();
		#end
		addChild(new FlxGame(0, 0, TitleState, 1, OptionsHandler.options.fpsCap, OptionsHandler.options.fpsCap, true));
		
		#if !mobile
		if (allowShitTexts)
		{
		addChild(new FPS(10, 3, 0xFFFFFF));
		addChild(new MemoryCounter(10, 3, 0xFFFFFF));
		}
		#end
	}
}
