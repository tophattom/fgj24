package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class BG extends FlxTypedGroup<FlxSprite> {
	public function new() {
		super();

		for (gridY in 0...Util.GRID_WIDTH) {
			for (gridX in 0...Util.GRID_HEIGHT) {
				var s = new BGTile(gridX, gridY);
				add(s);
			}
		}
	}
}
