package;

import Block.Dir;
import flixel.util.FlxColor;

class CornerCWBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace("Game over");
		}

		var nextDir = Util.nextDirCW(dir);
		for (r in resources) {
			r.move(nextDir);
		}
	}

	function setGraphic() {
		makeGraphic(Util.TILE_SIZE, Util.TILE_SIZE, FlxColor.ORANGE);
	}

	function setGraphicDir(dir:Dir) {}
}
