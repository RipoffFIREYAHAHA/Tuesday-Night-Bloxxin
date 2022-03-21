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
import flixel.effects.FlxFlicker;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.graphics.frames.FlxAtlasFrames;
import lime.utils.Assets;
import DifficultyIcons;
import lime.system.System;
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
import tjson.TJSON;
using StringTools;

class RushModeState extends MusicBeatState
{
	//variables \/
	
	var RushIcon:FlxSprite = new FlxSprite(323, 39).loadGraphic('assets/images/MenuUI/RushMode/RushIcon.png');
	var bg:FlxSprite;
	var SongsAmount:FlxText = new FlxText(515, 441, 255, "", 64);
	var TextSongs:FlxText = new FlxText(515, 300, 255, "amount of songs", 64);
	var AmountOfSongs:Int = 1;
	var arrowr:FlxSprite = new FlxSprite();
	var arrowl:FlxSprite = new FlxSprite();
	var play:FlxSprite = new FlxSprite(0, 585);
	
	//variables /\
	
	override function create() //CreateStuff
	{
		bg = new FlxSprite();
	    bg.loadGraphic('assets/images/MenuUI/Freeplay/BG.png');
		add(bg);
		
		RushIcon.antialiasing = true;
		RushIcon.screenCenter(X);
		add(RushIcon);
		
		SongsAmount.setFormat("assets/fonts/funkin.otf", 72, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		SongsAmount.screenCenter(X);
		add(SongsAmount);
		
		TextSongs.setFormat("assets/fonts/funkin.otf", 42, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		TextSongs.screenCenter(X);
		add(TextSongs);
		
		arrowr = new FlxSprite(723, 430).loadGraphic('assets/images/MenuUI/arrow.png');
		arrowr.antialiasing = true;
		
		arrowl = new FlxSprite(485, 430).loadGraphic('assets/images/MenuUI/arrow.png');
		arrowl.antialiasing = true;
		arrowl.flipX = true;
		
		add(arrowl);
		add(arrowr);
		
		play.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/Storymode/UI/Normal/Play.png', 'assets/images/MenuUI/Storymode/UI/Normal/Play.xml');
		play.animation.addByPrefix('idle', "play", 6);
		play.screenCenter(X);
		play.animation.play('idle');
		play.scrollFactor.set();
		play.antialiasing = true;
		add(play);
		
		/*if (FlxG.sound.music != null) {
			// cuck lunchbox
			FlxG.sound.music.stop();
		}
		
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/koolkats' + TitleState.soundExt, 5);
		*/
		
		super.create();
	}
	
	var SongFiles:Array<String> = Assets.getText('assets/images/MenuUI/RushMode/RushSongs.txt').split(',');
	var AmountNowHuh:Array<String> = [];

	override function update(elapsed:Float) //UpdatesStuff
	{
		if (AmountOfSongs < 1)
		AmountOfSongs = 1;
		
		SongsAmount.text = Std.string(AmountOfSongs);
		
		if (controls.LEFT_MENU)
		{
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
		AmountOfSongs--;
		}
		
		if (controls.RIGHT_MENU)
		{
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
		AmountOfSongs++;
		}
		
		if (controls.BACK)
		LoadingState.loadAndSwitchState(new FreeplayState());
		
		if (controls.RIGHT_MENU_H)
		{
		    arrowr.alpha = 0.5;
		} else
		{
			arrowr.alpha = 1;
		}
		
		if (controls.LEFT_MENU_H)
		{
		    arrowl.alpha = 0.5;
		} else
		{
			arrowl.alpha = 1;
		}
		
		if (controls.ACCEPT)
		{
			FlxG.sound.play('assets/sounds/confirmMenu' + TitleState.soundExt);
			FlxFlicker.flicker(play, 1.1, 0.15, false);
			for (i in 0...AmountOfSongs)
			{
			AmountNowHuh.push(SongFiles[Std.random(SongFiles.length)]);
			}
			
			trace(SongFiles);
			RushScoreState.scoreAmout = 0;
			RushScoreState.missesAmout = 0;
			RushScoreState.sicksAmount = 0;
			
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
			PlayState.storyPlaylist = AmountNowHuh;
	        PlayState.defaultPlaylistLength = AmountNowHuh.length;
	     	PlayState.storyDifficulty = 2;
			PlayState.isStoryMode = true;
	        ModifierState.isStoryMode = true;
			PlayState.storyWeek = 0;
		    PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + "-hard", PlayState.storyPlaylist[0].toLowerCase());
		    PlayState.campaignScore = 0;
		    PlayState.campaignAccuracy = 0;
			PlayState.isRushMode = true;
			LoadingState.loadAndSwitchState(new PlayState());
			});
		}
		
		super.update(elapsed);
	}
	
	override public function beatHit():Void  //follows the beat
	{
		super.beatHit();
	}
	
	//variable templates:
	/*
	Sprite_Var: var Sprite:FlxSprite = new FlxSprite().loadGraphic('assets/images/MenuUI/Target.png');
	 */
}
