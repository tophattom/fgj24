package;

import flixel.util.FlxColor;

class CornerCCWBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace("Game over");
		}

		for (r in resources) {
			switch (dir) {
				case North:
					r.move(West);
				case South:
					r.move(East);
				case East:
					r.move(North);
				case West:
					r.move(South);
			}
		}
	}

	function setGraphic() {
		makeGraphic(Util.TILE_SIZE, Util.TILE_SIZE, FlxColor.PURPLE);
	}
}
