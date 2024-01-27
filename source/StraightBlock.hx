package;

import Block.Dir;
import flixel.util.FlxColor;

class StraightBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace("Game over");
		}

		for (r in resources) {
			r.move(dir);
		}
	}

	function setGraphic() {
		makeGraphic(Util.TILE_SIZE, Util.TILE_SIZE, FlxColor.GRAY);
	}

	function setGraphicDir(dir:Dir) {}
}
