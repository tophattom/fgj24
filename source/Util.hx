package;

import Block.Dir;

class Util {
	public static inline var TILE_SIZE = 24;
	public static inline var ANIMATION_FPS = 10;

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
}
