package;

import Section.SwagSection;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import DifficultyIcons;
import lime.system.System;
#if sys
import flixel.system.FlxSound;
#end
using StringTools;

class NoSongState extends MusicBeatState
{
	//backgrounds
	var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuBG.png');
	var firey:FlxSprite = new FlxSprite().loadGraphic('assets/images/Unavailable.png');
	
	override function create()
	{
		FlxG.sound.playMusic(FNFAssets.getSound('assets/music/HuhNoSongs' + TitleState.soundExt));
		bg.screenCenter();
	    add(bg);
		firey.screenCenter();
		add(firey);
		super.create();
	}
	
	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.SEVEN)
		{
			LoadingState.loadAndSwitchState(new ChartingState());
		}
	}
}
