package;

import flixel.addons.display.shapes.FlxShapeGrid;
import flixel.util.FlxColor;

class BackgroundGrid extends FlxShapeGrid {
	public function new() {
		super(Util.GRID_OFFSET_X, Util.GRID_OFFSET_Y, Util.TILE_SIZE, Util.TILE_SIZE, Util.GRID_WIDTH, Util.GRID_HEIGHT,
			{ thickness: 1, color: FlxColor.BLACK }, FlxColor.TRANSPARENT);

		alpha = 0.2;
		blend = MULTIPLY;
	}
}
