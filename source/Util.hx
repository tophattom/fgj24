package;

class Util {
	public static inline var TILE_SIZE = 24;

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
}
