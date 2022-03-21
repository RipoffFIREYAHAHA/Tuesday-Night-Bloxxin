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
import flixel.graphics.frames.FlxAtlasFrames;
import lime.utils.Assets;
import openfl.Assets;
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

class CharacterState extends MusicBeatState
{
	//variables \/
	var rarrow:FlxSprite = new FlxSprite(1220, 300).loadGraphic('assets/images/MenuUI/arrow.png');
	var larrow:FlxSprite = new FlxSprite(-8, 300).loadGraphic('assets/images/MenuUI/arrow.png');
	
	var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
	var curCharacter:Int = 0;
	var characterClan:FlxTypedGroup<FlxSprite>;
	var iconClan:FlxTypedGroup<FlxSprite>;
	var TextEmpire:FlxTypedGroup<FlxSprite>;
	
	var CharacterDesc = CoolUtil.parseJson(FNFAssets.getJson("assets/images/MenuUI/characterDesc/NEWcharsInfo/CharDesc0"));
	var ColorForBG:Array<String> = Assets.getText('assets/images/MenuUI/characterDesc/pallete.txt').split('\n');
	
	var CharNameTXT:FlxText = new FlxText(359, 68, 907, "", 48);
	var CharGenderTXT:FlxText = new FlxText(359, 130, 907, "", 48);
	var CharGenderReveal:FlxText = new FlxText(359, 130, 907, "", 48);
	var CharAgeTXT:FlxText = new FlxText(359, 188, 907, "", 48);
	var CharStereotypeTXT:FlxText = new FlxText(359, 252, 907, "", 48);
	var CharDescTXT:FlxText = new FlxText(359, 316, 907, "", 36);

	//variables /\
	
	override function create() //CreateStuff
	{
		if (FlxG.sound.music != null) {
			// cuck lunchbox
			FlxG.sound.music.stop();
		}
		
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/breaktime' + TitleState.soundExt, 5, true);
		
		add(bg);
		
		characterClan = new FlxTypedGroup<FlxSprite>();
		add(characterClan);
		
		iconClan = new FlxTypedGroup<FlxSprite>();
		add(iconClan);
		
		addcharacters();
		addiconsorsmth();
		
		TextEmpire = new FlxTypedGroup<FlxSprite>();
		add(TextEmpire);
		
		CharNameTXT.setFormat("assets/fonts/crafty.ttf", 65, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		TextEmpire.add(CharNameTXT);
		
		CharGenderTXT.setFormat("assets/fonts/crafty.ttf", 65, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		TextEmpire.add(CharGenderTXT);
		CharGenderReveal.setFormat("assets/fonts/crafty.ttf", 65, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		TextEmpire.add(CharGenderReveal);
		
		CharAgeTXT.setFormat("assets/fonts/crafty.ttf", 65, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		TextEmpire.add(CharAgeTXT);
		
		CharStereotypeTXT.setFormat("assets/fonts/crafty.ttf", 65, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		TextEmpire.add(CharStereotypeTXT);
		
		CharDescTXT.setFormat("assets/fonts/crafty.ttf", 53, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		TextEmpire.add(CharDescTXT);
		
		clearall();
		checkthechars();
		FlxTween.color(bg,0.5, bg.color, Std.parseInt("0xFF" + ColorForBG[curCharacter]));
		
		add(rarrow);
		larrow.flipX = true;
		add(larrow);
		
		/*if (FlxG.sound.music != null) {
			// cuck lunchbox
			FlxG.sound.music.stop();
		}
		
		FlxG.sound.playMusic('assets/music/custom_menu_music/'
		+ CoolUtil.parseJson(FNFAssets.getText("assets/music/custom_menu_music/custom_menu_music.json")).Menu + '/koolkats' + TitleState.soundExt, 5);
		*/
		
		characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('idle');
			});
		
		super.create();
	}
	
	var IsInShort:Bool = false;
	
	function InShort()
	{
		if (IsInShort)
		{
			CharDescTXT.text = "In Short :\n" + CharacterDesc.InShort;
		}
		else
		{
			CharDescTXT.text = "Description :\n" + CharacterDesc.Description;
		}
	}
	
	function checkthechars()
	{
		CharacterDesc = CoolUtil.parseJson(FNFAssets.getJson("assets/images/MenuUI/characterDesc/NEWcharsInfo/CharDesc" + curCharacter));
		
		CharNameTXT.text = "Name : " + CharacterDesc.Name;
		CharGenderTXT.text = "Gender : ";
		CharGenderReveal.text = "            " + CharacterDesc.Gender;
		CharAgeTXT.text = "Age : " + CharacterDesc.Age;
		CharStereotypeTXT.text = "Stereotype : " + CharacterDesc.Stereotype;
		
		InShort();
		
		useSytrus = CharacterDesc.IsLongNote;
		isAltAnim = CharacterDesc.IsAltAnim;
		
		//GenderThingColor
		switch CharacterDesc.Gender
		{
			case "Male":
			CharGenderReveal.color = 0xFF00A8FF;
			
		    case "Female":
			CharGenderReveal.color = 0xFFFF8AB7;
				
			default:
			CharGenderReveal.color = 0xFF00AF2E;
		}
		
		characterClan.forEach(function (spr:FlxSprite)
		{
			if (spr.ID == curCharacter)
			spr.alpha = 1;
		});
		
		iconClan.forEach(function (spr:FlxSprite)
		{
			if (spr.ID == curCharacter)
			spr.alpha = 1;
		});
	}
	
	function addiconsorsmth(iconlmao:String = "assets/images/MenuUI/characterDesc/icons/")
	{
		var checkfiles:Int = 0;
		if (sys.FileSystem.exists(iconlmao)) {
    trace("chars found: " + iconlmao);
	for (file in FileSystem.readDirectory(iconlmao))
	{
		checkfiles++;
		trace("amount of icon:" + checkfiles);
    }
	
	for (i in 0...checkfiles)
	{
		trace("creating icon");
		var icon:FlxSprite = new FlxSprite(0, 31).loadGraphic('assets/images/MenuUI/characterDesc/icons/icon' + i + '.png');
		icon.ID = i;
		icon.antialiasing = true;
		trace("icon created, current ID:" + icon.ID);
		iconClan.add(icon);
		trace("icon number " + icon.ID + " has join the group");
    } 
	}else {
    trace('"$iconlmao" does not exists');
    }
	}
	
	function addcharacters(chars:String = "assets/images/MenuUI/characterDesc/chars/")
	{
		var checkfiles:Int = 0;
		if (sys.FileSystem.exists(chars)) {
    trace("chars found: " + chars);
	for (file in FileSystem.readDirectory(chars))
	{
		checkfiles++;
		trace("amount of chars:" + checkfiles);
    }
	
	checkfiles = Std.int(checkfiles / 2);
	trace("checkfiles devided, current value: " + checkfiles);
	
	for (i in 0...checkfiles)
	{
		//THE CHARACTERS
		switch i
		{
		case 4:
		trace("creating char");
		var char:FlxSprite = new FlxSprite(0 , 0);
		char.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/characterDesc/chars/Char' + i + '.png', 'assets/images/MenuUI/characterDesc/chars/Char' + i + '.xml');
		char.animation.addByPrefix('idle', "dance", 24, false);
		char.animation.addByPrefix('up', "up", 24, false);
		char.animation.addByPrefix('down', "down", 24, false);
		char.animation.addByPrefix('right', "right", 24, false);
		char.animation.addByPrefix('left', "left", 24, false);
		char.animation.addByPrefix('shoot', "shoot", 24, false);
		char.animation.addByPrefix('miss', "miss", 24, false);
		char.animation.addByPrefix('hit', "hit", 24, false);
		char.ID = i;
		char.scale.set(0.8, 0.8);
		char.updateHitbox();
		char.y = 130;
		char.scrollFactor.set();
		char.antialiasing = true;
		trace("char created, current ID:" + char.ID);
		characterClan.add(char);
		trace("char number " + char.ID + " has join the group");
		
		default:
		trace("creating char");
		var char:FlxSprite = new FlxSprite(0 , 0);
		char.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/characterDesc/chars/Char' + i + '.png', 'assets/images/MenuUI/characterDesc/chars/Char' + i + '.xml');
		char.animation.addByPrefix('idle', "dance", 24, false);
		char.animation.addByPrefix('up', "up", 24, false);
		char.animation.addByPrefix('down', "down", 24, false);
		char.animation.addByPrefix('right', "right", 24, false);
		char.animation.addByPrefix('left', "left", 24, false);
		char.ID = i;
		char.scale.set(0.8, 0.8);
		char.updateHitbox();
		char.y = 130;
		char.scrollFactor.set();
		char.antialiasing = true;
		trace("char created, current ID:" + char.ID);
		characterClan.add(char);
		trace("char number " + char.ID + " has join the group");
		}
    } 
	}else {
    trace('"$chars" does not exists');
    }
	}
	
	function clearall()
	{
		iconClan.forEach(function (spr:FlxSprite)
		{
			spr.alpha = 0;
		});
		
		characterClan.forEach(function (spr:FlxSprite)
		{
			spr.alpha = 0;
		});
	}
	
	function checkthestuf(lgbtiscool:Int = 0)
	{
		FlxG.sound.play('assets/sounds/hitSound' + TitleState.soundExt);
		curCharacter += lgbtiscool;
		
		clearall();
		
		if (curCharacter >= characterClan.length)
		curCharacter = 0;
		if (curCharacter < 0)
		curCharacter = characterClan.length - 1;
		
		checkthechars();
		
		characterClan.forEach(function(spr:FlxSprite)
		{
			var thing:Float = spr.y;
			spr.y -= 10;
			FlxTween.tween(spr, {y: thing}, 0.02);
			trace(spr.y);
	    });
		
		TextEmpire.forEach(function(spr:FlxSprite)
		{
			var thing:Float = spr.y;
			spr.y -= 10;
			FlxTween.tween(spr, {y: thing}, 0.02);
			trace(spr.y);
	    });
		
		iconClan.forEach(function(spr:FlxSprite)
		{
			var thing:Float = spr.y;
			spr.y -= 10;
			FlxTween.tween(spr, {y: thing}, 0.02);
			trace(spr.y);
	    });
		
		FlxTween.color(bg,0.5, bg.color, Std.parseInt("0xFF" + ColorForBG[curCharacter]));
	}
	
	var stillpressing:Bool = false;
	var useSytrus:Bool = false;
	var isAltAnim:Bool = false;
	
	function checkSing()
	{
		if (FlxG.keys.pressed.ANY)
		{
			stillpressing = true;
		} else
		{
			stillpressing = false;
		}
		
		//Not FL Studio Type Sytrus thing idk
		if (!useSytrus)
		{
		if (FlxG.keys.justPressed.Z)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayZ' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('down');
			});
		    nobitches = true;
		}
		
		if (FlxG.keys.justPressed.X)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayX' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('left');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.C)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayC' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('right');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.V)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayV' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('up');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.B)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayB' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('down');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.N)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayN' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('left');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.M)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayM' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('right');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.COMMA)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayCOMMA' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('up');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.PERIOD)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayPERIOD' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('right');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.SLASH)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlaySLASH' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('up');
			});
			 nobitches = true;
		}
		
		if (isAltAnim)
		{
		if (FlxG.keys.justPressed.ONE)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayONE' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				if (curCharacter == 4)
				hehe.animation.play('shoot');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.TWO)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayTWO' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				if (curCharacter == 4)
				hehe.animation.play('miss');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.THREE)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayTHREE' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				if (curCharacter == 4)
				hehe.animation.play('hit');
			});
			 nobitches = true;
		}
		}
		
		if (FlxG.keys.justReleased.ANY && !stillpressing)
		{
			nobitches = false;
		}
		}
		
		//FL Studio Thing Sytrus
		if (useSytrus)
		{
		if (FlxG.keys.justPressed.ANY)
		{
		characterClan.forEach(function(spr:FlxSprite)
		{
			if (spr.animation.name != "idle")
		    FlxG.sound.destroy(false);
		});
		}
		
		if (FlxG.keys.justPressed.Z)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayZ' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('down');
			});
		    nobitches = true;
		}
		
		if (FlxG.keys.justPressed.X)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayX' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('left');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.C)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayC' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('right');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.V)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayV' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('up');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.B)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayB' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('down');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.N)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayN' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('left');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.M)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayM' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('right');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.COMMA)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayCOMMA' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('up');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.PERIOD)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlayPERIOD' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('right');
			});
			 nobitches = true;
		}
		
		if (FlxG.keys.justPressed.SLASH)
		{
			FlxG.sound.play('assets/sounds/menu/chars/Character' + curCharacter + '/PlaySLASH' + TitleState.soundExt);
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('up');
			});
			 nobitches = true;
		}
		if (FlxG.keys.justReleased.ANY && !stillpressing)
		{
			FlxG.sound.destroy(false);
			nobitches = false;
		}
		}
	}
	
	var amogusisdead:Float = 0;
	var nobitches:Bool = true;

	override function update(elapsed:Float) //UpdatesStuff
	{
		if (FlxG.keys.justPressed.SPACE)
		{
		IsInShort = !IsInShort;
		InShort();
		}
		
		if (!nobitches)
		{
		amogusisdead += 0.08;
		
		if (amogusisdead >= 1)
		{
			characterClan.forEach(function (hehe:FlxSprite)
			{
				hehe.animation.play('idle');
			});
			amogusisdead = 0;
		}
		}
		super.update(elapsed);
		
		checkSing();
		
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
		
		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			if (FlxG.mouse.visible == true)
		    FlxG.mouse.visible = false;
			// main menu or else we are cursed
			LoadingState.loadAndSwitchState(new MainMenuState());
		}
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
