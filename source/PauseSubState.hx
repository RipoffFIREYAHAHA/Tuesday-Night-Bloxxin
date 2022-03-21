package;

import Controls.Control;
import chapters.ChapterONE;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
#if sys
import flixel.system.FlxSound;
import sys.io.File;
import haxe.io.Path;
import openfl.utils.ByteArray;
import lime.media.AudioBuffer;
import flash.media.Sound;
import sys.FileSystem;
#end

class PauseSubState extends MusicBeatSubstate
{
	var MeWhen:Float = 0;
	var GraphicalStuf:Float = 0;
	var pauseMusic:FlxSound;
	var pausebutton:FlxSprite = new FlxSprite();
	var moveulittleshit:Bool = false;
	
	//Randomizer or smth
	var randomlogo = 0;
	
	//Sprites workaround :P
	var buttonsleave:FlxSprite = new FlxSprite();
	var thelogo:FlxSprite = new FlxSprite();
	
	//Do u want to do it?
	var leavehuh:FlxSprite = new FlxSprite();
	var resethuh:FlxSprite = new FlxSprite();
	var yes:FlxSprite = new FlxSprite();
	var no:FlxSprite = new FlxSprite();
	var home:FlxSprite = new FlxSprite();
	var yesreset:FlxSprite = new FlxSprite();
	var noreset:FlxSprite = new FlxSprite();
	var curSelect:Int = 0;
	//bools
	var allowselectleave:Bool = false;
	var allowselectreset:Bool = false;
	
	public function new(x:Float, y:Float)
	{
		super();
		
		CountLogos();

		pauseMusic = new FlxSound().loadEmbedded('assets/music/breakfast' + TitleState.soundExt, true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
		FlxG.sound.list.add(pauseMusic);
		
		var bg:FlxSprite = new FlxSprite();
		    bg.loadGraphic(Paths.image('MenuUI/Pause/black'));
		    bg.alpha = 0.6;
		    bg.screenCenter();
		    bg.scrollFactor.set();
			bg.updateHitbox();
		    add(bg);
		    
		    var pausetitle:FlxSprite = new FlxSprite();
		    pausetitle.loadGraphic(Paths.image('MenuUI/Pause/Pause'));
		    pausetitle.scrollFactor.set();
		    pausetitle.screenCenter(X);
			pausetitle.updateHitbox();
			pausetitle.antialiasing = true;
		    add(pausetitle);
		    
			pausebutton.loadGraphic(Paths.image('MenuUI/Pause/PauseButton'));
		    pausebutton.scrollFactor.set();
		    pausebutton.screenCenter(X);
			pausebutton.y += 180;
			pausebutton.updateHitbox();
			pausebutton.antialiasing = true;
		    add(pausebutton);
			
		    buttonsleave.loadGraphic(Paths.image('MenuUI/Pause/ButtonsA'));
		    buttonsleave.scrollFactor.set();
		    buttonsleave.screenCenter(X);
			buttonsleave.y += 530;
			buttonsleave.updateHitbox();
			buttonsleave.antialiasing = true;
		    add(buttonsleave);
			
			pausetitle.loadGraphic(Paths.image('MenuUI/Pause/Pause'));
		    pausetitle.scrollFactor.set();
		    pausetitle.screenCenter(X);
			pausetitle.updateHitbox();
			pausetitle.antialiasing = true;
		    add(pausetitle);
			
			thelogo.loadGraphic(Paths.image('MenuUI/Pause/LogoA/Logo' + randomlogo));
		    thelogo.scrollFactor.set();
		    thelogo.screenCenter();
			thelogo.updateHitbox();
			thelogo.antialiasing = true;
			thelogo.x += 300;
			thelogo.y += 35;
		    add(thelogo);
			
			//u wanna do it?
			
			leavehuh.loadGraphic(Paths.image('MenuUI/Pause/LeaveWarn'));
		    leavehuh.scrollFactor.set();
		    leavehuh.screenCenter();
			leavehuh.updateHitbox();
			leavehuh.antialiasing = true;
			leavehuh.alpha = 0;
			leavehuh.x += 5;
		    add(leavehuh);
			
			resethuh.loadGraphic(Paths.image('MenuUI/Pause/ResetWarn'));
		    resethuh.scrollFactor.set();
		    resethuh.screenCenter();
			resethuh.updateHitbox();
			resethuh.antialiasing = true;
			resethuh.alpha = 0;
			resethuh.x += 5;
		    add(resethuh);
			
			yes.loadGraphic(Paths.image('MenuUI/Pause/Yes'));
		    yes.scrollFactor.set();
		    yes.screenCenter();
			yes.updateHitbox();
			yes.antialiasing = true;
			yes.alpha = 0;
			yes.y += 100;
			yes.x -= 140;
		    add(yes);
			
			no.loadGraphic(Paths.image('MenuUI/Pause/No'));
		    no.scrollFactor.set();
		    no.screenCenter();
			no.updateHitbox();
			no.antialiasing = true;
			no.alpha = 0;
			no.y += 100;
			no.x += 140;
		    add(no);
			
			home.loadGraphic(Paths.image('MenuUI/Pause/Home'));
		    home.scrollFactor.set();
		    home.screenCenter();
			home.updateHitbox();
			home.antialiasing = true;
			home.alpha = 0;
			home.y += 100;
			home.x -= 6;
		    add(home);
			
			yesreset.loadGraphic(Paths.image('MenuUI/Pause/Yes'));
		    yesreset.scrollFactor.set();
		    yesreset.screenCenter();
			yesreset.updateHitbox();
			yesreset.antialiasing = true;
			yesreset.alpha = 0;
			yesreset.y += 100;
			yesreset.x -= 120;
		    add(yesreset);
			
			noreset.loadGraphic(Paths.image('MenuUI/Pause/No'));
		    noreset.scrollFactor.set();
		    noreset.screenCenter();
			noreset.updateHitbox();
			noreset.antialiasing = true;
			noreset.alpha = 0;
			noreset.y += 100;
			noreset.x += 120;
		    add(noreset);
			
			cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}
	
	function CountLogos(checkit:String = "assets/images/MenuUI/Pause/logoA/")
	{
		var checkfiles:Int = 0;
		if (sys.FileSystem.exists(checkit)) {
    trace("checkit found: " + checkit);
	for (file in FileSystem.readDirectory(checkit))
	{
		checkfiles++;
		trace("amount of RandomIcons:" + checkfiles);
    }
	
	randomlogo = Std.random(checkfiles);
	
	}else {
    trace('"$checkit" does not exists');
    }
	}

	override function update(elapsed:Float)
	{
		MeWhen += 0.05;
		GraphicalStuf += 0.025;
		
		if (MeWhen >= 1)
		{
			if (pausebutton.alpha == 1)
			{
				pausebutton.alpha = 0;
			} else
			{
				pausebutton.alpha = 1;
			}
			
			MeWhen = 0;
		}
		
		if (GraphicalStuf >= 1)
		{
			if (moveulittleshit)
			{
				buttonsleave.loadGraphic(Paths.image('MenuUI/Pause/ButtonsB'));
				thelogo.loadGraphic(Paths.image('MenuUI/Pause/LogoB/Logo' + randomlogo));
				moveulittleshit = false;
			} else
			{
				buttonsleave.loadGraphic(Paths.image('MenuUI/Pause/ButtonsA'));
				thelogo.loadGraphic(Paths.image('MenuUI/Pause/LogoA/Logo' + randomlogo));
				moveulittleshit = true;
			}
			
			GraphicalStuf = 0;
		}
		
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.2 * elapsed;
		
		if (allowselectleave)
		{
		switch curSelect
		{
			case 0:
			leavebuttonTrans();
			yes.alpha = 1;
			
		    case 1:
			leavebuttonTrans();
			home.alpha = 1;
			
		    case 2:
			leavebuttonTrans();
			no.alpha = 1;
		}
		}
		
		if (allowselectreset)
		{
			switch curSelect
			{
				case 0:
				resetbuttonTrans();
				yesreset.alpha = 1;
				
			case 1:
				resetbuttonTrans();
				noreset.alpha = 1;
			}
		}
		
		if (allowselectleave)
		{
		if (curSelect > 2)
		curSelect = 0;
		if (curSelect < 0)
		curSelect = 2;
		}
		
		if (allowselectreset)
		{
			if (curSelect > 1)
			curSelect = 0;
			if (curSelect < 0)
			curSelect = 1;
		}

		super.update(elapsed);

			if (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.ENTER && !allowselectleave && !allowselectreset)
			{
				close();
			}
			
			if (FlxG.keys.justPressed.R && !allowselectleave && !allowselectreset)
			{
				WarnReset();
			}
			
			if (FlxG.keys.justPressed.L && !allowselectleave && !allowselectreset)
			{
				WarnLeave();
			}
			
			if (controls.LEFT_MENU && (allowselectleave || allowselectreset))
			{
			FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
			curSelect--;
			}
			
			if (controls.RIGHT_MENU && (allowselectleave || allowselectreset))
			{
			FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
			curSelect++;
			}
			
			if (controls.ACCEPT)
			{
				if (allowselectleave)
				{
					switch curSelect
					{
						case 0:
						if (PlayState.isStoryMode)
					    {
							switch PlayState.currentChapter
							{
								case 1:
								LoadingState.loadAndSwitchState(new ChapterONE());
								
							    default:
								LoadingState.loadAndSwitchState(new ChapterState());
							}
						}
					    else
						{
					    LoadingState.loadAndSwitchState(new FreeplayState());
						}
						
					    case 1:
						LoadingState.loadAndSwitchState(new MainMenuState());
						
					    case 2:
						resetall();
					}
				}
				
				if (allowselectreset)
				{
					switch curSelect
					{
						case 0:
						FlxG.sound.play('assets/sounds/menu/oof' + TitleState.soundExt);
						FlxG.resetState();
						
					    case 1:
						resetall();
					}
				}
			}
	}
	
	function leavebuttonTrans()
	{
		yes.alpha = 0.5;
		no.alpha = 0.5;
		home.alpha = 0.5;
	}
	
	function resetbuttonTrans()
	{
		yesreset.alpha = 0.5;
		noreset.alpha = 0.5;
	}
	
	function resetall()
	{
		allowselectleave = false;
		allowselectreset = false;
		curSelect = 0;
		
		leavehuh.alpha = 0;
		yes.alpha = 0;
		no.alpha = 0;
		home.alpha = 0;
		
		resethuh.alpha = 0;
		yesreset.alpha = 0;
		noreset.alpha = 0;
	}
	
	function WarnLeave()
	{
		resetall();
		leavehuh.alpha = 1;
		yes.alpha = 1;
		no.alpha = 0.5;
		home.alpha = 0.5;
		allowselectleave = true;
	}
	
	function  WarnReset()
	{
		resetall();
		resethuh.alpha = 1;
		yesreset.alpha = 0.5;
		noreset.alpha = 0.5;
		allowselectreset = true;
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}
}
