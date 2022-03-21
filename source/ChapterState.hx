package;

import Section.SwagSection;
import flash.text.TextField;
import flixel.FlxObject;
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
import chapters.ChapterONE;
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

class ChapterState extends MusicBeatState
{	
	//variables \/
	
	var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/MenuUI/Storymode/ChapterBGs/BG1.png');
	
	//chapters \/
	var comingsoon:FlxSprite = new FlxSprite().loadGraphic('assets/images/MenuUI/Storymode/UI/Normal/BackBG.png');
	
	var chapterStuff:Array<String> = ['chapterONE'];
	
	var curSelected:Int = 0;
	
	var chapterItems:FlxTypedGroup<FlxSprite>;
	
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	
	//variables /\
	
	override function create() //CreateStuff
	{
		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);
		
		/*if (FlxG.sound.music != null) {
			// cuck lunchbox
			FlxG.sound.music.stop();
		}
		
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/koolkats' + TitleState.soundExt, 5);
		*/
		bg.scrollFactor.set();
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);
		
		chapterItems = new FlxTypedGroup<FlxSprite>();
		add(chapterItems);
		
		for (i in 0...chapterStuff.length)
		{
			if (i == 0)
			{
				var chapter:FlxSprite = new FlxSprite(29, 23 + (23 * i)).loadGraphic('assets/images/MenuUI/Storymode/Chapters/Chapter' + (i + 1) + '.png');
			chapter.ID = i;
			chapter.antialiasing = true;
			chapter.scrollFactor.set();
			chapterItems.add(chapter);
			
			var comingsoon:FlxSprite = new FlxSprite(29, (23 + (23 * i)) * 4).loadGraphic('assets/images/MenuUI/Storymode/ComingSoon.png');
			comingsoon.ID = chapterStuff.length;
			comingsoon.y += comingsoon.height;
			comingsoon.antialiasing = true;
			comingsoon.scrollFactor.set();
			chapterItems.add(comingsoon);
			add(comingsoon);
			}
			
			if (i > 0)
			{
			var chapter:FlxSprite = new FlxSprite(29, (23 + (23 * i)) * 4).loadGraphic('assets/images/MenuUI/Storymode/Chapters/Chapter' + (i + 1) + '.png');
			chapter.y += chapter.height;
			chapter.ID = i;
			chapter.antialiasing = true;
			chapter.scrollFactor.set();
			chapterItems.add(chapter);
			}
		}
		
		FlxG.camera.follow(camFollowPos, null, 1);
		changeChapters();
		
		super.create();
	}

	override function update(elapsed:Float) //UpdatesStuff
	{
		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		
		super.update(elapsed);
		
		if (controls.DOWN_MENU)
		{
			FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
			changeChapters(-1);
		}
		if (controls.UP_MENU)
		{
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
		changeChapters(1);
		}
		if (controls.BACK)
		{
			LoadingState.loadAndSwitchState(new MainMenuState());
		}
		if (controls.ACCEPT)
		{
			var whatpick:String = chapterStuff[curSelected];
			
			switch whatpick
			{
				case "chapterONE":
				PlayState.currentChapter = 1;
				LoadingState.loadAndSwitchState(new ChapterONE());
				
			    default:
				FlxG.sound.play('assets/sounds/deletefile' + TitleState.soundExt);
				FlxG.camera.shake(0.01, 0.04);
			}
		}
		
		if (controls.BACK)
		{
			FlxG.sound.play('assets/sounds/cancelMenu' + TitleState.soundExt);
			LoadingState.loadAndSwitchState(new ChapterState());
		}
	}
	
	function changeChapters(lmfao:Int = 0)
	{
		curSelected += lmfao;
		
		if (curSelected < 0)
		curSelected = chapterStuff.length;
		if (curSelected >= (chapterStuff.length + 1))
		curSelected = 0;
		
		trace(curSelected);
		
		chapterItems.forEach(function(spr:FlxSprite)
		{
			FlxTween.tween(spr, {x: 29}, 0.04);
			spr.alpha = 0.2;
			
			if (spr.ID == curSelected)
			{
				spr.alpha = 1;
				var add:Float = 0;
				if(chapterItems.length > 3) {
					add = chapterItems.length * 8;
				}
				FlxTween.tween(spr, {x: 79}, 0.04);
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
			}
		});
		
		changeBG();
	}
	
	function changeBG()
	{
		bg.y = -10;
		if (curSelected != chapterStuff.length)
		{
			bg.loadGraphic(Paths.image('MenuUI/Storymode/ChapterBGs/BG' + (curSelected + 1)));
		} else
		{
		bg.loadGraphic(Paths.image('MenuUI/Storymode/UI/Normal/BackBG'));
		}
		FlxTween.tween(bg, {y: -5}, 0.2);
	}
	
	override public function beatHit():Void  //follows the beat
	{
		super.beatHit();
	}
	
	//variable eg.
	/*
	Sprite_Var: var Sprite:FlxSprite = new FlxSprite().loadGraphic('assets/images/MenuUI/Target.png');
	 */
}
