package;

import chapters.ChapterONE;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.system.System;
import lime.utils.Assets;
#if sys
import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;
import openfl.utils.ByteArray;
import lime.media.AudioBuffer;
import flash.media.Sound;
#end
import haxe.Json;
import tjson.TJSON;
using StringTools;
class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Character;
	var camFollow:FlxObject;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		if (PlayState.SONG.song == "headshot" || PlayState.SONG.song == "harsh")
		{
			FlxG.sound.play('assets/sounds/Tryhard/deathlines/line' + Std.random(4) + TitleState.soundExt, 15);
		}
		
		if (PlayState.SONG.song == "smiling")
		{
			FlxG.sound.play('assets/sounds/Smiler/Happy=)/Click' + TitleState.soundExt, 15);
		}
		
		var daStage = PlayState.curStage;
		var p1 = PlayState.SONG.player1;
		// hscript means everything is custom
		// and they don't  fucking lose their shit if 
		// they don't have the proper animation
		var daBf:String = p1 + '-dead';
		trace(p1);
		
		super();
		Conductor.songPosition = 0;

		bf = new Character(x, y, daBf, true);
		// : )
		bf.beingControlled = true;
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);
		if (bf.isPixel)
			stageSuffix = "-pixel";
		
		if (PlayState.SONG.song != "smiling")
		FlxG.sound.play('assets/sounds/fnf_loss_sfx' + stageSuffix + TitleState.soundExt);
		
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				switch PlayState.currentChapter
							{
								case 1:
								LoadingState.loadAndSwitchState(new ChapterONE());
								
							    default:
								LoadingState.loadAndSwitchState(new ChapterState());
							}
			else
				LoadingState.loadAndSwitchState(new FreeplayState());
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}
		
		if (PlayState.SONG.song == "headshot" || PlayState.SONG.song == "harsh")
		{
			if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
			FlxG.sound.playMusic('assets/music/arsenalgameover' + stageSuffix + '.ogg');
			
		} else if (PlayState.SONG.song == "smiling")
		{
			if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
			FlxG.sound.play('assets/sounds/Smiler/Happy=)/Transform' + TitleState.soundExt, 15);
			
		} else if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic('assets/music/gameOver' + stageSuffix + '.ogg');
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			if (PlayState.isRushMode)
			{
				isEnding = true;
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new RushScoreState());
				});
				return;
			}
			
			if (PlayState.SONG.song == "headshot" || PlayState.SONG.song == "harsh")
			{
				FlxG.sound.play('assets/sounds/Tryhard/Spawn' + TitleState.soundExt);
				isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
			return;
			}
			
			if (PlayState.SONG.song == "smiling")
			{
				isEnding = true;
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
			return;
			}
			
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play('assets/music/gameOverEnd' + stageSuffix + TitleState.soundExt);
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
