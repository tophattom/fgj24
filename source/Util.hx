package;

import Block.Dir;

class Util {
	public static inline var TILE_SIZE = 24;
	public static inline var ANIMATION_FPS = 10;
	public static inline var ANIMATION_FPS_SLOW = 5;

	public static inline var GRID_WIDTH = 12;
	public static inline var GRID_HEIGHT = 12;

	public static inline var GRID_OFFSET_X = 0;
	public static inline var GRID_OFFSET_Y = 0;

	public static inline var TICK_INTERVAL = 0.5;

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
}
