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
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.utils.Assets;
import openfl.Assets;
import flixel.tweens.FlxEase;
import DifficultyIcons;
import lime.system.System;
#if sys
import flixel.system.FlxSound;
import haxe.io.Path;
import openfl.utils.ByteArray;
import lime.media.AudioBuffer;
import flash.media.Sound;
import sys.FileSystem;
import flash.system.System;
#end
using StringTools;

class ArtsState extends MusicBeatState
{
	//backgrounds
	var rarrow:FlxSprite = new FlxSprite(1220, 300).loadGraphic('assets/images/MenuUI/arrow.png');
	var larrow:FlxSprite = new FlxSprite(-8, 300).loadGraphic('assets/images/MenuUI/arrow.png');
	
	var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/MenuUI/Arts/backgroundart.png');
	var artgroup:FlxTypedGroup<FlxSprite>;
	var curArt:Int = 0;
	var artinfo:Array<String> = Assets.getText('assets/images/MenuUI/Arts/artinfo.txt').split('\n');
	var artpallete:Array<String> = Assets.getText('assets/images/MenuUI/Arts/artcolor.txt').split('\n');
	var stringplaceholder:Int = 0;
	var theinfo:FlxText = new FlxText(23, 520, 1230, "", 30);
	
	override function create()
	{
		if (FlxG.sound.music != null) {
			// cuck lunchbox
			FlxG.sound.music.stop();
		}
		
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/koolkats' + TitleState.soundExt, 5);
		
	trace("Setting BG");
		add(bg);
		
		artgroup = new FlxTypedGroup<FlxSprite>();
		add(artgroup);
		
		checkcoolarts();
		clearall();
	    checkarts();
		
		theinfo.font = "assets/fonts/funkin.otf";
		theinfo.color = FlxColor.WHITE;
		theinfo.alignment = "center";
		add(theinfo);
		
		add(rarrow);
		larrow.flipX = true;
		add(larrow);
		
		theinfo.text = artinfo[curArt];
		stringplaceholder = Std.parseInt("0xFF" + artpallete[curArt]);
		bg.color = stringplaceholder;
		
		super.create();
	}
	
	function clearall()
	{
		artgroup.forEach(function (spr:FlxSprite)
		{
			spr.alpha = 0;
		});
	}
	
	function checkarts()
	{
		artgroup.forEach(function (spr:FlxSprite)
		{
			if (spr.ID == curArt)
			spr.alpha = 1;
		});
	}
	
	function checkcoolarts(arts:String = "assets/images/MenuUI/Arts/coolart/")
	{
		var checkfiles:Int = 0;
		if (sys.FileSystem.exists(arts)) {
    trace("arts found: " + arts);
	for (file in FileSystem.readDirectory(arts))
	{
		checkfiles++;
		trace("amount of arts:" + checkfiles);
    } 
	
	for (i in 0...checkfiles)
	{
		trace("creating art");
		var art:FlxSprite = new FlxSprite().loadGraphic('assets/images/MenuUI/Arts/coolart/Art' + i + '.png');
		art.scale.set(0.6, 0.6);
		art.updateHitbox();
		art.ID = i;
		art.screenCenter();
		art.y -= 90;
		art.antialiasing = true;
		trace("art created, current ID:" + art.ID);
		artgroup.add(art);
		trace("art number " + art.ID + " has join the group");
    } 
	}else {
    trace('"$arts" does not exists');
    }
	}
	
	function checkthestuf(bitch:Int = 0)
	{
		FlxG.sound.play('assets/sounds/hitSound' + TitleState.soundExt);
		curArt += bitch;
		
		clearall();
		
		if (curArt >= artgroup.length)
		curArt = 0;
		if (curArt < 0)
		curArt = artgroup.length - 1;
		
		checkarts();
		
		artgroup.forEach(function(spr:FlxSprite)
		{
			var thing:Float = spr.y;
			spr.y -= 10;
			FlxTween.tween(spr, {y: thing}, 0.02);
			trace(spr.y);
	    });
		
		theinfo.text = artinfo[curArt];
		stringplaceholder = Std.parseInt("0xFF" + artpallete[curArt]);
		bg.color = stringplaceholder;
	}

	override function update(elapsed:Float)
	{	
		super.update(elapsed);
		
		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			if (FlxG.mouse.visible == true)
		    FlxG.mouse.visible = false;
			// main menu or else we are cursed
			LoadingState.loadAndSwitchState(new MainMenuState());
		}
		
		if (controls.ACCEPT)
		{
			switch curArt
			{
			case 3:
			FlxG.sound.play('assets/sounds/selectfile' + TitleState.soundExt);
			PlayState.storyDifficulty = 2;
			PlayState.SONG = Song.loadFromJson("infectious royale/infectious royale-hard");
			LoadingState.loadAndSwitchState(new PlayState());
			
		    case 6:
			FlxG.sound.play('assets/sounds/selectfile' + TitleState.soundExt);
			FlxG.openURL("https://store.steampowered.com/app/1228610/KARLSON/");
			}
		}
		
		if (controls.LEFT_MENU)
		checkthestuf(-1);
		if (controls.RIGHT_MENU)
		checkthestuf(1);
		
		if (controls.RIGHT_MENU_H)
		rarrow.alpha = 0.5;
		else
		rarrow.alpha = 1;
		
		if (controls.LEFT_MENU_H)
		larrow.alpha = 0.5;
		else
		larrow.alpha = 1;
	}
}
