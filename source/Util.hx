package;

import Block.Dir;
import Resource.ResourceType;
import flixel.FlxG;
import flixel.util.FlxColor;

class Util {
	public static inline var TILE_SIZE = 24;
	public static inline var GRID_WIDTH = 12;
	public static inline var GRID_HEIGHT = 12;
	public static inline var EDITOR_BUTTON_SIZE = 28;

	public static inline var SCREEN_WIDTH = TILE_SIZE * GRID_WIDTH + EDITOR_TOOLBAR_WIDTH * 2;
	public static inline var SCREEN_HEIGHT = TILE_SIZE * GRID_HEIGHT;
	public static inline var EDITOR_TOOLBAR_WIDTH = 32;

	public static inline var ANIMATION_FPS = 10;
	public static inline var ANIMATION_FPS_SLOW = 5;

	public static inline var GRID_OFFSET_X = EDITOR_TOOLBAR_WIDTH;
	public static inline var GRID_OFFSET_Y = 0;

	public static inline var TICK_INTERVAL = 0.5;

	public static inline var FADE_DURATION = 0.33;
	public static inline var COLOR_GOLD = 0xFFFCD800;
	public static inline var COLOR_GOLD_DARK = 0xFFC09700;
	public static inline var COLOR_GRAY = 0xFF2A2624;

	public static function getScreenX(gridX:Int) {
		return GRID_OFFSET_X + gridX * TILE_SIZE;
	}

	public static function getScreenY(gridY:Int) {
		return GRID_OFFSET_Y + gridY * TILE_SIZE;
	}

	public static function getBlockX(screenX:Int) {
		return Math.floor((screenX - GRID_OFFSET_X) / TILE_SIZE);
	}

	public static function getBlockY(screenY:Int) {
		return Math.floor((screenY - GRID_OFFSET_Y) / TILE_SIZE);
	}

	public static function nextDirCW(dir:Dir) {
		switch (dir) {
			case North:
				return East;
			case East:
				return South;
			case South:
				return West;
			case West:
				return North;
		}
	}

	public static function nextDirCCW(dir:Dir) {
		switch (dir) {
			case North:
				return West;
			case East:
				return North;
			case South:
				return East;
			case West:
				return South;
		}
	}

	public static function isPerpendicular(d1:Dir, d2:Dir):Bool {
		if ((d1 == North || d1 == South) && (d2 == East || d2 == West)) {
			return true;
		} else if ((d1 == East || d1 == West) && (d2 == North || d2 == South)) {
			return true;
		}

		return false;
	}

	public static function oppositeDir(dir:Dir):Dir {
		return nextDirCW(nextDirCW(dir));
	}

	// Random integer between 0 (inclusive) and max (exclusive)
	public static function randomInt(max:Int):Int {
		return Math.floor(max * Math.random());
	}

	public static function randomChoice<T>(arr:Array<T>):T {
		return arr[randomInt(arr.length)];
	}

	public static function dirToLevelFormat(dir:Dir):String {
		return switch (dir) {
			case North:
				"n";
			case East:
				"e";
			case South:
				"s";
			case West:
				"w";
		}
	}

	public static function resourceTypeToLevelFormat(resourceType:ResourceType):String {
		return switch (resourceType) {
			case Horn:
				"h";
			case FartCushion:
				"f";
		}
	}

	public static function cameraFadeOut(duration:Float = FADE_DURATION, ?onComplete:() -> Void = null) {
		FlxG.camera.fade(FlxColor.BLACK, duration, false, onComplete);
	}

	public static function cameraFadeIn(duration:Float = FADE_DURATION) {
		FlxG.camera.fade(FlxColor.BLACK, duration, true);
	}
}
