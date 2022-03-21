package;

import flash.display.InteractiveObject;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.utils.Assets;
import lime.app.Application;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxObject;
import flixel.util.FlxTimer;
#if sys
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
typedef VersionJson = {
	var version: String;
	var name_1: String;
	var name_2: String;
	var name_3: String;

}

	
class MainMenuState extends MusicBeatState
{
	public static var isIntro:Bool = false;
	var curSelected:Int = 0;
	var customMenuConfirm: Array<Array<String>>;
	var customMenuScroll: Array<Array<String>>;
	var parsedcustomMenuConfirmJson:Array<Array<String>>;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var menuItemsb:FlxTypedGroup<FlxSprite>;
	var optionShit:Array<String> = ['story mode', 'freeplay', 'credits', 'options', 'characterdesc', 'arts', 'boom'];
	var menuSoundJson:Dynamic;
	var scrollSound:String;
	var camFollow:FlxObject;
	
	//designs and shit
	var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuDesat.png');
	var backend:FlxSprite = new FlxSprite();
	var backstart:FlxSprite = new FlxSprite();
	var chars:FlxSprite = new FlxSprite();
	var TheLogo:FlxSprite = new FlxSprite();
	var overlay:FlxSprite = new FlxSprite();
	var pageGAGA:FlxSprite = new FlxSprite(0 , 0);
	var PrevXBACKS:Float = 0;
	var PrevItems:Float = 0;
	var PrevItemsB:Float = 0;

	//thepages (slender refernce)
	var Page:Int = 1;
	
	//haha funni
	var RandomBoom:Int = 0;
	
	//grup heheh
	var theBacks:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	
	public static var version:String = "";
	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		var customPrecence = TitleState.discordStuff.mainmenu;
		Discord.DiscordClient.changePresence(customPrecence, null);
		#end
		menuSoundJson = CoolUtil.parseJson(FNFAssets.getText("assets/sounds/custom_menu_sounds/custom_menu_sounds.json"));
		scrollSound = menuSoundJson.customMenuScroll;
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;
		if (!OptionsHandler.options.allowStoryMode) 
			optionShit.remove("story mode");
		if (!OptionsHandler.options.allowFreeplay) 
			optionShit.remove("freeplay");
		if (!OptionsHandler.options.allowDonate) 
			optionShit.remove("donate");
		if (!OptionsHandler.options.useSaveDataMenu && !OptionsHandler.options.allowEditOptions) 
			optionShit.remove("options");
		if (!FlxG.sound.music.playing)
		{
			checkdate();
		}
		
		persistentUpdate = persistentDraw = true;
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.2));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);		

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		
		add(theBacks);
		
		backend = new FlxSprite().loadGraphic('assets/images/MenuUI/Backend.png');
		backend.screenCenter();
		backend.antialiasing = true;
		backend.x += 3;
		backend.y += 5;
		theBacks.add(backend);
		
		backstart = new FlxSprite().loadGraphic('assets/images/MenuUI/white.png');
        backstart.screenCenter();
		backstart.antialiasing = true;
		backstart.x += 3;
		backstart.y += 5;
		theBacks.add(backstart);
		
		if (MainMenuState.isIntro == true)
		{
		theBacks.forEach(function(spr:FlxSprite)
		{
			
			PrevXBACKS = spr.x;
			spr.x -= 950;
			FlxTween.tween(spr, {x:PrevXBACKS}, 0.8, {ease: FlxEase.quartOut});
		});
		}
		
		chars = new FlxSprite().loadGraphic('assets/images/MenuUI/Storymode.png');
		chars.antialiasing = true;
		chars.x = 910;
		chars.y = 33;
		add(chars);
		
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);
		
		menuItemsb = new FlxTypedGroup<FlxSprite>();
		add(menuItemsb);

		var tex = FlxAtlasFrames.fromSparrow('assets/images/FNF_main_menu_assets.png', 'assets/images/FNF_main_menu_assets.xml');

		for (i in 0...optionShit.length)
		{
			switch i
			{
			case 0:
			var menuItem:FlxSprite = new FlxSprite(327, 42);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			
			case 1:
			var menuItem:FlxSprite = new FlxSprite(219, 221);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			
			case 2:
			var menuItem:FlxSprite = new FlxSprite(158 , 372);
			menuItem.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/Buttons/credits.png', 'assets/images/MenuUI/Buttons/credits.xml');
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 12);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 12);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			
			case 3:
			var menuItem:FlxSprite = new FlxSprite(345, 542);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			
			case 4:
			var menuItem:FlxSprite = new FlxSprite(327, 42);
			menuItem.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/Buttons/characterdesc.png', 'assets/images/MenuUI/Buttons/characterdesc.xml');
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 12);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 12);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItemsb.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			
			case 5:
			var menuItem:FlxSprite = new FlxSprite(158, 221);
			menuItem.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/Buttons/arts.png', 'assets/images/MenuUI/Buttons/arts.xml');
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 12);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 12);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItemsb.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			
			case 6:
			var menuItem:FlxSprite = new FlxSprite(158 , 372);
			menuItem.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/Buttons/boom.png', 'assets/images/MenuUI/Buttons/boom.xml');
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 12);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 12);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItemsb.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			}
		}
		
		if (MainMenuState.isIntro == true)
		   {
		menuItems.forEach(function(spr:FlxSprite)
		{
			
			PrevItems = spr.x;
			spr.x -= 950;
			FlxTween.tween(spr, {x:PrevItems}, 0.8, {ease: FlxEase.quartOut});
		});
		
		PrevItemsB = pageGAGA.x;
		pageGAGA.x -= 950;
		FlxTween.tween(pageGAGA, {x:PrevItemsB}, 0.8, {ease: FlxEase.quartOut});
		MainMenuState.isIntro = false;
		}
		
		pageGAGA.frames = FlxAtlasFrames.fromSparrow('assets/images/MenuUI/PageNavigation.png', 'assets/images/MenuUI/PageNavigation.xml');
		pageGAGA.animation.addByPrefix('one', "one", 12, true);
		pageGAGA.animation.addByPrefix('two', "two", 12, true);
		pageGAGA.animation.addByPrefix('change', "change", 24, false);
		pageGAGA.animation.play('one');
		pageGAGA.scrollFactor.set();
		pageGAGA.antialiasing = true;
		add(pageGAGA);
		
		overlay.updateHitbox();
		overlay.antialiasing = true;
		overlay.loadGraphic(Paths.image('holidaybg/noOverlay'));
		add(overlay);
		
		TheLogo = new FlxSprite().loadGraphic('assets/images/MenuUI/Roblox2.png');
		TheLogo.antialiasing = true;
		TheLogo.x += 1200;
		TheLogo.y += 650;
		add(TheLogo);

		var infoJson:Dynamic = CoolUtil.parseJson(FNFAssets.getJson("assets/data/gameInfo"));
		if (infoJson.version != "") {
			infoJson.version = " - " + infoJson.version; 
		}
		// ok, if you can't fucking code then don't edit the fucking code
		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "v"+ Application.current.meta.get("version") + infoJson.version, 12);
		#if !final
		versionShit.text += "-" + FNFAssets.getText('VERSION');
		#end
		version = versionShit.text;
		var usingSave:FlxText = new FlxText(5, FlxG.height - 36, 0, FlxG.save.name, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		usingSave.scrollFactor.set();
		usingSave.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		if (OptionsHandler.options.useSaveDataMenu)
			add(usingSave);
		// NG.core.calls.event.logEvent('swag').send();
		switch (FlxG.save.name) {
			case "save0":
				usingSave.text = "bf";
			case "save1":
				usingSave.text = "classic";
			case "save2":
				usingSave.text = "bf-pixel";
			case "save3":
				usingSave.text = "spooky";
			case "save4":
				usingSave.text = "dad";
			case "save5":
				usingSave.text = "pico";
			case "save6":
				usingSave.text = "mom";
			case "save7":
				usingSave.text = "gf";
			case "save8":
				usingSave.text = "lemon";
			case "save9":
				usingSave.text = "senpai";
		}

		changeItem();
		checkpage();
		checkbg();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{	
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_MENU)
			{
				FlxG.sound.play('assets/sounds/custom_menu_sounds/'
				+ menuSoundJson.customMenuScroll +'/scrollMenu' + TitleState.soundExt);
				changeItem(-1);
			}

			if (controls.DOWN_MENU)
			{
				FlxG.sound.play('assets/sounds/custom_menu_sounds/'
				+ menuSoundJson.customMenuScroll +'/scrollMenu' + TitleState.soundExt);
				changeItem(1);
			}
			
			if (controls.LEFT_MENU)
			{
				FlxG.sound.play('assets/sounds/custom_menu_sounds/'
				+ menuSoundJson.customMenuScroll +'/cancelMenu' + TitleState.soundExt);
				Page--;
				checkpage();
				changeItem();
			}
			
			if (controls.RIGHT_MENU)
			{
				FlxG.sound.play('assets/sounds/custom_menu_sounds/'
				+ menuSoundJson.customMenuScroll +'/cancelMenu' + TitleState.soundExt);
				Page++;
				checkpage();
				changeItem();
			}

			if (controls.BACK)
			{
				LoadingState.loadAndSwitchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', [FNFAssets.getText("assets/data/donate_button_link.txt"), "&"]);
					#else
					FlxG.openURL(FNFAssets.getText("assets/data/donate_button_link.txt"));
					#end
				}
				else if (optionShit[curSelected] == 'boom')
				{
					if (RandomBoom == 7)
					{
					    chars.loadGraphic(Paths.image('MenuUI/Characters/Boom'));
					}
					RandomBoom = Std.random(8);
					FlxG.sound.play('assets/sounds/booms/boom' + RandomBoom + TitleState.soundExt);
					switch Std.random(500)
					{
						case 200:
						PlayState.SONG = Song.loadFromJson("rebex/rebex");
						LoadingState.loadAndSwitchState(new PlayState());
					}
					
					switch RandomBoom
					{
						case 0 , 1 , 2:
						FlxG.camera.shake(0.01, 0.08);
						
					    case 7:
					    chars.loadGraphic(Paths.image('MenuUI/Characters/BoomWell'));
					}
					return;
				}
					selectedSomethin = true;
					FlxG.sound.play('assets/sounds/custom_menu_sounds/'
					+ menuSoundJson.customMenuConfirm + '/confirmMenu' + TitleState.soundExt);
					
					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{	
								var daChoice:String = optionShit[curSelected];
								
								switch (daChoice)
								{
									case 'story mode':
										LoadingState.loadAndSwitchState(new ChapterState());
										trace("Story Menu Selected");
									case 'freeplay':
										CategoryState.choosingFor = "freeplay";
										var epicCategoryJs:Array<Dynamic> = CoolUtil.parseJson(FNFAssets.getJson('assets/data/freeplaySongJson'));
										FreeplayState.soundTest = false;
										if (epicCategoryJs.length > 1)
										{
											LoadingState.loadAndSwitchState(new CategoryState());
										}  else {
											FreeplayState.currentSongList = epicCategoryJs[0].songs;
											LoadingState.loadAndSwitchState(new FreeplayState());
										}
										
									case 'credits':
										LoadingState.loadAndSwitchState(new CreditsState());
										
									case 'options':
										LoadingState.loadAndSwitchState(new SaveDataState());
								}
							});
						}
				});
				
				menuItemsb.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{	
								if (curSelected == 4) // CharacterDescTrigger
				                {
					                LoadingState.loadAndSwitchState(new CharacterState());
									return;
				                }
								
								if (curSelected == 5) // ArtsTrigger
				                {
					               LoadingState.loadAndSwitchState(new ArtsState());
									return;
				                }
							});
						}
				});
			}
		}
		
		if (FlxG.keys.justPressed.TWO)
		isUSE = !isUSE;
		
		super.update(elapsed);
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
	
	//HolidayShit /\ \/
	
	function checkbg()
	{
	//celebratin the holidays lol \/
	
	var now = Date.now();
    var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var monthName = monthNames[now.getMonth()];
    var dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    var dayName = dayNames[now.getDay()];
	
	//celebratin the holidays lol /\

	switch monthName
	{
	case "November":
		bg.loadGraphic(Paths.image('holidaybg/halloween/bg' + Std.random(2)));
		overlay.loadGraphic(Paths.image('holidaybg/halloween/bgoverlay'));
		backend.loadGraphic(Paths.image('holidaybg/halloween/Backend'));
		
	case "December":
		bg.loadGraphic(Paths.image('holidaybg/christmas/bg' + Std.random(4)));
		overlay.loadGraphic(Paths.image('holidaybg/christmas/bgoverlay'));
		backend.loadGraphic(Paths.image('holidaybg/christmas/Backend'));
	}
	}
	
	//CHECKTHEPAGEBITCH
	function checkpage()
	{
		if (Page > 2)
		Page = 1;
		if (Page < 1)
		Page = 2;
		
		if (MainMenuState.isIntro == false)
		{
		switch Page
		{
			case 1:
			curSelected = 0;
			menuItems.forEach(function(spr:FlxSprite)
		    {
			spr.alpha = 1;
		    });
			menuItemsb.forEach(function(spr:FlxSprite)
		    {
			spr.alpha = 0;
		    });
			pageGAGA.animation.play('change', false, true);
			new FlxTimer().start(0.18, function(tmr:FlxTimer)
			{
			pageGAGA.animation.play('one');
			});
			
		    case 2:
			curSelected = 4;
			menuItems.forEach(function(spr:FlxSprite)
		    {
			spr.alpha = 0;
		    });
			menuItemsb.forEach(function(spr:FlxSprite)
		    {
			spr.alpha = 1;
		    });
			pageGAGA.animation.play('change', false, false);
			new FlxTimer().start(0.18, function(tmr:FlxTimer)
			{
			pageGAGA.animation.play('two');
			});
		}
		
		if (isUSE == true)
		{
		menuItems.forEach(function(spr:FlxSprite)
		    {
			PrevItems = spr.y;
			spr.y -= 10;
			FlxTween.tween(spr, {y:PrevItems}, 0.04, {ease: FlxEase.quartIn});
		    });
			
		menuItemsb.forEach(function(spr:FlxSprite)
		    {
			PrevItemsB = spr.y;
			spr.y -= 10;
			FlxTween.tween(spr, {y:PrevItemsB}, 0.04, {ease: FlxEase.quartIn});
		    });
		}
		}
		
		if (isUSE == false)
		{
			menuItems.forEach(function(spr:FlxSprite)
		    {
			PrevItems = spr.y;
			spr.y += 10;
			FlxTween.tween(spr, {y:PrevItems}, 0.04, {ease: FlxEase.quartIn});
		    });
			
		menuItemsb.forEach(function(spr:FlxSprite)
		    {
			PrevItemsB = spr.y;
			spr.y += 10;
			FlxTween.tween(spr, {y:PrevItemsB}, 0.04, {ease: FlxEase.quartIn});
		    });
		}
		checkbuttons();
	}
	
	static var isUSE:Bool = true;
	
	function checkbuttons()
	{
		switch curSelected
		{
			case 0:
				chars.loadGraphic(Paths.image('MenuUI/Characters/Storymode'));
				chars.x = 910;
		        chars.y = 33;
				bg.color = 0xFF02B757;
				backend.color = 0xFF02B757;
			case 1:
				chars.loadGraphic(Paths.image('MenuUI/Characters/Freeplay'));
				chars.x = 864;
		        chars.y = 198;
				bg.color = 0xFF00A1FF;
				backend.color = 0xFF00A1FF;
			case 2:
				chars.loadGraphic(Paths.image('MenuUI/Characters/Credits'));
				chars.x = 888;
		        chars.y = 172;
				bg.color = 0xFFBF00FF;
				backend.color = 0xFFBF00FF;
			case 3:
				chars.loadGraphic(Paths.image('MenuUI/Characters/Options'));
				chars.x = 888;
		        chars.y = 172;
				bg.color = 0xFF656668;
				backend.color = 0xFF656668;
			case 4:
				chars.loadGraphic(Paths.image('MenuUI/Characters/CharacterDesc'));
				chars.x = 815;
		        chars.y = 150;
				bg.color = 0xFFFF8300;
				backend.color = 0xFFFF8300;
			case 5:
				chars.loadGraphic(Paths.image('MenuUI/Characters/Arts'));
				chars.x = 888;
		        chars.y = 172;
				bg.color = 0xFFF3FF00;
				backend.color = 0xFFF3FF00;
			case 6:
				chars.loadGraphic(Paths.image('MenuUI/Characters/Boom'));
				chars.x = 888;
		        chars.y = 160;
				bg.color = 0xFF0D00FF;
				backend.color = 0xFF0D00FF;
		}
		
		PrevCharY = chars.y;
		chars.alpha = 0.5;
		chars.y += 10;
		FlxTween.tween(chars, {y:PrevCharY, alpha:1}, 0.04);
	}
	
	var PrevCharY:Float = 0;

	function changeItem(huh:Int = 0)
	{	
		curSelected += huh;
		
		switch Page
		{
		case 1:
		if (curSelected > 3)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = 3;
		
		case 2:
		if (curSelected > 6)
			curSelected = 4;
		if (curSelected < 4)
			curSelected = 6;
		}

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
		
		menuItemsb.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
		
		checkbuttons();
	}
}