package chapters;

import Section.SwagSection;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.text.FlxText;
import flixel.addons.text.FlxTypeText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import lime.utils.Assets;
import flixel.effects.FlxFlicker;
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

class ChapterONE extends MusicBeatState
{
	//variables \/
	
	var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/MenuUI/Storymode/UI/Normal/BackBG.png');
	var rarrow:FlxSprite = new FlxSprite(1220, 300).loadGraphic('assets/images/MenuUI/Storymode/storyarrow.png');
	var larrow:FlxSprite = new FlxSprite(-8, 300).loadGraphic('assets/images/MenuUI/Storymode/storyarrow.png');
	
	//some important shit:
	var chapters:Array<String> = ['Week1', 'Week2', 'Week3'];
	var difficulties:Array<String> = ['-easy', '', '-hard', '-overchart'];
	var difficultySelect:Int = 1;
	var curWeek:Int = 0;
	var weekASongs:Array<String> = ['smiling', 'clout', 'infectious'];
	var weekBSongs:Array<String> = ['royale', 'roleplay', 'mary sue', 'march'];
	var weekCSongs:Array<String> = ['headshot', 'harsh', 'compulsion', 'tantrum'];
	
	//strings:
	var currentChapter:String = "ChapterONE";
	var weekATextSong:String = "Smiling, Clout, Infectious";
	var weekAText:String = "Just playin some Roblox";
	var weekBTextSong:String = "Royale, Roleplay, Mary Sue, March";
	var weekBText:String = "*Puts Title* *writes*";
	var weekCTextSong:String = "Headshot, Harsh, Compulsion, Tantrum";
	var weekCText:String = "Im on top of the lead! Lets gooo!!";
	
	//Layers and stuf:
	var backs:FlxTypedGroup<FlxSprite>;
	var overlays:FlxTypedGroup<FlxSprite>;
	var Allchars:FlxTypedGroup<FlxSprite>;
	var arrows:FlxTypedGroup<FlxSprite>;
	var texties:FlxTypedGroup<FlxText>;
	var allui:FlxTypedGroup<FlxSprite>;
	
	//variables /\
	
	override function create() //CreateStuff
	{
		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
			checkdate();
		}
		
		bg.antialiasing = true;
		add(bg);
		
		Allchars = new FlxTypedGroup<FlxSprite>();
		
		backs = new FlxTypedGroup<FlxSprite>();
		overlays = new FlxTypedGroup<FlxSprite>();
		arrows = new FlxTypedGroup<FlxSprite>();
		texties = new FlxTypedGroup<FlxText>();
		allui = new FlxTypedGroup<FlxSprite>();
		
		
		add(backs); //1st Layer
		add(Allchars); //2nd Layer
		add(overlays); //3rd Layer
		add(arrows); //3.5th Layer
		add(texties); //4th layer
		add(allui);
		
		larrow.flipX = true;
		
		add(rarrow);
		add(larrow);
		
		for (i in 0...chapters.length)
		{	
			var backroom:FlxSprite = new FlxSprite(37, 26).loadGraphic('assets/images/MenuUI/Storymode/' + currentChapter + '/Week' + (i + 1) + '/Back.png');
			backroom.ID = i;
			backroom.antialiasing = true;
			backroom.scrollFactor.set();
			
			var weekicon:FlxSprite = new FlxSprite(845, 57).loadGraphic('assets/images/MenuUI/Storymode/' + currentChapter + '/Week' + (i + 1) + '/Week.png');
			weekicon.ID = i;
			weekicon.antialiasing = true;
			weekicon.scrollFactor.set();
			
			var spliter:FlxSprite = new FlxSprite(0, 0);
			spliter.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/Storymode/' + currentChapter + '/Week' + (i + 1) + '/wave.png', 'assets/images/MenuUI/Storymode/' + currentChapter + '/Week' + (i + 1) + '/wave.xml');
			spliter.animation.addByPrefix('idle', "idle", 6);
			spliter.animation.play('idle');
			spliter.ID = i;
			spliter.scrollFactor.set();
			spliter.antialiasing = true;
			
			var charONE:FlxSprite = new FlxSprite(0, 0);
			charONE.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/Storymode/' + currentChapter + '/Week' + (i + 1) + '/char1.png', 'assets/images/MenuUI/Storymode/' + currentChapter + '/Week' + (i + 1) + '/char1.xml');
			charONE.animation.addByPrefix('idle', "idle", 24);
			charONE.animation.play('idle');
			charONE.ID = i;
			charONE.scrollFactor.set();
			charONE.antialiasing = true;
			
			var charTWO:FlxSprite = new FlxSprite(0, 0);
			charTWO.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/Storymode/' + currentChapter + '/Week' + (i + 1) + '/char2.png', 'assets/images/MenuUI/Storymode/' + currentChapter + '/Week' + (i + 1) + '/char2.xml');
			charTWO.animation.addByPrefix('idle', "idle", 24);
			charTWO.animation.play('idle');
			charTWO.ID = i;
			charTWO.scrollFactor.set();
			charTWO.antialiasing = true;
			
			var overlay:FlxSprite = new FlxSprite(1286 * i, 0).loadGraphic('assets/images/MenuUI/Storymode/UI/Normal/Overlay.png');
			overlay.ID = 5;
			overlay.antialiasing = true;
			overlay.scrollFactor.set();
			
			var play:FlxSprite = new FlxSprite(864, 308);
			play.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/Storymode/UI/Normal/Play.png', 'assets/images/MenuUI/Storymode/UI/Normal/Play.xml');
			play.animation.addByPrefix('idle', "play", 6);
			play.animation.play('idle');
			play.ID = 5;
			play.scrollFactor.set();
			play.antialiasing = true;
			
			var arrowUP:FlxSprite = new FlxSprite(997, 410).loadGraphic('assets/images/MenuUI/arrow.png');
			arrowUP.ID = 1;
			arrowUP.angle = -90;
			arrowUP.antialiasing = true;
			arrowUP.scrollFactor.set();
			
			var arrowDOWN:FlxSprite = new FlxSprite(997, 584).loadGraphic('assets/images/MenuUI/arrow.png');
			arrowDOWN.ID = 2;
			arrowDOWN.angle = 90;
			arrowDOWN.antialiasing = true;
			arrowDOWN.scrollFactor.set();
			
			var DiffIcon:FlxSprite = new FlxSprite(854, 518).loadGraphic('assets/images/MenuUI/Storymode/diff/normal.png');
			DiffIcon.ID = 3;
			DiffIcon.antialiasing = true;
			DiffIcon.scrollFactor.set();
			
			backs.add(backroom);
			overlays.add(spliter);
			overlays.add(overlay);
			overlays.add(weekicon);
			overlays.add(play);
			arrows.add(arrowUP);
			arrows.add(arrowDOWN);
			arrows.add(DiffIcon);
			
			Allchars.add(charONE);
			Allchars.add(charTWO);
			
			switch i
			{
				case 0:
				var textsong:FlxText = new FlxText(85, 499, 760, weekATextSong, 40);
				textsong.ID = i;
				textsong.font = "assets/fonts/funkin.otf";
				textsong.color = FlxColor.BLACK;
				texties.add(textsong);
				var textmenu:FlxText = new FlxText(0, -5, 1286, weekAText, 25);
				textmenu.ID = i;
				textmenu.font = "assets/fonts/funkin.otf";
				textmenu.color = FlxColor.WHITE;
				textmenu.alignment = "center";
				texties.add(textmenu);
				
				case 1:
				var textsong:FlxText = new FlxText(85, 499, 760, weekBTextSong, 40);
				textsong.ID = i;
				textsong.font = "assets/fonts/funkin.otf";
				textsong.color = FlxColor.BLACK;
				texties.add(textsong);
				var textmenu:FlxText = new FlxText(0, -5, 1286, weekBText, 25);
				textmenu.ID = i;
				textmenu.font = "assets/fonts/funkin.otf";
				textmenu.color = FlxColor.WHITE;
				textmenu.alignment = "center";
				texties.add(textmenu);
				
				case 2:
				var textsong:FlxText = new FlxText(85, 499, 760, weekCTextSong, 40);
				textsong.ID = i;
				textsong.font = "assets/fonts/funkin.otf";
				textsong.color = FlxColor.BLACK;
				texties.add(textsong);
				var textmenu:FlxText = new FlxText(0, -5, 1286, weekCText, 25);
				textmenu.ID = i;
				textmenu.font = "assets/fonts/funkin.otf";
				textmenu.color = FlxColor.WHITE;
				textmenu.alignment = "center";
				texties.add(textmenu);
			}
		}
		
		/*if (FlxG.sound.music != null) {
			// cuck lunchbox
			FlxG.sound.music.stop();
		}
		
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/koolkats' + TitleState.soundExt, 5);
		*/
		
		checkTrans();
		
		super.create();
	}
	
	function checkTrans()
	{
		clearall();
		overlays.forEach(function(spr:FlxSprite)
		{
			if (spr.ID == curWeek)
			spr.alpha = 1;
	    });
		
		Allchars.forEach(function(spr:FlxSprite)
		{
			if (spr.ID == curWeek)
			spr.alpha = 1;
	    });
		
		backs.forEach(function(spr:FlxSprite)
		{
			if (spr.ID == curWeek)
			spr.alpha = 1;
	    });
		
		texties.forEach(function(spr:FlxSprite)
		{
			if (spr.ID == curWeek)
			spr.alpha = 1;
	    });
	}
	
	function clearall()
	{
		overlays.forEach(function(spr:FlxSprite)
		{
			if (spr.ID != 5)
			{
			spr.alpha = 0;
			}
	    });
		
		Allchars.forEach(function(spr:FlxSprite)
		{
			spr.alpha = 0;
	    });
		
		backs.forEach(function(spr:FlxSprite)
		{
			spr.alpha = 0;
	    });
		
		texties.forEach(function(spr:FlxSprite)
		{
			spr.alpha = 0;
	    });
	}
	
	function checkdate()
	{
	//celebratin the holidays lol \/
	
	var now = Date.now();
    var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var monthName = monthNames[now.getMonth()];
    var dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saterday"];
    var dayName = dayNames[now.getDay()];
	
	//celebratin the holidays lol /\

	switch monthName
	{
	case "December":
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/merryfreakyMenu' + TitleState.soundExt, 5);
		
	case "November":
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/hallowfreakymenu' + TitleState.soundExt, 5);
		
	default:
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/freakyMenu' + TitleState.soundExt, 5);
	}
	}

	override function update(elapsed:Float) //UpdatesStuff
	{
		if (stopspamming == false)
		{
		if (controls.DOWN_MENU_H)
		{
			arrows.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 2)
				spr.alpha = 0.5;
			});
		} else
		{
			arrows.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 2)
				spr.alpha = 1;
			});
		}
		
		if (controls.UP_MENU_H)
		{
			arrows.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 1)
				spr.alpha = 0.5;
			});
		} else
		{
			arrows.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 1)
				spr.alpha = 1;
			});
		}
		
		if (controls.DOWN_MENU)
		changeDiff(-1);
		if (controls.UP_MENU)
		changeDiff(1);
		
		if (controls.ACCEPT)
		{
			pepePickWeek();
		}
		
		if (controls.BACK)
		{
			FlxG.sound.play('assets/sounds/cancelMenu' + TitleState.soundExt);
			LoadingState.loadAndSwitchState(new ChapterState());
		}
		
		if (controls.RIGHT_MENU_H)
		rarrow.alpha = 0.5;
		else
		rarrow.alpha = 1;
		
		if (controls.LEFT_MENU_H)
		larrow.alpha = 0.5;
		else
		larrow.alpha = 1;
		
		if (controls.LEFT_MENU)
		{
		changeWeeks( -1);
		changeDiff();
		moveShit();
		}
		
		if (controls.RIGHT_MENU)
		{
		changeWeeks(1);
		changeDiff();
		moveShit();
		}
		
		}
		super.update(elapsed);
	}
	
	var timeease:Float = 0.04;
	
	function moveShit()
	{
		backs.forEach(function(spr:FlxSprite)
		{
			spr.y = 16;
			FlxTween.tween(spr, {y: 26}, timeease);
	    });
		
		overlays.forEach(function(spr:FlxSprite)
		{
			if (spr.y == 0)
			{
			spr.y = -10;
			FlxTween.tween(spr, {y: 0}, timeease);
			}
			
			if (spr.y == 26)
			{
			spr.y = 16;
			FlxTween.tween(spr, {y: 26}, timeease);
			}
			
			if (spr.y == 57)
			{
			spr.y = 47;
			FlxTween.tween(spr, {y: 57}, timeease);
			}
			
			if (spr.y == 308)
			{
			spr.y = 298;
			FlxTween.tween(spr, {y: 308}, timeease);
			}
	    });
		
		Allchars.forEach(function(spr:FlxSprite)
		{
			spr.y = -10;
			FlxTween.tween(spr, {y: 0}, timeease);
	    });
		
		arrows.forEach(function(spr:FlxSprite)
		{
			if (spr.y == 410)
			{
				spr.y = 400;
			FlxTween.tween(spr, {y: 410}, timeease);
			}
			if (spr.y == 584)
			{
				spr.y = 574;
			FlxTween.tween(spr, {y: 584}, timeease);
			}
			if (spr.y == 518)
			{
				spr.y = 508;
			FlxTween.tween(spr, {y: 518}, timeease);
			}
	    });
		
		texties.forEach(function(spr:FlxSprite)
		{
			if (spr.color == FlxColor.BLACK)
			{
			spr.y = 489;
			FlxTween.tween(spr, {y: 499}, timeease);
			}
	    });
	}
	
	function changeWeeks(changed:Int = 0)
	{
		FlxG.sound.play('assets/sounds/hitSound' + TitleState.soundExt);
		curWeek += changed;
		
		if (curWeek >= chapters.length)
		curWeek = 0;
		if (curWeek < 0)
		curWeek = chapters.length - 1;
		
		checkTrans();
	}
	
	function pepePickWeek()
	{
		if (stopspamming == false)
			{
				FlxG.sound.play('assets/sounds/confirmMenu' + TitleState.soundExt);
				overlays.forEach(function(spr:FlxSprite)
			    {
				if (spr.ID == 5 && spr.y != 0)
				FlxFlicker.flicker(spr, 1.1, 0.15, false);
			    });
				
				checkweeks();
				
				new FlxTimer().start(1, function(tmr:FlxTimer)
			    {
				if (!OptionsHandler.options.skipModifierMenu)
				 	LoadingState.loadAndSwitchState(new ModifierState());
				else {
					if (FlxG.sound.music != null)
						FlxG.sound.music.stop();
					LoadingState.loadAndSwitchState(new PlayState());
				}
			});
				stopspamming = true;
			}
	}
	
	function checkweeks()
	{
		switch curWeek
		{
		case 0:
	    PlayState.storyPlaylist = weekASongs;
	    PlayState.defaultPlaylistLength = weekASongs.length;
	    PlayState.isStoryMode = true;
	    ModifierState.isStoryMode = true;
		
		PlayState.storyDifficulty = difficultySelect;
		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulties[difficultySelect], PlayState.storyPlaylist[0].toLowerCase());
	    PlayState.storyWeek = curWeek;
		PlayState.campaignScore = 0;
		PlayState.campaignAccuracy = 0;
		
		case 1:
	    PlayState.storyPlaylist = weekBSongs;
	    PlayState.defaultPlaylistLength = weekBSongs.length;
	    PlayState.isStoryMode = true;
	    ModifierState.isStoryMode = true;
		
		PlayState.storyDifficulty = difficultySelect;
		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulties[difficultySelect], PlayState.storyPlaylist[0].toLowerCase());
	    PlayState.storyWeek = curWeek;
		PlayState.campaignScore = 0;
		PlayState.campaignAccuracy = 0;
		
		case 2:
	    PlayState.storyPlaylist = weekCSongs;
	    PlayState.defaultPlaylistLength = weekCSongs.length;
	    PlayState.isStoryMode = true;
	    ModifierState.isStoryMode = true;
		
		PlayState.storyDifficulty = difficultySelect;
		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulties[difficultySelect], PlayState.storyPlaylist[0].toLowerCase());
	    PlayState.storyWeek = curWeek;
		PlayState.campaignScore = 0;
		PlayState.campaignAccuracy = 0;
		}
	}
	
	var stopspamming:Bool = false;
	
	function changeDiff(mewhen:Int = 0)
	{
		difficultySelect += mewhen;
		
		if (curWeek != 2)
		{
		if (difficultySelect > 3)
		difficultySelect = 0;
		if (difficultySelect < 0)
		difficultySelect = 3;
		}
		
		if (curWeek == 2)
		{
		if (difficultySelect <= 1)
		difficultySelect = 2;
		if (difficultySelect > 3)
		difficultySelect = 2;
		if (difficultySelect < 2)
		difficultySelect = 3;
		}
		
		checkdiff();
		
		arrows.forEach(function(spr:FlxSprite)
		{
				if (spr.ID == 3)
				{
					spr.y = 505;
					spr.alpha = 0.2;
					FlxTween.tween(spr, {y: 518, alpha: 1}, 0.02);
				}
	    });
	}
	
	function checkdiff()
	{
		switch difficultySelect
		{
			case 0:
			arrows.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 3)
				spr.loadGraphic(Paths.image('MenuUI/Storymode/diff/easy'));
			});
			
			case 1:
			arrows.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 3)
				spr.loadGraphic(Paths.image('MenuUI/Storymode/diff/normal'));
			});
			
			case 2:
			arrows.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 3)
				spr.loadGraphic(Paths.image('MenuUI/Storymode/diff/hard'));
			});
			
			case 3:
			arrows.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 3)
				spr.loadGraphic(Paths.image('MenuUI/Storymode/diff/overchart'));
			});
		}
	}

	
	override public function beatHit() //follows the beat
	{
		
		
		super.beatHit();
	}
	
	//variable templates:
	/*
	Sprite_Var: var Sprite:FlxSprite = new FlxSprite().loadGraphic('assets/images/MenuUI/Target.png');
	 */
}
