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
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
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

class RushScoreState extends MusicBeatState
{
	//variables \/
	
	public static var scoreAmout:Int = 0;
	public static var missesAmout:Int = 0;
	public static var sicksAmount:Int = 0;
	
	var scoreReveal:Int = 0;
	var missesReveal:Int = 0;
	var sicksReveal:Int = 0;
	
	var scoreTXT:FlxText = new FlxText(0, 40, 1231, "", 64);
	var missesTXT:FlxText = new FlxText(0, 189, 1231, "", 64);
	var sicksTXT:FlxText = new FlxText(0, 338, 1231, "", 64);
	var pressAny:FlxText = new FlxText(0, 541, 1231, "Press any key to Exit", 64);
	
	//variables /\
	
	override function create() //CreateStuff
	{
		scoreTXT.setFormat("assets/fonts/scoreboard.ttf", 62, FlxColor.ORANGE, CENTER);
		scoreTXT.screenCenter(X);
		add(scoreTXT);
		
		missesTXT.setFormat("assets/fonts/scoreboard.ttf", 62, FlxColor.ORANGE, CENTER);
		missesTXT.screenCenter(X);
		add(missesTXT);
		
		sicksTXT.setFormat("assets/fonts/scoreboard.ttf", 62, FlxColor.ORANGE, CENTER);
		sicksTXT.screenCenter(X);
		add(sicksTXT);
		
		pressAny.setFormat("assets/fonts/scoreboard.ttf", 45, FlxColor.ORANGE, CENTER);
		pressAny.screenCenter(X);
		pressAny.alpha = 0;
		add(pressAny);
		
		if (FlxG.sound.music != null) {
			FlxG.sound.music.stop();
		}
		
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/breaktime' + TitleState.soundExt, 5);
		
		super.create();
	}

	var isFinishCounting:Bool = false;
	
	override function update(elapsed:Float) //UpdatesStuff
	{
		scoreTXT.text = "Score:" + Std.string(scoreReveal);
		missesTXT.text = "Misses:" + Std.string(missesReveal);
		sicksTXT.text = "Sicks:" + Std.string(sicksReveal);
		
		if (scoreReveal < RushScoreState.scoreAmout)
		{
			FlxG.sound.play('assets/sounds/pixelText' + TitleState.soundExt);
			scoreReveal += 200;
		}
		
		if (scoreReveal > RushScoreState.scoreAmout)
		{
			FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
			scoreReveal = RushScoreState.scoreAmout;
		}
		
		if (scoreReveal == RushScoreState.scoreAmout)
		{
			if (missesReveal < RushScoreState.missesAmout)
		{
			FlxG.sound.play('assets/sounds/pixelText' + TitleState.soundExt);
			missesReveal += 2;
		}
		
		if (missesReveal > RushScoreState.missesAmout)
		{
			FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
			missesReveal = RushScoreState.missesAmout;
		}
		//MISSES DONE
		if (missesReveal == RushScoreState.missesAmout)
		{
			if (sicksReveal < RushScoreState.sicksAmount)
		{
			FlxG.sound.play('assets/sounds/pixelText' + TitleState.soundExt);
			sicksReveal += 2;
		}
		
		if (sicksReveal > RushScoreState.sicksAmount)
		{
			FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
			isFinishCounting = true;
			pressAny.alpha = 1;
			sicksReveal = RushScoreState.sicksAmount;
		}
		}
		
		}
		
		if (sicksReveal == RushScoreState.sicksAmount && !isFinishCounting)
		{
			isFinishCounting = true;
			pressAny.alpha = 1;
		}
		
		if (FlxG.keys.justPressed.ANY)
		{
			if (isFinishCounting)
			LoadingState.loadAndSwitchState(new RushModeState());
			
			if (!isFinishCounting)
			{
				FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
				scoreReveal = RushScoreState.scoreAmout;
			    missesReveal = RushScoreState.missesAmout;
				sicksReveal = RushScoreState.sicksAmount;
				pressAny.alpha = 1;
				isFinishCounting = true;
			}
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
