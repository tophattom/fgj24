package;

import flixel.util.FlxColor;

class CornerCWBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace("Game over");
		}

		for (r in resources) {
			switch (dir) {
				case North:
					r.move(East);
				case South:
					r.move(West);
				case East:
					r.move(South);
				case West:
					r.move(North);
			}
		}
	}

	function setGraphic() {
		makeGraphic(Util.TILE_SIZE, Util.TILE_SIZE, FlxColor.ORANGE);
	}
}
