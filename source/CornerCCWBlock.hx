package;

import Block.Dir;
import flixel.util.FlxColor;

class CornerCCWBlock extends Block {
	public function tick(resources:Array<Resource>) {
		if (resources.length > 1) {
			trace("Game over");
		}

		var nextDir = Util.nextDirCCW(dir);
		for (r in resources) {
			r.move(nextDir);
		}
	}

	function setGraphic() {
		makeGraphic(Util.TILE_SIZE, Util.TILE_SIZE, FlxColor.PURPLE);
	}

	function setGraphicDir(dir:Dir) {}
}
