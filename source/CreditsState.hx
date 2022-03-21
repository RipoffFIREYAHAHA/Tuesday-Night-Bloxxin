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

class CreditsState extends MusicBeatState
{
	public static var currentSongList:Array<String> = [];
	public static var soundTest:Bool = false;
	var vocals:FlxSound;
	var songs:Array<String> = [];

	var selector:FlxText;
	var curSelected:Int = 0;
	var usingCategoryScreen:Bool = false;
	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;
	
	//backgrounds
	var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/coolbackcreds.png');
	
	//credits
	var creditstuf:FlxSprite = new FlxSprite();
	var thingturn:Int = 0;
	var creditsamount:Int = 4;
	
	//fnfmodssimilartomine:)
	var fnb:FlxSprite = new FlxSprite();
	var fnfrrb:FlxSprite = new FlxSprite();

	override function create()
	{
		songs = CoolUtil.coolTextFile('assets/data/credits.txt');

		/*
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic('assets/music/freakyMenu' + TitleState.soundExt);
			}
		 */

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

	changeSelection();

		add(bg);
		
		creditstuf.antialiasing = true;
		creditstuf.screenCenter();
		add(creditstuf);
		
		fnb.antialiasing = true;
		fnfrrb.antialiasing = true;
		fnb.loadGraphic(Paths.image('MenuUI/Credits/misc/FNB'));
		fnfrrb.loadGraphic(Paths.image('MenuUI/Credits/misc/FNF_RRB'));
		fnfrrb.screenCenter();
		fnb.screenCenter();
		fnb.x -= 260;
		fnb.y -= 75;
		fnfrrb.x += 375;
		fnfrrb.y -= 140;
		
		add(fnb);
		add(fnfrrb);
		

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/*
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		 replaceit();
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);


		var upP = controls.RIGHT_MENU;
		var downP = controls.LEFT_MENU;
		var accepted = controls.ACCEPT;
		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		

		if (controls.BACK)
		{
			if (FlxG.mouse.visible == true)
		FlxG.mouse.visible = false;
			// main menu or else we are cursed
			LoadingState.loadAndSwitchState(new MainMenuState());
				
		}
		
		if (controls.ACCEPT)
		{
			switch curSelected
			{
				case 0:
				FlxG.sound.play('assets/sounds/menu/creds/me' + TitleState.soundExt, 0.8);
				case 1:
				FlxG.sound.play('assets/sounds/menu/creds/bulby' + TitleState.soundExt, 0.8);
			    case 2:
				if (thingturn == 0)
				{
					FlxG.sound.play('assets/sounds/menu/creds/shadow' + TitleState.soundExt, 0.8);
					thingturn = 1;
				} else
				{
					FlxG.sound.play('assets/sounds/menu/creds/bbpanzu' + TitleState.soundExt, 0.8);
					thingturn = 0;
				}
				case 3:
					FlxG.sound.play('assets/sounds/menu/creds/roblox' + TitleState.soundExt, 0.8);
			}
		}
		
		if (FlxG.mouse.overlaps(fnb) && fnb.alpha == 1)
		{
			if (FlxG.mouse.justPressed)
			{
				FlxG.sound.play('assets/sounds/selectfile' + TitleState.soundExt, 0.8);
				FlxG.openURL("https://gamebanana.com/mods/292830");
			}
		}
		
		if (FlxG.mouse.overlaps(fnfrrb) && fnfrrb.alpha == 1)
		{
			if (FlxG.mouse.justPressed)
			{
				FlxG.sound.play('assets/sounds/selectfile' + TitleState.soundExt, 0.8);
				FlxG.openURL("https://gamebanana.com/mods/331469");
			}
		}
		
		if (!FlxG.mouse.overlaps(fnb) && curSelected == 4)
		fnb.alpha = 0.5;
		
		if (!FlxG.mouse.overlaps(fnfrrb) && curSelected == 4)
		fnfrrb.alpha = 0.5;
		
		if (FlxG.mouse.overlaps(fnb) && curSelected == 4)
		fnb.alpha = 1;
		
		if (FlxG.mouse.overlaps(fnfrrb) && curSelected == 4)
		fnfrrb.alpha = 1;
	}
	
	function replaceit()
	{
		if (FlxG.mouse.visible == true)
		FlxG.mouse.visible = false;
		
		if (curSelected != 4)
		{
			fnb.alpha = 0;
			fnfrrb.alpha = 0;
		}
		
		switch curSelected
		{
		case 0:
			creditstuf.loadGraphic(Paths.image('MenuUI/Credits/credit' + curSelected));
			bg.color = 0xFFF36D00;
		case 1:
			creditstuf.loadGraphic(Paths.image('MenuUI/Credits/credit' + curSelected));
			bg.color = 0xFFE0F920;
		case 2:
			creditstuf.loadGraphic(Paths.image('MenuUI/Credits/credit' + curSelected));
			bg.color = 0xFF191919;
		case 3:
			creditstuf.loadGraphic(Paths.image('MenuUI/Credits/credit' + curSelected));
			bg.color = 0xFF890000;
		case 4:
			FlxG.mouse.visible = true;
			creditstuf.loadGraphic(Paths.image('MenuUI/Credits/credit' + curSelected));
			fnb.alpha = 0.5;
			fnfrrb.alpha = 0.5;
			bg.color = 0xFF7F0000;
		}
	}

	function changeSelection(change:Int = 0)
	{

		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = creditsamount;
		if (curSelected > creditsamount)
			curSelected = 0;
			
		replaceit();
	}
}
