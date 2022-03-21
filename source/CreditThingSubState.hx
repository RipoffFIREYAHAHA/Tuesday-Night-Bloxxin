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

class CreditThingSubState extends MusicBeatSubstate
{
	//variables \/
	
	var PermCard:FlxSprite;
	public static var SongName:String = "";
	public static var ComposerName:String = "";
	public static var OriginName:String = "";
	public static var PermissionID:Int = 0;
	var PermissionName:String = "";
	
	var SongTXT:FlxText = new FlxText(115 - 395, 78, 255, "", 14);
	var ComposerTXT:FlxText = new FlxText(110 - 395, 96, 260, "", 14);
	var OriginTXT:FlxText = new FlxText(85 - 395, 116, 285, "", 14);
	var PermissionTXT:FlxText = new FlxText(119 - 395, 134, 251, "", 14);
	
	var txtXPREV:Float = 0;
	var PermXA:Float = -950;
	var PermXB:Float = -395;
	
	var TheWholeThing:FlxTypedGroup<FlxText>;
	
	//variables /\
	
	function arrangeIT()
	{
		PermCard.y += 92;
		
		TheWholeThing.forEach(function(spr:FlxText)
		{
			spr.y += 92;
		});
	}

	public function new() //CreateStuff
	{
		super();
		PermCard = new FlxSprite(PermXB, 45).loadGraphic('assets/images/MenuUI/PermissionCard.png');
		add(PermCard);
		TheWholeThing = new FlxTypedGroup<FlxText>();
		add(TheWholeThing);
		
		SongTXT.setFormat("assets/fonts/funkin.otf", 16, FlxColor.WHITE, LEFT);
		SongTXT.y -= 6.8;
		SongTXT.text = SongName;
		SongTXT.ID = 0;
		TheWholeThing.add(SongTXT);
		
		ComposerTXT.setFormat("assets/fonts/funkin.otf", 16, FlxColor.WHITE, LEFT);
		ComposerTXT.y -= 6.8;
		ComposerTXT.text = ComposerName;
		ComposerTXT.ID = 1;
		TheWholeThing.add(ComposerTXT);
		
		OriginTXT.setFormat("assets/fonts/funkin.otf", 16, FlxColor.WHITE, LEFT);
		OriginTXT.y -= 6.8;
		OriginTXT.text = OriginName;
		OriginTXT.ID = 2;
		TheWholeThing.add(OriginTXT);
		
		switch CreditThingSubState.PermissionID
		{
		case 1:
			PermissionName = "InGame Music";
			
		case 2:
			PermissionName = "Free to use";
			
		case 3:
			PermissionName = "Reuse Allowed";
		}
		
		PermissionTXT.setFormat("assets/fonts/funkin.otf", 16, FlxColor.WHITE, LEFT);
		PermissionTXT.y -= 6.8;
		PermissionTXT.text = PermissionName;
		PermissionTXT.ID = 3;
		TheWholeThing.add(PermissionTXT);
		
		PermCard.x = PermXA;
		FlxTween.tween(PermCard, {x:PermXB}, 0.6, {ease: FlxEase.backIn});
		
		TheWholeThing.forEach(function(spr:FlxText)
		{
			txtXPREV = spr.x;
			spr.x -= 950;
			FlxTween.tween(spr, {x:txtXPREV}, 0.6, {ease: FlxEase.backIn});
		});
		
		new FlxTimer().start(5, function(tmr:FlxTimer)
		{
		FlxTween.tween(PermCard, {x:PermXA}, 0.6, {ease: FlxEase.backIn, onComplete: finished});
		
		TheWholeThing.forEach(function(spr:FlxText)
		{
			txtXPREV -= 950;
			FlxTween.tween(spr, {x:txtXPREV}, 0.6, {ease: FlxEase.backIn});
		});
		});
		
		arrangeIT();
		
		/*if (FlxG.sound.music != null) {
			// cuck lunchbox
			FlxG.sound.music.stop();
		}
		
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/koolkats' + TitleState.soundExt, 5);
		*/
	}
	
	function finished(tween:FlxTween):Void
{
    close();
}

	override function update(elapsed:Float) //UpdatesStuff
	{
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
